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

@synthesize queued_dx;
@synthesize queued_dy;
@synthesize name;
@synthesize descript;
@synthesize author;
@synthesize internal_x;
@synthesize internal_y;
@synthesize heading;
@synthesize unique_tank_id;
@synthesize desiredHeading;
@synthesize speed_in_terms_of_throttle;
@synthesize lastTimeFiredShotHitATank;
@synthesize mostRecentlyScannedTank;
@synthesize kills;
@synthesize deaths;
@synthesize wins;
@synthesize loses;
@synthesize shieldOn;
@synthesize overburnOn;
@synthesize lastCollisionTime;
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
@synthesize number_of_collisions;
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
@synthesize isAlive;
@synthesize internal_armor;
@synthesize speedOfMostRecentlyScannedTankAtTimeOfScan;
@synthesize relativeHeadingOfMostRecentlyScannedTankAtTimeOfScan;
@synthesize linesOfCode;
@synthesize color;

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









-(lint) internal_radius {
    return ROBOT_RADIUS;
}







-(int) armor {
    return roundInternalArmorToArmor(internal_armor);
}
-(int) heat {
    return roundInternalHeatToHeat(internal_heat);
}
-(int) x {
    return roundInternalDistanceToDistance(internal_x);
}
-(int) y {
    return roundInternalDistanceToDistance(internal_y);
}


-(void) dealloc {

    free(memory);
}
@end
