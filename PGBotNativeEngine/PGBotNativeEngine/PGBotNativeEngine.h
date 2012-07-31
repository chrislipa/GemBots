//
//  PGBotNativeEngine.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PGBotEngineProtocol.h"


@interface PGBotNativeEngine : NSObject <PGBotEngineProtocol,GameStateDescriptor> {
    int currentMatch;
    int totalNumberOfMatches;
    int gameCycle;
    int maxGameCycles;
    NSMutableArray* robots;
    NSMutableArray* missiles;
    NSMutableArray* scans;
    NSMutableArray* explosions;
    NSMutableArray* soundEffectsInitiatedThisCycle;
}

@property (readwrite,assign) int currentMatch;
@property (readwrite,assign) int totalNumberOfMatches;
@property (readwrite,assign) int gameCycle;
@property (readwrite,assign) int maxGameCycles;


-(id) init;


-(void) addRobotFromSourceCode:(NSString*) sourceCode;
-(void) addRobotFromBinary:(NSData*) robotData;


-(void) setRobot:(NSString*) sessionUniqueRobotIdentifier toTeam:(int) team;


-(void) removeRobot:(NSString*) sessionUniqueRobotIdentifier;

//Returns an array of GemBotDescriptions
-(NSArray*) robots;


-(void) setGameCycleTimeout:(int) maxNumberOfGameCycles;
-(void) setNumberOfMatches:(int) numberOfMatches;


-(void) startNewSetOfMatches;

-(void) stepGameCycle;

-(NSObject<GameStateDescriptor>*) currentGameStateDescription;

-(bool) isSetOfMatchesCompleted;


@end
