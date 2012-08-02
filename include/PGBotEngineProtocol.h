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



-(NSObject<RobotDescription>*) addRobotFromSource:(NSData*) source;

-(void) setRobot:(NSObject<RobotDescription>*) robot toTeam:(int) team;


-(void) removeRobot:(NSObject<RobotDescription>*) robot;

//Returns an array of GemBotDescriptions
-(NSArray*) robots;


-(void) setGameCycleTimeout:(int) maxNumberOfGameCycles;


-(void) setNumberOfMatches:(int) numberOfMatches;


-(void) startNewSetOfMatches;

-(void) stepGameCycle;

-(NSObject<GameStateDescriptor>*) currentGameStateDescription;

-(bool) isSetOfMatchesCompleted;

@end
