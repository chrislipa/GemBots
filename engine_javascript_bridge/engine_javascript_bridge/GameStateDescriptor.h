//
//  GameStateDescriptor.h
//  engine_javascript_bridge
//
//  Created by Christopher Lipa on 7/29/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RobotDescription : NSObject {
    NSString* sessionUniqueRobotIdentifier;
    int team;
    
    NSString* name;
    NSString* description;
    NSString* author;
    
    int linesOfCode;
    
    int x,y,heading;
    int armor;
    int heat;
    bool shieldOn;
    bool overburnOn;
    int kills, deaths, wins, losses;
    int numberOfMissilesFired, numberOfMissilesConnected;
    int numberOfMinesLayed, numberOfMinesConnected;
    int numberOfTimesHit;
    
    bool compiledCorrectly;
    NSString* compileError;
    
}
@property (readwrite,retain) NSString* sessionUniqueRobotIdentifier;

@property (readwrite,retain) NSString* name;
@property (readwrite,retain) NSString* description;
@property (readwrite,retain) NSString* author;

@property (readwrite,assign) int x;
@property (readwrite,assign) int y;
@property (readwrite,assign) int heading;
@property (readwrite,assign) int armor;
@property (readwrite,assign) int heat;
@property (readwrite,assign) int kills;
@property (readwrite,assign) int deaths;
@property (readwrite,assign) int wins;
@property (readwrite,assign) int loses;
@property (readwrite,assign) bool shieldOn;
@property (readwrite,assign) bool overburnOn;


@property (readwrite,assign) int numberOfMissilesFired;
@property (readwrite,assign) int numberOfMissilesConnected;
@property (readwrite,assign) int numberOfMinesLayed;
@property (readwrite,assign) int numberOfMinesConnected;
@property (readwrite,assign) int numberOfTimesHit;


@property (readwrite,assign) bool compiledCorrectly;
@property (readwrite,retain) NSString* compileError;
@property (readwrite,assign) int team;
@end


@interface MissileDescription : NSObject {
    int x,y,heading;
}
@property (readwrite,assign) int x;
@property (readwrite,assign) int y;
@property (readwrite,assign) int heading;
@end

@interface ScanDescription : NSObject {
    int centerX, centerY;
    int radius;
    int startAngle, endAngle;
}
@property (readwrite,assign) int centerX;
@property (readwrite,assign) int centerY;
@property (readwrite,assign) int radius;
@property (readwrite,assign) int startAngle;
@property (readwrite,assign) int endAngle;
@end

@interface ExplosionDescription : NSObject {
    int centerX, centerY;
    int radius;
}
@property (readwrite,assign) int centerX;
@property (readwrite,assign) int centerY;
@property (readwrite,assign) int radius;

@end




@interface GameStateDescriptor : NSObject {
    int currentMatch;
    int totalNumberOfMatches;
    int gameCycle;
    int maxGameCycles;
    NSMutableArray* robots;
    NSMutableArray* missiles;
    NSMutableArray* scans;
    NSMutableArray* explosions;
    NSMutableArray* soundEffectsInitiatedThisCycle;
}
@property (readwrite,assign) int currentMatch;
@property (readwrite,assign) int totalNumberOfMatches;
@property (readwrite,assign) int gameCycle;
@property (readwrite,assign) int maxGameCycles;
@property (readwrite,retain) NSMutableArray* robots;
@property (readwrite,retain) NSMutableArray* missiles;
@property (readwrite,retain) NSMutableArray* scans;
@property (readwrite,retain) NSMutableArray* explosions;
@property (readwrite,retain) NSMutableArray* soundEffectsInitiatedThisCycle;

@end
