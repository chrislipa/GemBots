//
//  Wall.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/5/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "Wall.h"
#import "CollideableObject.h"

@implementation Wall

+( Wall* __strong ) newWall {
    static Wall* __strong static_wall = nil;
    if (static_wall == nil)
        static_wall = [[Wall alloc] init];
    return static_wall;
}

-(unit) internal_radius {
    return 0;
}
-(unit) internal_speed {
    return 0;
}

-(position) internal_position {
    position p;
    p.x = p.y = 0;
    return p;
}

-(int) heading {
    return 0;
}

-(void) dealWithCollisionWithObject:(NSObject<CollideableObject> *)object {
    
}

-(void) setInternal_position:(position)position {
    
}
@end

