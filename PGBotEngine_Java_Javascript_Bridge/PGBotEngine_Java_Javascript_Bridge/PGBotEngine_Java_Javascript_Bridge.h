//
//  PGBotEngine_Java_Javascript_Bridge.h
//  PGBotEngine_Java_Javascript_Bridge
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGBotEngineProtocol.h"

@interface PGBotEngine_Java_Javascript_Bridge : NSObject <PGBotEngineProtocol> {
    JNIEnv *env;
    JavaVM *jvm;
    
}

-(id) init;


//Reads in the robot at the given URL into the engine.
-(void) addRobot:(NSData*) robotData;

-(void) setRobot:(NSString*) sessionUniqueRobotIdentifier:(NSString*)surid toTeam:(int) team;


//Returns an array of GemBotDescriptions
-(NSArray*) robots;


-(void) setGameCycleTimeout:(int) maxNumberOfGameCycles;

-(void) setNumberOfMatches:(int) numberOfMatches;


-(void) startNewSetOfMatches;

-(void) stepGameCycle;

-(GameStateDescriptor*) currentGameStateDescription;

-(bool) isSetOfMatchesCompleted;
@end
