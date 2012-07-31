//
//  Missile.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameStateDescriptor.h"
@interface Missile : NSObject <MissileDescription> {
    int x,y,heading;
}
@property (readwrite,assign) int x;
@property (readwrite,assign) int y;
@property (readwrite,assign) int heading;

@end
