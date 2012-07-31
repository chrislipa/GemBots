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
