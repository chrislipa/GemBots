//
//  PGBotEngineProtocol.h
//  bot
//
//  Created by Christopher Lipa on 7/30/12.
//
//

#import <Foundation/Foundation.h>
#import "GameStateDescriptor.h"
@protocol PGBotEngineProtocol <NSObject>



-(id) init;



-(NSObject<RobotDescription>*) newRobot;
-(void) recompileRobot:(NSObject<RobotDescription>*) robot withSource:(NSData*) source;

-(void) setRobot:(NSObject<RobotDescription>*) robot toTeam:(int) team;
-(void) removeRobot:(NSObject<RobotDescription>*) robot;
//Returns an array of GemBotDescriptions
-(NSArray*) robots;
-(void) setGameCycleTimeout:(int) maxNumberOfGameCycles;
-(void) setNumberOfMatches:(int) numberOfMatches;


-(void) startNewSetOfMatches;

-(void) stepGameCycle;
-(int) gameCycle;
-(int) currentMatch;
-(NSObject<GameStateDescriptor>*) currentGameStateDescription;

-(bool) isSetOfMatchesCompleted;
-(bool) isMatchCurrentlyActive;
@end
