//
//  engine_javascript_bridge.h
//  engine_javascript_bridge
//
//  Created by Christopher Lipa on 7/29/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameStateDescriptor.h"
#import <WebKit/WebKit.h>

@interface engine_javascript_bridge : NSObject {
    WebView* webview;
    WebScriptObject* webScriptObject;
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
