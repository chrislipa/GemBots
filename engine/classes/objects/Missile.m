//
//  Missile.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "Missile.h"
#import "EngineUtility.h"
#import "PGBotNativeEngine+Interface.h"
@implementation Missile
@synthesize internal_position;
@synthesize heading;
@synthesize engine;
@synthesize owner;
@synthesize internal_speed;
@synthesize damageMultipiler;
-(unit) internal_radius {
    return MISSILE_INTERNAL_RADIUS;
}

-(int) x {
    return roundInternalDistanceToDistance(internal_position.x);
}
-(int) y {
    return roundInternalDistanceToDistance(internal_position.y);
}
-(void) dealWithCollisionWithObject:(NSObject<CollideableObject>*) object {
    [engine createExplosionAt:self ofRadius:MISSILE_EXPLOSION_RADIUS andDamageMultiplier:damageMultipiler andOwner:owner];
    [engine removeMissile:self];
}


@end
