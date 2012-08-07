//
//  Mine.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/1/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameStateDescriptor.h"
#import "TangibleObject.h"
#import "OrientedObject.h"
#import "PGBotNativeEngine.h"
#import "GemBot.h"

@interface Mine : NSObject  <MineDescription, TangibleObject,CollideableObject> {
    unit internal_radius;
    position internal_position;
    PGBotNativeEngine* engine;
    bool isAlive;
    GemBot* owner;
    bool detonationTriggered;
}
@property (readwrite,assign) bool detonationTriggered;
@property (readwrite,assign) position internal_position;
@property (readwrite,assign) unit internal_radius;
@property (readwrite,retain) PGBotNativeEngine* engine;
@property (readwrite,retain) GemBot* owner;




@end
