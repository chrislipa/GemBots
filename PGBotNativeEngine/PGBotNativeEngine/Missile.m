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
@synthesize internal_x;
@synthesize internal_y;
@synthesize heading;
@synthesize engine;
@synthesize owner;
-(lint) internal_radius {
    return MISSILE_RADIUS;
}

-(int) x {
    return roundInternalDistanceToDistance(internal_x);
}
-(int) y {
    return roundInternalDistanceToDistance(internal_y);
}


@end