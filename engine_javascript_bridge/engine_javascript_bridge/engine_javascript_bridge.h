//
//  engine_javascript_bridge.h
//  engine_javascript_bridge
//
//  Created by Christopher Lipa on 7/29/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameStateDescriptor.h"
@interface engine_javascript_bridge : NSObject

-(id) init;


//Reads in the robot at the given URL into the engine.
-(void) addRobot:(NSURL*) url;


//Returns an array of GemBotDescriptions
-(NSArray*) robots;


-(void) setGameCycleTimeout:(int) maxNumberOfGameCycles;

-(void) setNumberOfMatches:(int) numberOfMatches;


-(void) startGame;

-(void) stepGameCycle;

-(GameStateDescriptor*) currentGameStateDescription;

-(bool) isSetOfRoundsCompleted;

@end
