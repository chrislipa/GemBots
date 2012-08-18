//
//  Mine.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/1/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//
#import "PGBotNativeEngine+Interface.h"
#import "Mine.h"
#import "EngineUtility.h"
#import "EngineDefinitions.h"
@implementation Mine
@synthesize internal_radius;
@synthesize internal_position;
@synthesize detonationTriggered;
@synthesize engine;
@synthesize owner;
-(int) x {
    return roundInternalDistanceToDistance(internal_position.x);
}
-(int) y {
    return roundInternalDistanceToDistance(internal_position.y);
}

-(int) radius {
    return roundInternalDistanceToDistance(internal_radius);
}

-(void) explode {
    [engine createExplosionAt:self ofRadius:MINE_EXPLOSION_RADIUS andDamageMultiplier:1.0 andOwner:owner];
    [engine removeMine:self];
}

-(void) dealWithCollisionWithObject:(NSObject<CollideableObject>*) object {
    [self explode];
}

-(unit) internal_speed {
    return distanceToInternalDistance(0);
}

-(int) heading {
    return 0;
}


@end
