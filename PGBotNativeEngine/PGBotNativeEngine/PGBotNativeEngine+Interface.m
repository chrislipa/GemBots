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



-(int) computeRadarFromBot:(GemBot*)bot {
    lint internal_rv = -1;
    lint internalScanRadius = bot.internalScanRadius;
    for (GemBot* g in robots) {
        if ([g isAlive] && g != bot) {
            lint distance = internal_distance_between(g, bot);
            if (distance <= internalScanRadius) {
                int angle = turretRelativeHeading(bot, g);
                if (angle <= bot.scan_arc_width || angle >= 256 - bot.scan_arc_width) {
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
    Scan* scan = [[Scan alloc] init];
    scan.centerX = bot.x;
    scan.centerY = bot.y;
    scan.startAngle = anglemod( bot.turretHeading + bot.scan_arc_width);
    scan.endAngle = anglemod( bot.turretHeading - bot.scan_arc_width);
    scan.radius = roundInternalDistanceToDistance(internalScanRadius);
    [scans addObject:scan];
    
    return internal_rv==-1?-1:roundInternalDistanceToDistance(internal_rv);
}

-(int) computeWideRadarFromBot:(GemBot*)bot {
    lint internal_rv = -1;
    lint radius = bot.internalScanRadius;
    for (GemBot* g in robots) {
        if ([g isAlive] && g != bot) {
            lint distance = internal_distance_between(g, bot);
            if (distance <= radius ) {
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
    Scan* scan = [[Scan alloc] init];
    scan.centerX = bot.x;
    scan.centerY = bot.y;
    scan.radius = radius;
    [scans addObject:scan];
    
    return internal_rv==-1?-1:roundInternalDistanceToDistance(internal_rv);
}


-(int) computeSonarFromBot:(GemBot*)bot {
    lint internal_rv = -1;
    for (GemBot* g in robots) {
        if ([g isAlive] && g != bot) {
            int distance = distance_between(g, bot);
            if (distance <= SONAR_RADIUS) {
                if (distance < internal_rv || internal_rv == -1) {
                    internal_rv = distance;
                }
            }
        }
    }
    if (internal_rv >= 0){
        [bot setScanTargetData];
    }
    Scan* scan = [[Scan alloc] init];
    scan.centerX = bot.x;
    scan.centerY = bot.y;
    scan.radius = SONAR_RADIUS;
    [scans addObject:scan];
        
    return internal_rv==-1?-1:roundInternalDistanceToDistance(internal_rv);
}


-(void) createExplosionAt:(NSObject<TangibleObject>*) a ofRadius:(lint)r {
    Explosion* e = [[Explosion alloc] init];
    e.internal_position = a.internal_position;
    e.internal_radius = r;
}

-(void) transmit:(int)x onChannel:(int) comm_channel {
    for (GemBot* b in robots) {
        if (b.comm_channel == comm_channel) {
            [b receiveCommunication:x];
        }
    }
}

@end
