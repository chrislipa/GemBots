//
//  Explosion.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameStateDescriptor.h"

@interface Explosion : NSObject <ExplosionDescription> {
    int centerX, centerY;
    int radius;
}

@property (readwrite,assign) int centerX;
@property (readwrite,assign) int centerY;
@property (readwrite,assign) int radius;

@end
