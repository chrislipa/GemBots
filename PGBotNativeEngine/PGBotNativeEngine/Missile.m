//
//  Missile.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "Missile.h"
#import "EngineUtility.h"
@implementation Missile
@synthesize internal_position;
@synthesize heading;
@synthesize engine;
@synthesize owner;
@synthesize internal_speed;
-(lint) internal_radius {
    return MISSILE_RADIUS;
}

-(int) x {
    return roundInternalDistanceToDistance(internal_position.x);
}
-(int) y {
    return roundInternalDistanceToDistance(internal_position.y);
}
-(void) dealWithCollisionWithObject:(NSObject<CollideableObject>*) object {
    
}

@end
