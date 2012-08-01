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
    int rv = -1;
    int radius = bot.scanRadius;
    for (GemBot* g in robots) {
        if ([g isAlive] && g != bot) {
            int distance = distance_between(g, bot);
            if (distance <= radius ) {
                int angle = turretRelativeHeading(bot, g);
                if (angle <= bot.scan_arc_half_width || angle >= 256 - bot.scan_arc_half_width) {
                    if (distance < rv || rv == -1) {
                        rv = distance;
                        bot.mostRecentlyScannedTank = g;
                    }
                }
            }
        }
    }
    
    Scan* scan = [[Scan alloc] init];
    scan.centerX = bot.x;
    scan.centerY = bot.y;
    scan.startAngle = anglemod( bot.turretHeading + bot.scan_arc_half_width);
    scan.endAngle = anglemod( bot.turretHeading - bot.scan_arc_half_width);
    scan.radius = radius;
    [scans addObject:scan];
    
    return rv;
}

-(int) computeWideRadarFromBot:(GemBot*)bot {
    int rv = -1;
    int radius = bot.scanRadius;
    for (GemBot* g in robots) {
        if ([g isAlive] && g != bot) {
            int distance = distance_between(g, bot);
            if (distance <= radius ) {
                if (distance < rv || rv == -1) {
                    rv = distance;
                    bot.mostRecentlyScannedTank = g;
                }
            }
        }
    }
    
    Scan* scan = [[Scan alloc] init];
    scan.centerX = bot.x;
    scan.centerY = bot.y;
    scan.radius = radius;
    [scans addObject:scan];
    
    return rv;
}


-(int) computeSonarFromBot:(GemBot*)bot {
    int rv = -1;
    for (GemBot* g in robots) {
        if ([g isAlive] && g != bot) {
            int distance = distance_between(g, bot);
            if (distance <= SONAR_RADIUS) {
                if (distance < rv || rv == -1) {
                    rv = distance;
                }
            }
        }
    }
    
    Scan* scan = [[Scan alloc] init];
    scan.centerX = bot.x;
    scan.centerY = bot.y;
    scan.radius = SONAR_RADIUS;
    [scans addObject:scan];
        
    return rv;
}


@end
