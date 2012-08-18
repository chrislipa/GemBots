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
#import "PGBotNativeEngine+Interface.h"

@implementation PGBotNativeEngine (DealDamage)

-(void) dealDamagePhase {
    
    for (; numberOfExplosionsAppliedThisCycle <internal_explosions_index; numberOfExplosionsAppliedThisCycle++) {
        [self addSoundEffect:@"missile_exploded"];
        Explosion* explosion = internal_explosions[numberOfExplosionsAppliedThisCycle];
        for (GemBot* bot in robots) {
            if ([bot isAlive]) {
                [self checkForExplosion: explosion damagingRobot:bot];
                
            }
        }
    }
}

-(void) checkForExplosion:(Explosion*) explosion damagingRobot:(GemBot*)bot {
    unit distance = distance_between(explosion, bot);
    if (distance >= explosion.internal_radius) {
        return;
    }
    unit internal_damage = explosion.internal_radius - distance;
    [bot dealInternalDamage:internal_damage : explosion.owner];
}

@end
