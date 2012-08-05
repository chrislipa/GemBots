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
@interface Missile : NSObject <MissileDescription, TangibleObject, OrientedObject,CollideableObject,MoveableObject> {
    int heading;
    position internal_position;
    PGBotNativeEngine* engine;
    bool isAlive;
    GemBot* owner;
    unit internal_speed;
}
@property (readwrite,assign) unit internal_speed;
@property (readwrite,assign) position internal_position;
@property (readwrite,assign) int heading;
@property (readwrite,retain) PGBotNativeEngine* engine;
@property (readwrite,retain) GemBot* owner;
@end
