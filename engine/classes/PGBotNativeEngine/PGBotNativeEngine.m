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
    [robots removeObject:g];
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
    currentMatch = 1;
    
    isMatchCurrentlyActive = NO;
    hasSetStarted = YES;
    isThisSetInitiated = NO;
    hasSetEnded = NO;
    winnersOfLastMatch = [NSMutableSet set];
    isMatchCurrentlySetUp = NO;
    for (GemBot* bot in robots) {
        [bot resetForNewSetOfMatches];
    }
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
    if (!hasSetEnded) {
        currentMatch++;
    }
    
}

-(void) stepGameCycle:(NSArray*) trace {
top_of_step_game_cycle:;
    bool didFinishInstruction = NO;
    if (gameCycleStatePosition==0) {
        gameCycleStatePosition = 1;
        if (hasSetEnded || !hasSetStarted) {gameCycleStatePosition=0;gameCycleStateCPUCyclesExecuted=0; gameCycleStateRuntimePosition=0;return;}
        
    }
    if (gameCycleStatePosition ==1) {
        gameCycleStatePosition = 2;
        if (!isThisSetInitiated) { gameCycleStatePosition=0;gameCycleStateCPUCyclesExecuted=0;gameCycleStateRuntimePosition=0;[self startNewMatch]; return;}
    }
    
    if (gameCycleStatePosition==2) {
        gameCycleStatePosition = 3;
        gameCycle++;
    }
    
    if (gameCycleStatePosition==3) {
        finishedMatch = [self executeGameCycle:trace:&didFinishInstruction];
        if (gameCycleStateRuntimePosition == 3) {
            gameCycleStatePosition = 4;
        }
        
    }
    
    if (gameCycleStatePosition == 4) {
        gameCycleStatePosition=0;gameCycleStateCPUCyclesExecuted=0;gameCycleStateRuntimePosition=0;
        if (finishedMatch || gameCycle == maxGameCycles) {
            [self endMatch];
        }
    }
    if (!didFinishInstruction) {
        goto top_of_step_game_cycle;
    }
    
    
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
