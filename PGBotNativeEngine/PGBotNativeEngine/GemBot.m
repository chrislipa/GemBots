//
//  GemBot.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot.h"
#import "EngineUtility.h"
#import "SBJson.h"
#import "GemBot+Compiler.h"

@implementation GemBot
@synthesize sessionUniqueRobotIdentifier;

@synthesize name;
@synthesize descript;
@synthesize author;
@synthesize x;
@synthesize y;
@synthesize heading;
@synthesize armor;
@synthesize heat;
@synthesize kills;
@synthesize deaths;
@synthesize wins;
@synthesize loses;
@synthesize shieldOn;
@synthesize overburnOn;
@synthesize numberOfMissilesFired;
@synthesize numberOfMissilesConnected;
@synthesize numberOfMinesLayed;
@synthesize numberOfMinesConnected;
@synthesize numberOfTimesHit;
@synthesize team;
@synthesize compiledCorrectly;
@synthesize compileError;

@synthesize memory;


@synthesize scanner;
@synthesize weapon;


@synthesize engine;
@synthesize heatsinks;
@synthesize mines;
@synthesize shield;


-(void) setGemBotSource:(NSData *)p_source {
    source = p_source;
    [self compile];
}


-(id) initGemBotWithSource:(NSData*) p_source {
    if (self = [super init]) {
        [self setGemBotSource:p_source];
    }
    return self;
}

+(GemBot*) gemBotFromSource:(NSData*) source; {
    return [[self alloc] initGemBotWithSource:source];
}















-(void) reallocRAM:(int) targetSize {
    if (memory == NULL) {
        memory = (int*)malloc(targetSize * sizeof(int));
        memorySize = targetSize;
        for (int i = 0; i < memorySize; i++) {
            memory[i] = 0;
        }
    } else {
        int old_size = memorySize;
        int new_size = memorySize;
        while (new_size < targetSize) {
            new_size <<= 2;
        }
        new_size = MIN(new_size, BOT_MAX_MEMORY);
        memory = (int*)realloc(memory, targetSize * sizeof(int));
        memorySize = targetSize;
        for (int i = old_size; i < memorySize; i++) {
            memory[i] = 0;
        }
    }
}
                        





-(void) dealloc {

    free(memory);
}
@end
