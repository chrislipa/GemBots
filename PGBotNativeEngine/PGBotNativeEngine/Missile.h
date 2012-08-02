//
//  Missile.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameStateDescriptor.h"
#import "TangibleObject.h"
#import "OrientedObject.h"
#import "PGBotNativeEngine.h"
#import "GemBot.h"
@interface Missile : NSObject <MissileDescription, TangibleObject, OrientedObject> {
    int internal_x,internal_y,heading;
    PGBotNativeEngine* engine;
    bool isAlive;
    GemBot* owner;
}
@property (readwrite,assign) int internal_x;
@property (readwrite,assign) int internal_y;
@property (readwrite,assign) int heading;
@property (readwrite,retain) PGBotNativeEngine* engine;
@property (readwrite,retain) GemBot* owner;
@end