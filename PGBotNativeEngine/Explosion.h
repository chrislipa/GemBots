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
    unit internal_radius;
    position internal_position;
    unit damageMultiplier;
}
@property (readwrite,assign) unit damageMultiplier;
@property (readwrite,assign) position internal_position;
@property (readwrite,assign) unit internal_radius;



@end
