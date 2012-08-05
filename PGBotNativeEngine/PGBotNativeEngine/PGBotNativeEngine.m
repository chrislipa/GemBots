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
@implementation PGBotNativeEngine

@synthesize currentMatch;
@synthesize totalNumberOfMatches;
@synthesize gameCycle;
@synthesize maxGameCycles;


-(id) init {
    if  (self = [super init]) {
        
    }
    return self;
}


-(void) addRobot:(GemBot*) bot {
    bot.sessionUniqueRobotIdentifier = uuid();
    [robots addObject:bot];
}



-(void) setRobot:(NSString*) sessionUniqueRobotIdentifier toTeam:(int) team {
    
}


-(NSObject<RobotDescription>*) newRobot {
    return [GemBot gemBot];
}

-(void) recompileRobot:(NSObject<RobotDescription>*) bot  withSource:(NSData*) source {
    [((GemBot*)bot) recompileWithSource:source];
}

-(GemBot*) addRobotFromSource:(NSData*) source {
    GemBot* g = [GemBot gemBotFromSource:source];
    if (g) {
        [robots addObject:g];
    }
    return g;
}



-(void) removeRobot:(GemBot*) g {
    [robots removeObject:g];
}


-(NSArray*) robots {
    return robots;
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
}


-(void) startNewMatch {
    gameCycle = 0;
    missiles = [NSMutableArray array];
    [self resetAllRobotsForNextRound];
    [self giveRandomIDsToRobots];
    [self placeRobotsInRandomPositionsAndHeadings];
    isMatchCurrentlyActive = YES;
    isThisSetInitiated = YES;
    

}

-(void) stepGameCycle {
    
}

-(NSObject<GameStateDescriptor>*) currentGameStateDescription {
    return self;
}

-(bool) isSetOfMatchesCompleted {
    return NO;
}

-(bool) isMatchCurrentlyActive {
    return isMatchCurrentlyActive;
}
-(NSSet*) winnersOfLastMatch {
    return winnersOfLastMatch;
}


-(void) resetAllRobotsForNextRound {
    for (GemBot* b in robots) {
        [b cleanBetweenRounds];
    }
}

-(void) giveRandomIDsToRobots {
    for (int i = 0; i < [robots count]; i ++ ) {
        int candidateID;
        bool match = NO;
        do {
            candidateID = [random randomInt];
            for (int j = 0; j<i; j++) {
                if ([[robots objectAtIndex:j] unique_tank_id] == candidateID) {
                    match = YES;
                }
            }
        } while (match);
        GemBot* b = [robots objectAtIndex:i];
        b.unique_tank_id = candidateID;
    }
}

-(void) placeRobotsInRandomPositionsAndHeadings {
    for (int i = 0; i < [robots count]; i ++ ) {
        bool match = NO;
        GemBot* b = [robots objectAtIndex:i];
        do {
            b.internal_position = positionWithInts([random randomIntInInclusiveRange:0+ROBOT_RADIUS : SIZE_OF_ARENA-ROBOT_RADIUS] ,
                                                 [random randomIntInInclusiveRange:0+ROBOT_RADIUS : SIZE_OF_ARENA-ROBOT_RADIUS] );
            
            for (int j = 0; j<i; j++) {
                if (distance_between(b, [robots objectAtIndex:j]) < 2 * ROBOT_RADIUS) {
                    match = YES;
                }
            }
        } while (match);
    }
}

@end
