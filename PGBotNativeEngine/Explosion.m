//
//  Explosion.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "Explosion.h"
#import "EngineUtility.h"
@implementation Explosion
@synthesize internal_x;
@synthesize internal_y;
@synthesize internal_radius;


-(int) x {
    return roundInternalDistanceToDistance(internal_x);
}
-(int) y {
    return roundInternalDistanceToDistance(internal_y);
}
-(int) radius {
    return roundInternalDistanceToDistance(internal_radius);
}
@end
