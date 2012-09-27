//
//  PGBotNativeEngine+Interface.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine+Interface.h"
#import "GemBot.h"
#import "EngineUtility.h"
#import "Scan.h"
#import "GemBot+Stats.h"
#import "Explosion.h"
#import "GemBot+Interface.h"
#import "GemBot+Communication.h"
#import "GemBot+Stats.h"
#include "stdlib.h"
@implementation PGBotNativeEngine (Interface)
-(int) numberOfRobotsAlive {
    int count = 0;
    for (GemBot* b in robots) {
        if ([b isAlive]) {
            count++;
        }
    }
    return count;
}

-(void) addSoundEffect:(NSString*)s {
    
    if (internal_soundEffectsInitiatedThisCycle_index == internal_soundEffectsInitiatedThisCycle_max) {
        NSString*__strong* new_internal_soundEffectsInitiatedThisCycle = (NSString* __strong*) calloc(internal_soundEffectsInitiatedThisCycle_max*2 , sizeof(NSString*));
        for (int i=0; i<internal_soundEffectsInitiatedThisCycle_index; i++) {
            new_internal_soundEffectsInitiatedThisCycle[i] = internal_soundEffectsInitiatedThisCycle[i];
        }
        free(internal_soundEffectsInitiatedThisCycle);
        internal_soundEffectsInitiatedThisCycle = new_internal_soundEffectsInitiatedThisCycle;
        internal_soundEffectsInitiatedThisCycle_max = internal_soundEffectsInitiatedThisCycle_max*2;
    }
    internal_soundEffectsInitiatedThisCycle[internal_soundEffectsInitiatedThisCycle_index++] = s;
}


-(void) addExplosion:(Explosion*)s{

    if (internal_explosions_index == internal_explosions_max) {
        Explosion*__strong* new_internal_explosions = (Explosion* __strong*) calloc(internal_explosions_max*2 ,sizeof(Explosion*));
        for (int i=0; i<internal_explosions_max; i++) {
            new_internal_explosions[i] = internal_explosions[i];
        }
        free(internal_explosions);
        internal_explosions = new_internal_explosions;
        internal_explosions_max = internal_explosions_max*2;
    }
    internal_explosions[internal_explosions_index++] = s;
}

-(void) addScan:(Scan*)s{
    
    if (internal_scans_index == internal_scans_max) {
        Scan*__strong* new_internal_scans = (Scan* __strong*) calloc(internal_scans_max*2, sizeof(Scan*));
        for (int i=0; i<internal_scans_index; i++) {
            new_internal_scans[i] = internal_scans[i];
        }
        free(internal_scans);
        internal_scans = new_internal_scans;
        internal_scans_max = internal_scans_max*2;
    }
    internal_scans[internal_scans_index++] = s;
}

-(int) computeRadarFromBot:(GemBot*)bot {
    unit internal_rv = -1;
    unit internalScanRadius = bot.internalScanRadius;
    for (GemBot* g in robots) {
        if ([g isAlive] && g != bot) {
            unit distance = internal_distance_between(g, bot);
            if (distance <= internalScanRadius) {
                int angle = turretRelativeInternalHeading(bot, g);
                if (angle <= bot.scan_arc_width / 2 || angle >= 256 - bot.scan_arc_width/2) {
                    [g notifyOfDetectionByOtherRobot];
                    if (distance < internal_rv || internal_rv == -1) {
                        internal_rv = distance;
                        bot.mostRecentlyScannedTank = g;
                    }
                }
            }
        }
    }
    if (internal_rv >= 0){
        [bot setScanTargetData];
    }
    if (!headlessMode) {
        Scan* scan = [[Scan alloc] init];
        scan.x = bot.x;
        scan.y = bot.y;
        scan.startAngle = anglemod( bot.turretHeading + bot.scan_arc_width/2.0);
        scan.endAngle = anglemod( bot.turretHeading - bot.scan_arc_width/2.0);
        scan.radius = roundInternalDistanceToDistance(internalScanRadius);
        scan.isWholeCircle = (bot.scan_arc_width >= 256);
        [self addScan:scan];
    }
    
    
    
    return internal_rv==-1?-1:roundInternalDistanceToDistance(internal_rv);
}

-(int) computeWideRadarFromBot:(GemBot*)bot {
    unit internal_rv = -1;
    unit radius = bot.internalScanRadius;
    for (GemBot* g in robots) {
        if ([g isAlive] && g != bot) {
            unit distance = internal_distance_between(g, bot);
            if (distance <= radius ) {
                [g notifyOfDetectionByOtherRobot];
                if (distance < internal_rv || internal_rv == -1) {
                    internal_rv = distance;
                    bot.mostRecentlyScannedTank = g;
                }
            }
        }
    }
    if (internal_rv >= 0){
        [bot setScanTargetData];
    }
    if (!headlessMode) {
        Scan* scan = [[Scan alloc] init];
        scan.x = bot.x;
        scan.y = bot.y;
        scan.radius = radius;
        scan.isWholeCircle = (bot.scan_arc_width >= 256);
        [self addScan:scan];
    }
    

    
    return internal_rv==-1?-1:roundInternalDistanceToDistance(internal_rv);
}


-(int) computeSonarFromBot:(GemBot*)bot {
    int internal_rv = -1;
    unit closest_distance = -1;
    for (GemBot* g in robots) {
        if ([g isAlive] && g != bot) {
            int distance = distance_between(g, bot);
            if (distance <= SONAR_RADIUS) {
                [g notifyOfDetectionByOtherRobot];
                if (distance < closest_distance || closest_distance == -1) {
                    internal_rv = heading(bot, g);
                    closest_distance = distance;
                }
            }
        }
    }
    if (closest_distance >= 0){
        [bot setScanTargetData];
    }
    if (!headlessMode) {
        Scan* scan = [[Scan alloc] init];
        scan.x = bot.x;
        scan.y = bot.y;
        scan.radius = SONAR_RADIUS;
        scan.isWholeCircle = (bot.scan_arc_width >= 256);
        [self addScan:scan];
    }
    
    return internal_rv;
}


-(void) layMineAt: (position)internal_position withOwner:(GemBot*) bot andRadius:(unit) internal_radius{
    Mine* mine = [[Mine alloc] init];
    mine.internal_position = internal_position;
    mine.owner = bot;
    mine.internal_radius = internal_radius;
    [mines addObject:mine];
}

-(void) createExplosionAt:(NSObject<TangibleObject>*) a ofRadius:(unit)r andDamageMultiplier:(unit)multiplier andOwner:(GemBot*) owner {
    Explosion* e = [[Explosion alloc] init];
    e.internal_position = a.internal_position;
    e.internal_radius = r;
    e.damageMultiplier = multiplier;
    e.owner = owner;
    [self addExplosion:e];
}

-(void) transmit:(int)x onChannel:(int) comm_channel {
    for (GemBot* b in robots) {
        if (b.comm_channel == comm_channel) {
            [b receiveCommunication:x];
        }
    }
}

-(void) removeMissile:(Missile*) missile {
    [missiles removeObject:missile];
}

-(void) removeMine:(Mine*) mine {
    [mines removeObject:mine];
}
-(void) fireMissileFrom:(position)internal_position inDirection:(int)heading withOwner:(GemBot*) bot {
    [self addSoundEffect:@"missile_fired"];
    Missile* m = [[Missile alloc] init];
    m.internal_position = internal_position;
    m.heading = heading;
    m.owner = bot;
    m.engine = self;
    m.internal_speed = [bot internal_speed_for_missile];
    m.damageMultipiler = [bot missileDamageMultiplier];
    [missiles addObject:m];
}
-(int) howManyMinesHaveThisOwner:(GemBot*) owner {
    int c = 0;
    for (Mine*m in mines) {
        if (m.owner == owner) c++;
    }
    return c;
}
-(void) detonateAllMinesWithOwner:(GemBot*) owner  {
    for (Mine*m in mines) {
        if (m.owner == owner) m.detonationTriggered = YES;
    }
}
@end
