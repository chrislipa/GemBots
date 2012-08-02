//
//  GemBot+Interface.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Interface.h"
#import "EngineDefinitions.h"
#import "EngineUtility.h"
#import "PGBotNativeEngine+Interface.h"
#import "Explosion.h"
#import "GemBot+Stats.h"
#import "GemBot+Movement.h"

@implementation GemBot (Interface)



-(void) dealInternalDamage:(lint) damage  {
    internal_armor -= damage;
}

-(void) die {
    internal_armor = 0;
    isAlive = NO;
    [engine createExplosionAt:self ofRadius:distanceToInternalDistance(ROBOT_DEATH_EXPLOSION_RADIUS)];
}

-(void) hadCollision {
    throttle = 0;
    speed_in_terms_of_throttle = 0;
    number_of_collisions++;
    lastCollisionTime = engine.gameCycle;
    
}
-(void) setScanTargetData {
    relativeHeadingOfMostRecentlyScannedTankAtTimeOfScan = anglemod(mostRecentlyScannedTank.heading - heading);
    speedOfMostRecentlyScannedTankAtTimeOfScan = mostRecentlyScannedTank.speedInCM;
}

@end
