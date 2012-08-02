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

@interface Mine : NSObject  <MineDescription, TangibleObject> {
    lint internal_x,internal_y,internal_radius;
    
    PGBotNativeEngine* engine;
    bool isAlive;
    GemBot* owner;
}
@property (readwrite,assign) lint internal_x;
@property (readwrite,assign) lint internal_y;
@property (readwrite,assign) lint internal_radius;
@property (readwrite,retain) PGBotNativeEngine* engine;
@property (readwrite,retain) GemBot* owner;




@end
