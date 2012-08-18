//
//  PGBotNativeEngine+CollisionDetection.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/5/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine.h"
#import "CollideableObject.h"
#import "EngineUtility.h"


@interface PGBotNativeEngine (CollisionDetection)
extern inline void computeWallCollision(NSObject<CollideableObject>* a, unit* maximumCollisionTimeFound, NSObject<CollideableObject>*  * objectInCollisionA, NSObject<CollideableObject>*  * objectInCollisionB);
extern inline void computeCircleCollision(NSObject<CollideableObject>* a, NSObject<CollideableObject>* b, unit* maximumCollisionTimeFound,NSObject<CollideableObject>*  * objectInCollisionA,  NSObject<CollideableObject>*  * objectInCollisionB);
@end
