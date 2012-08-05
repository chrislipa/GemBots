//
//  CollideableObject.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/5/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EngineDefinitions.h"

@protocol CollideableObject <NSObject>
-(position) internal_position;
-(unit) internal_radius;
-(unit) internal_speed;
-(void) dealWithCollisionWithObject:(NSObject<CollideableObject>*) object;
@end
