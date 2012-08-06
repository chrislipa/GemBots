//
//  Missile+Interface.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "Missile+Interface.h"
#import "EngineDefinitions.h"
#import "PGBotNativeEngine+Interface.h"
#import "EngineUtility.h"

@implementation Missile (Interface)
-(void) updatePosition {
    
}
-(void) explode {
    [engine createExplosionAt:self ofRadius:distanceToInternalDistance(MISSILE_EXPLOSION_RADIUS) andDamageMultiplier:1.0];
    isAlive = NO;
}
@end
