//
//  PGBotNativeEngine+DealDamage.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/1/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine+DealDamage.h"
#import "Explosion.h"
#import "GemBot.h"
#import "EngineUtility.h"
#import "GemBot+Interface.h"
@implementation PGBotNativeEngine (DealDamage)

-(void) dealDamagePhase {
    for (GemBot* bot in robots) {
        if ([bot isAlive]) {
            for (Explosion* explosion in explosions) {
                [self checkForExplosion: explosion damagingRobot:bot];
            }
        }
    }
}

-(void) checkForExplosion:(Explosion*) explosion damagingRobot:(GemBot*)bot {
    lint distance = distance_between(explosion, bot);
    if (distance >= explosion.internal_radius) {
        return;
    }
    lint internal_damage = explosion.internal_radius - distance;
    [bot dealInternalDamage:internal_damage];
}

@end
