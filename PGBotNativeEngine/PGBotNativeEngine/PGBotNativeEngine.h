//
//  PGBotNativeEngine.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PGBotEngineProtocol.h"
#import "RandomProtocol.h"
#import "GameStateDescriptor.h"


@class GemBot;
@interface PGBotNativeEngine : NSObject <PGBotEngineProtocol,GameStateDescriptor> {
    // Persisted across Match sets
    NSObject<RandomProtocol>* random;
    NSMutableArray* robots;
    int totalNumberOfMatches;
    int maxGameCycles;
    
    
    // Initialized at beginning of match set
    int currentMatch;
    bool hasSetStarted;
    bool isThisSetInitiated;
    bool hasSetEnded;
    
    
    // Initialized every match;
    bool isMatchCurrentlyActive;
    bool isMatchCurrentlySetUp;

    int gameCycle;
    NSMutableSet* winnersOfLastMatch;
    NSMutableArray* missiles;
    
    // Initalized every cycle
    int numberOfExplosionsAppliedThisCycle;
    NSMutableArray* scans;
    NSMutableArray* explosions;
    NSMutableArray* soundEffectsInitiatedThisCycle;
    
    
   
    
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
