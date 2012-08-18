//
//  script.m
//  Gem Bots
//
//  Created by Christopher Lipa on 8/17/12.
//
//

#import <Foundation/Foundation.h>

#import "gembotscript.h"

#import "PGBotEngineProtocol.h"
#import "MasterController.h"
#import <pthread.h>
const int numberOfThreads = 4;
static __strong NSMutableArray* engines = nil;
static pthread_t asyncThread[numberOfThreads];




void* runEngineLoop(NSObject<PGBotEngineProtocol>* engine) {
    @autoreleasepool {



    
    
    [engine startNewSetOfMatches];

    while (![engine isSetOfMatchesCompleted]) {
        @autoreleasepool {
            [engine stepGameCycle:nil];
        }
    

    }
    }

    return NULL;
    
}

void gembotscript(int argc, char** argv) {
    @autoreleasepool {
        
    
    int n;
    NSMutableArray* botPaths = nil;
    NSString* dir = nil;
    engines = [NSMutableArray array];
    CFTimeInterval start = CACurrentMediaTime();
    botPaths = [NSMutableArray array];

    NSString* outputPath = nil;
   
    n = 0;
        int numberOfBots = 0;
    for (int i = 0; i< argc; i++) {
        if (strcmp(argv[i],"-b")==0) {
            i++;
            numberOfBots++;
            [botPaths addObject:[NSString stringWithCString:argv[i] encoding:NSUTF8StringEncoding] ];
        } else if (strcmp(argv[i],"-o")==0) {
            i++;
            outputPath = [NSString stringWithCString:argv[i] encoding:NSUTF8StringEncoding];
        } else if (strcmp(argv[i],"-d")==0) {
            i++;
            dir = [NSString stringWithCString:argv[i] encoding:NSUTF8StringEncoding];
        } else if (strcmp(argv[i],"-n")==0) {

            i++;
            n = [[NSString stringWithCString:argv[i] encoding:NSUTF8StringEncoding] intValue];
        }
        
    }
    
    [[MasterController singleton] loadEngine];
    Class c = NSClassFromString(@"PGBotNativeEngine");
    
   
    NSMutableDictionary* botToPath = [NSMutableDictionary dictionary];
    
    

    
     
     
    
    for (int i =0; i<numberOfThreads; i++) {
        NSObject<PGBotEngineProtocol>* engine = [[c alloc] init];
        [engines addObject:engine];
        [engine setGameCycleTimeout:30000];
        [engine setNumberOfMatches:(n) /numberOfThreads+ ((n % numberOfThreads )< i)];
        int team = 1;
        for(NSString* path in botPaths) {
            NSString* pa = [dir stringByAppendingString:path];
            NSURL* url = [NSURL URLWithString:pa];
            NSData* data = [NSData dataWithContentsOfURL:url];
            
            NSObject<RobotDescription>* bot = [engine newRobot];
            [engine recompileRobot:bot withSource:data];
            [bot setTeam:team++];
            [botToPath setObject:path forKey:[NSValue valueWithPointer:(void*)bot]];
        }
        
    }
    int i = 0;
    for (NSObject<PGBotEngineProtocol>* engine in engines) {
        pthread_create(&asyncThread[i++], NULL, (void*)(void*)runEngineLoop, (__bridge void *)(engine));
    }
    

    
    for (int i =0; i<numberOfThreads; i++) {
        pthread_join(asyncThread[i], NULL);
    }
    
    
    NSMutableString* s = [NSMutableString string];
        
        int *wins, *losses, *kills, * deaths;
        double *armor;
        
        wins = malloc(numberOfBots*sizeof(int));
        losses = malloc(numberOfBots*sizeof(int));
        kills =  malloc(numberOfBots*sizeof(int));
        deaths = malloc(numberOfBots*sizeof(int));
        armor = malloc(numberOfBots*sizeof(double));
        
       
        for (int i = 0; i<numberOfBots; i++) {
            wins[i] = losses[i] = kills[i] = deaths[i] = 0;
            armor[i] = 0.0;
            for (NSObject<PGBotEngineProtocol>* engine in engines) {
                NSObject<RobotDescription>* bot = [[engine robots] objectAtIndex:i];
                wins[i] += bot.wins;
                losses[i] += bot.losses;
                kills[i] += bot.kills;
                deaths[i] += bot.deaths;
                armor[i] += bot.total_armor_remaining_from_set_of_matches;
            }
        }
        
        
        NSObject<PGBotEngineProtocol>* engine = [engines objectAtIndex:0];
        
        for (int i = 0; i < numberOfBots;i++) {
            NSObject<RobotDescription>* bot = [[engine robots] objectAtIndex:i];
            NSString* path = [botToPath objectForKey:[NSValue valueWithPointer:(void*)bot]];
            [s appendFormat:@"%@ %d %d %d %d %0.0f\n",path, wins[i],losses[i],kills[i],deaths[i],armor[i]];
        }
    
    NSURL* outputurl = [NSURL URLWithString:[dir stringByAppendingString:outputPath]];
    
    [s writeToURL:outputurl atomically:YES encoding:NSUTF8StringEncoding error:nil];
    CFTimeInterval end = CACurrentMediaTime();
    NSLog(@"time = %0.2f   %0.3f / cycle",(end-start),(end - start)/n);
}
    exit(0);
    
}




