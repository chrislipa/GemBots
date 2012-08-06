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
@synthesize internal_position;
@synthesize internal_radius;
@synthesize damageMultiplier;

-(int) x {
    return roundInternalDistanceToDistance(internal_position.x);
}
-(int) y {
    return roundInternalDistanceToDistance(internal_position.y);
}
-(int) radius {
    return roundInternalDistanceToDistance(internal_radius);
}
-(int) heading {
    return 0;
}
@end
