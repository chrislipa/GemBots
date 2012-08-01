//
//  GemBot.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot.h"
#import "EngineUtility.h"
#import "SBJson.h"
#import "GemBot+Compiler.h"

@implementation GemBot


@synthesize sessionUniqueRobotIdentifier;

@synthesize name;
@synthesize descript;
@synthesize author;
@synthesize internal_x;
@synthesize internal_y;
@synthesize heading;
@synthesize unique_tank_id;
@synthesize desiredHeading;
@synthesize internal_speed;
@synthesize lastTimeFiredShotHitATank;
@synthesize mostRecentlyScannedTank;
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
@synthesize turretHeading;
@synthesize memory;
@synthesize gameCycleOfLastDamage;

@synthesize config_scanner;
@synthesize config_weapon;
@synthesize config_engine;
@synthesize config_heatsinks;
@synthesize config_mines;
@synthesize config_shield;
@synthesize config_armor;
@synthesize keepshiftOn;
@synthesize throttle;
@synthesize scan_arc_half_width;
@synthesize alive;
-(void) setGemBotSource:(NSData *)p_source {
    source = p_source;
    [self compile];
}


-(id) initGemBotWithSource:(NSData*) p_source {
    if (self = [super init]) {
        [self setGemBotSource:p_source];
    }
    return self;
}

+(GemBot*) gemBotFromSource:(NSData*) source; {
    return [[self alloc] initGemBotWithSource:source];
}
















-(bool) isAlive {
    return alive;
}
-(int) armor {
    return (internal_armor + (ARMOR_MULTIPLIER/2))/ARMOR_MULTIPLIER;
}
-(int) heat {
    return (internal_heat + (HEAT_MULTIPLIER/2))/HEAT_MULTIPLIER;
}
-(int) x {
    return (internal_x + (DISTANCE_MULTIPLIER/2))/DISTANCE_MULTIPLIER;
}
-(int) y {
    return (internal_y + (DISTANCE_MULTIPLIER/2))/DISTANCE_MULTIPLIER;
}


-(void) dealloc {

    free(memory);
}
@end
