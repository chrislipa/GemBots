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

-(void) addRobotFromSourceCode:(NSString*) sourceCode {
    
}
-(void) addRobotFromBinary:(NSData*) robotData {
    
}


-(void) removeRobot:(NSString*) sessionUniqueRobotIdentifier {
    
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
    
}

-(void) setNumberOfMatches:(int) numberOfMatches {
    
}


-(void) startNewSetOfMatches {
    
}

-(void) stepGameCycle {
    
}

-(NSObject<GameStateDescriptor>*) currentGameStateDescription {
    return self;
}

-(bool) isSetOfMatchesCompleted {
    return NO;
}



@end
