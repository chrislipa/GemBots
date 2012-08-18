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



void gembotscript(int argc, char** argv) {
    CFTimeInterval start = CACurrentMediaTime();
    
    NSMutableArray* botPaths = [NSMutableArray array];
    NSString* outputPath = nil;
    NSString* dir = nil;
    int n = 0;
    
    for (int i = 0; i< argc; i++) {
        if (strcmp(argv[i],"-b")==0) {
            i++;
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
    NSObject<PGBotEngineProtocol>* engine = [[c alloc] init];

    NSMutableDictionary* botToPath = [NSMutableDictionary dictionary];
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
    [engine setGameCycleTimeout:30000];
    [engine setNumberOfMatches:n];
    [engine startNewSetOfMatches];
    
    while (![engine isSetOfMatchesCompleted]) {
        [engine stepGameCycle:nil];
    }
    
    NSMutableString* s = [NSMutableString string];
    for (NSObject<RobotDescription>* bot in [engine robots]) {
        NSString* path = [botToPath objectForKey:[NSValue valueWithPointer:(void*)bot]];
        [s appendFormat:@"%@ %d %d %d %d %0.0f\n",path,bot.wins,bot.losses,bot.kills,bot.deaths, bot.total_armor_remaining_from_set_of_matches];
    }
    NSURL* outputurl = [NSURL URLWithString:[dir stringByAppendingString:outputPath]];
    
    [s writeToURL:outputurl atomically:YES encoding:NSUTF8StringEncoding error:nil];
    CFTimeInterval end = CACurrentMediaTime();
    NSLog(@"time = %0.2f   %0.3f / cycle",(end-start),(end - start)/n);
    exit(0);
}

