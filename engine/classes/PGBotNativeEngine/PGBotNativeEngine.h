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
#import "Scan.h"
#import "Explosion.h"
#import "PGBotEngineRules.h"
@class Scan;
@class Explosion;
@class GemBot;
@interface PGBotNativeEngine : NSObject <PGBotEngineProtocol,GameStateDescriptor> {
    // Rules:
    
    PGBotEngineRules* rules;
    
    
    // Persisted across Match sets
    NSObject<RandomProtocol>* random;
    NSMutableArray* robots;
    NSMutableArray* externalOrderingOfRobots;
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
    Scan *__strong* internal_scans;
    int internal_scans_index;
    int internal_scans_max;
    Explosion*__strong* internal_explosions;
    int internal_explosions_index;
    int internal_explosions_max;
    NSString*__strong* internal_soundEffectsInitiatedThisCycle;
    int internal_soundEffectsInitiatedThisCycle_index;
    int internal_soundEffectsInitiatedThisCycle_max;
    
    
    NSMutableArray* mines;
    
    
    bool finishedMatch;
    int gameCycleStatePosition;
    int gameCycleStateRuntimePosition;
    int gameCycleStateCPUCyclesExecuted;
    
    bool headlessMode;
    bool hadCollisionThisRound;
    
}

@property (readonly) PGBotEngineRules* rules;
@property (readwrite,assign)     bool headlessMode;
@property (readonly) NSObject<RandomProtocol>* random;
@property (readwrite,retain) NSMutableArray* mines;
@property (readwrite,assign) int currentMatch;
@property (readwrite,assign) int totalNumberOfMatches;
@property (readwrite,assign) int gameCycle;
@property (readwrite,assign) int maxGameCycles;


-(id) init;
-(void) notifyOfCollisionThisRound;
-(void) setRobot:(GemBot*) g toTeam:(int) team;


-(void) removeRobot:(GemBot*) g ;

//Returns an array of GemBotDescriptions
-(NSArray*) robots;


-(void) setGameCycleTimeout:(int) maxNumberOfGameCycles;
-(void) setNumberOfMatches:(int) numberOfMatches;


-(void) startNewSetOfMatches;

-(bool) stepGameCycle:(NSArray*) robots;

-(NSObject<GameStateDescriptor>*) currentGameStateDescription;

-(bool) isSetOfMatchesCompleted;

-(bool) isMatchCurrentlyActive;
-(NSSet*) winnersOfLastMatch;
@end
