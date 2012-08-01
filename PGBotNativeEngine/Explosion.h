//
//  Explosion.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameStateDescriptor.h"
#import "TangibleObject.h"
#import "EngineDefinitions.h"

@interface Explosion : NSObject <ExplosionDescription, TangibleObject> {
    lint internal_radius;
    lint internal_x;
    lint internal_y;
}

@property (readwrite,assign) lint internal_x;
@property (readwrite,assign) lint internal_y;
@property (readwrite,assign) lint internal_radius;



@end
