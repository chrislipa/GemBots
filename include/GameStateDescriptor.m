//
//  GameStateDescriptor.m
//  engine_javascript_bridge
//
//  Created by Christopher Lipa on 7/29/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GameStateDescriptor.h"
@implementation RobotDescription
@synthesize sessionUniqueRobotIdentifier;

@synthesize name;
@synthesize description;
@synthesize author;
@synthesize x;
@synthesize y;
@synthesize heading;
@synthesize armor;
@synthesize heat;
@synthesize kills;
@synthesize deaths;
@synthesize wins;
@synthesize loses;
@synthesize shieldOn;
@synthesize overburnOn;
@synthesize numberOfMissilesFired;
@synthesize numberOfMissilesConnected;
@synthesize numberOfMinesLayed;
@synthesize numberOfMinesConnected;
@synthesize numberOfTimesHit;
@synthesize team;
@synthesize compiledCorrectly;
@synthesize compileError;
@end


@implementation MissileDescription

@synthesize x;
@synthesize y;
@synthesize heading;

@end

@implementation ScanDescription
@synthesize centerX;
@synthesize centerY;
@synthesize radius;
@synthesize startAngle;
@synthesize endAngle;

@end


@implementation ExplosionDescription
@synthesize centerX;
@synthesize centerY;
@synthesize radius;


@end

@implementation GameStateDescriptor

@synthesize currentMatch;
@synthesize totalNumberOfMatches;
@synthesize gameCycle;
@synthesize maxGameCycles;
@synthesize robots;
@synthesize missiles;
@synthesize scans;
@synthesize explosions;
@synthesize soundEffectsInitiatedThisCycle;

@end
