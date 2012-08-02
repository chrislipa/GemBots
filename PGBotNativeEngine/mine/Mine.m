//
//  Mine.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/1/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "Mine.h"
#import "EngineUtility.h"
#import "EngineDefinitions.h"
@implementation Mine
@synthesize internal_radius;
@synthesize internal_x;
@synthesize internal_y;

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
