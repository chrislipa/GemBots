//
//  PGBotNativeEngine.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PGBotEngineProtocol.h"
#import "Random.h"

#import "GemBot.h"
@class GemBot;
@interface PGBotNativeEngine : NSObject <PGBotEngineProtocol,GameStateDescriptor> {
    
    // Book-keeping for match sets
    int currentMatch;
    int totalNumberOfMatches;
    int gameCycle;
    int maxGameCycles;
    bool isMatchCurrentlyActive;
    bool hasSetStarted;
    bool hasSetEnded;
    
    
    NSMutableArray* robots;
    NSMutableArray* missiles;
    NSMutableArray* scans;
    NSMutableArray* explosions;
    NSMutableArray* soundEffectsInitiatedThisCycle;
    
    Random* random;
    NSMutableSet* winnersOfLastMatch;
    int numberOfExplosionsAppliedThisCycle;
}

@property (readwrite,assign) int currentMatch;
@property (readwrite,assign) int totalNumberOfMatches;
@property (readwrite,assign) int gameCycle;
@property (readwrite,assign) int maxGameCycles;


-(id) init;

-(void) setRobot:(GemBot*) g toTeam:(int) team;


-(void) removeRobot:(GemBot*) g ;

//Returns an array of GemBotDescriptions
-(NSArray*) robots;


-(void) setGameCycleTimeout:(int) maxNumberOfGameCycles;
-(void) setNumberOfMatches:(int) numberOfMatches;


-(void) startNewSetOfMatches;

-(void) stepGameCycle;

-(NSObject<GameStateDescriptor>*) currentGameStateDescription;

-(bool) isSetOfMatchesCompleted;

-(bool) isMatchCurrentlyActive;
-(NSSet*) winnersOfLastMatch;
@end
