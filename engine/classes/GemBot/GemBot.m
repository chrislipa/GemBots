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
#import "GemBot+Movement.h"
#import "GemBot+Stats.h"
#import "EngineDefinitions.h"
#import "EngineUtility.h"
#import "Wall.h"
#import "GameParameters.h"
#import "GemBot+Collision.h"
#import "EngineDefinitions.h"
#import "EngineUtility.h"
#import "GemBot+Disassembly.h"
#import "GemBot.h"
#import "GemBot+Memory.h"


@implementation GemBot
@synthesize diedLastTurn;
@synthesize hasEverBeenDetected;
@synthesize strings;
@synthesize total_armor_remaining_from_set_of_matches;
@synthesize order;
@synthesize userVariables;
@synthesize orderingInt;
@synthesize source;
@synthesize hasEverCollided;
@synthesize hasFiredShotEverHitTank;
@synthesize everTakenDamage;
@synthesize color;
@synthesize sessionUniqueRobotIdentifier;
@synthesize numberOfCompileErrors;
@synthesize numberOfCompileWarnings;
@synthesize compileErrors;
@synthesize queued_dx;
@synthesize queued_dy;
@synthesize name;
@synthesize descript;
@synthesize author;
@synthesize internal_position;
@synthesize heading;
@synthesize unique_tank_id;
@synthesize desiredHeading;
@synthesize speed_in_terms_of_throttle;
@synthesize lastTimeFiredShotHitATank;
@synthesize mostRecentlyScannedTank;
@synthesize kills;
@synthesize deaths;
@synthesize wins;
@synthesize losses;
@synthesize internal_odometer;
@synthesize shieldOn;
@synthesize overburnOn;
@synthesize lastCollisionTime;
@synthesize numberOfMissilesFired;
@synthesize numberOfMissilesConnected;
@synthesize numberOfMinesLayed;
@synthesize numberOfMinesRemaining;
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
@synthesize engine;
@synthesize keepshiftOn;
@synthesize throttle;
@synthesize scan_arc_width;
@synthesize isAlive;
@synthesize internal_armor;
@synthesize speedOfMostRecentlyScannedTankAtTimeOfScan;
@synthesize relativeHeadingOfMostRecentlyScannedTankAtTimeOfScan;
@synthesize linesOfCode;
@synthesize markForSelfDestruction;
@synthesize comm_channel;
@synthesize isShutDownFromHeat;

-(void) setGemBotSource:(NSData *)p_source {
    source = p_source;
    [self compile];
}


-(id) init {
    if (self = [super init]) {
        sessionUniqueRobotIdentifier = uuid();
    }
    return self;
}

-(id) initGemBotWithSource:(NSData*) p_source {
    if (self = [self init]) {
        [self setGemBotSource:p_source];
    }
    return self;
}

+(GemBot*) gemBot {
    return [[self alloc] init];
}


+(GemBot*) gemBotFromSource:(NSData*)source {
    return [[self alloc] initGemBotWithSource:source];
}

-(void) recompileWithSource:(NSData*) data {
    [self setGemBotSource:data];
}









-(unit) internal_radius {
    double ROBOT_RADIUS = engine.rules.robotRadius;
    return ROBOT_RADIUS;
}




-(NSURL*) url {
    return nil;
}


-(int) armor {
    return (int)round((STARTING_ARMOR_FOR_UI * internal_armor) / [self initialInternalArmor]);
}
-(int) heat {
    return roundInternalHeatToHeat(internal_heat);
}
-(int) x {
    return roundInternalDistanceToDistance(internal_position.x);
}
-(int) y {
    return roundInternalDistanceToDistance(internal_position.y);
}


-(void) dealloc {
    free(memory);
    free(romMemory);
}

-(unit) internal_speed {
    return ((unit)speed_in_terms_of_throttle)/((unit)MAX_THROTTLE) *[self internalMaxSpeed];
}

-(void) dealWithCollisionWithObject:(NSObject<CollideableObject>*) object {
    if ([object isKindOfClass:[Wall class]] || [object isKindOfClass:[GemBot class]]) {
        [self hadCollision:object ];
    }
}


-(void) executionError:(NSString*) str {
    [self executionLog:[NSString stringWithFormat:@"ERROR: %@", str]];
}
-(void) executionLog:(NSString*) str {
    if  (indexIntoInternalLoggingArray >= internalLoggingArray.count) {
        [internalLoggingArray addObject:str];
    } else {
        [internalLoggingArray replaceObjectAtIndex:indexIntoInternalLoggingArray withObject:str];
    }
    indexIntoInternalLoggingArray  = (indexIntoInternalLoggingArray+1) % 10;
}


-(int) speedInCM {
    return [self internalMaxSpeed] * speed_in_terms_of_throttle / MAX_THROTTLE * NUMBER_OF_CM_IN_M;
}

-(int) odometer {
    return roundInternalDistanceToDistance(internal_odometer);
}
-(int) timeSinceDetection {
    return  (hasEverBeenDetected?[engine gameCycle] - gameCycleOfLastDetection:MAX_ROBOT_MEMORY_VALUE);
}



-(NSArray*) disassembledSourceAtAddress:(int)pc{
    return [self internalDisassembledSourceAtAddress:pc];
}

-(int) getMemory:(int) addr {
    return getMemory(memory,memorySize, addr);
}

-(void) setMemory:(int) addr :(int) value {
    setMemory(&memory, &memorySize, addr, value);
}

-(int) numberOfLogs {
    return (int)internalLoggingArray.count;
}
-(NSString*) logNumber:(int) index {
    index = ((indexIntoInternalLoggingArray-1-index % 10)+10)%10;
    if (index >  (int)internalLoggingArray.count) {
        return nil;
    }
    return [internalLoggingArray objectAtIndex: index];
}

@end
