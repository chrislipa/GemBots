//
//  engine_javascript_bridge.m
//  engine_javascript_bridge
//
//  Created by Christopher Lipa on 7/29/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "engine_javascript_bridge.h"

@implementation engine_javascript_bridge


-(id) init {
    if  (self = [super init]) {
        webview = [[WebView alloc] init];
        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"pathToEngine"]];
        [[webview mainFrame] loadRequest:request];
        webScriptObject = [webview windowScriptObject];
    }
    return self;
}


//Reads in the robot at the given URL into the engine.
-(void) addRobot:(NSData*) robotData {
    [webScriptObject callWebScriptMethod:@"addRobot" withArguments:[NSArray arrayWithObject:robotData]];
}

-(void) setRobot:(NSString*) sessionUniqueRobotIdentifier:(NSString*)surid toTeam:(int) team {
    [webScriptObject callWebScriptMethod:@"setTeam" withArguments:[NSArray arrayWithObjects:surid,team,nil]];
}


//Returns an array of GemBotDescriptions
-(NSArray*) robots {
    
    return [NSArray array];
}


-(void) setGameCycleTimeout:(int) maxNumberOfGameCycles {
    
}

-(void) setNumberOfMatches:(int) numberOfMatches {
    
}


-(void) startGame {
    
}

-(void) stepGameCycle {
    
}

-(GameStateDescriptor*) currentGameStateDescription {
    return nil;
}

-(bool) isSetOfMatchesCompleted {
    return NO;
}

@end
