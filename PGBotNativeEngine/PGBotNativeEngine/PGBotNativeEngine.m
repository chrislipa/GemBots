//
//  PGBotNativeEngine.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine.h"
#import "EngineUtility.h"
#import "GemBot.h"
#import "GemBot+Reset.h"
#import "EngineUtility.h"
#import "EngineDefinitions.h"
#import "PGBotNativeEngine+GameManagement.h"
#import "PGBotNativeEngine+Runtime.h"
#import "Random.h"
#import "Opcode.h"
@implementation PGBotNativeEngine
@synthesize random;
@synthesize currentMatch;
@synthesize totalNumberOfMatches;
@synthesize gameCycle;
@synthesize maxGameCycles;

@synthesize mines;

-(void) testSelector:(SEL) sel {
    GemBot* gem = [[GemBot alloc] init];
    if (![gem respondsToSelector:sel]) {
        NSLog(@"Select %@ has not been implemented.",NSStringFromSelector(sel));
    }
}

-(void) powerOnSelfTest {
    for(Opcode* op in opcodeArray()) {
        if ((NSNull*)op != [NSNull null])
            [self testSelector:op.selector];
    }
    for(Device* op in readDeviceArray()) {
        if ((NSNull*)op != [NSNull null])
            [self testSelector:op.selector];
    }
    for(Device* op in writeDeviceArray()) {
        if ((NSNull*)op != [NSNull null])
            [self testSelector:op.selector];
    }
    for(SystemCall* op in systemCallsArray()) {
        if ((NSNull*)op != [NSNull null])
            [self testSelector:op.selector];
    }
}
-(id) init {
    if  (self = [super init]) {
        random = [[Random alloc] init];

        externalOrderingOfRobots = [NSMutableArray array];
#ifdef DEBUG
        [self powerOnSelfTest];
#endif
    }
    return self;
}


-(void) addRobot:(GemBot*) bot {
    bot.sessionUniqueRobotIdentifier = uuid();
    [externalOrderingOfRobots addObject:bot];
}



-(void) setRobot:(NSString*) sessionUniqueRobotIdentifier toTeam:(int) team {
    
}


-(NSObject<RobotDescription>*) newRobot {
    GemBot* g = [GemBot gemBot];
    g.engine = self;
    [externalOrderingOfRobots addObject:g];
    return g;
}

-(void) recompileRobot:(NSObject<RobotDescription>*) bot  withSource:(NSData*) source {
    [((GemBot*)bot) recompileWithSource:source];
}



-(void) removeRobot:(GemBot*) g {
    [externalOrderingOfRobots removeObject:g];
}


-(NSArray*) robots {
    return externalOrderingOfRobots;
}
-(NSArray*) missiles {
    return missiles;
}
-(NSArray*) scans {
    return scans;
}
-(NSArray*) explosions {
    return explosions;
}

-(NSArray*) soundEffectsInitiatedThisCycle {
    return soundEffectsInitiatedThisCycle;
}

-(void) setGameCycleTimeout:(int) maxNumberOfGameCycles {
    maxGameCycles = maxNumberOfGameCycles;
}

-(void) setNumberOfMatches:(int) numberOfMatches {
    totalNumberOfMatches = numberOfMatches;
}


-(void) startNewSetOfMatches {
    currentMatch = 0;
    
    isMatchCurrentlyActive = NO;
    hasSetStarted = YES;
    isThisSetInitiated = NO;
    hasSetEnded = NO;
    winnersOfLastMatch = [NSMutableSet set];
    isMatchCurrentlySetUp = NO;
}

-(void) startNewMatch {
    [self startNewMatchInternal];
}

-(void) endMatch {
    [self giveCreditForWinsAndLosses];
    isMatchCurrentlyActive = NO;
    isThisSetInitiated = NO;
    isMatchCurrentlySetUp = NO;
    hasSetEnded = (currentMatch ==totalNumberOfMatches);
}

-(void) stepGameCycle {
    if (hasSetEnded || !hasSetStarted) {return;}
    if (!isThisSetInitiated) { [self startNewMatch]; return;}
    if ([self executeGameCycle]) {[self endMatch];}
}

-(NSObject<GameStateDescriptor>*) currentGameStateDescription {
    return self;
}

-(bool) isSetOfMatchesCompleted {
    return hasSetEnded;
}

-(bool) isMatchCurrentlyActive {
    return isMatchCurrentlyActive;
}
-(NSSet*) winnersOfLastMatch {
    return winnersOfLastMatch;
}




@end
