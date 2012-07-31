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


//Reads in the robot at the given URL into the engine.
-(void) addRobot:(NSData*) robotData;

-(void) setRobot:(NSString*) sessionUniqueRobotIdentifier toTeam:(int) team;


-(void) removeRobot:(NSString*) sessionUniqueRobotIdentifier;

//Returns an array of GemBotDescriptions
-(NSArray*) robots;


-(void) setGameCycleTimeout:(int) maxNumberOfGameCycles;

-(void) setNumberOfMatches:(int) numberOfMatches;


-(void) startNewSetOfMatches;

-(void) stepGameCycle;

-(GameStateDescriptor*) currentGameStateDescription;

-(bool) isSetOfMatchesCompleted;

@end
