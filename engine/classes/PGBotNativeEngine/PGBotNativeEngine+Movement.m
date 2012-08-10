//
//  PGBotNativeEngine+MovementPhase.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/1/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine+Movement.h"
#import "GemBot.h"
#import "Missile.h"
#import "GemBot+Interface.h"
#import "GemBot+Movement.h"
#import "Missile+Interface.h"
#import "EngineUtility.h"
#import "PGBotNativeEngine+Explosions.h"
#import "CollideableObject.h"
#import "Mine.h"
#import "PGBotNativeEngine+CollisionDetection.h"
@implementation PGBotNativeEngine (Movement)




-(bool) movementAndExplosionPhase {
    
    
    unit timeLeftToDealWith = AMOUNT_OF_TIME_THAT_PASSES_PER_GAME_LOOP;
    while (timeLeftToDealWith > 0) {
        NSObject<CollideableObject> *objectInCollisionA=nil, *objectInCollisionB=nil;
        unit timeUntilNextCollision = [self timeUntilNextCollisionWithinTime: timeLeftToDealWith : &objectInCollisionA : &objectInCollisionB] ;
        
        [self updatePositionsForwardInTime:timeUntilNextCollision];
        timeLeftToDealWith -= timeUntilNextCollision;
        
        
        if (objectInCollisionA || objectInCollisionB) {
            [objectInCollisionA dealWithCollisionWithObject:objectInCollisionB];
            [objectInCollisionB dealWithCollisionWithObject:objectInCollisionA];
            if ([self dealWithExplosions]) {
                return YES;
            }
        }
    }
    return NO;
    
}

-(void) updateThrottlesPhase {
    for (GemBot* gem in robots) {
        if (gem.isAlive)
            [gem updateThrottle];
    }
}
-(void) updatePositionsForwardInTime:(unit) dt {
    for (GemBot* gem in robots) {
        if (gem.isAlive) {
            updatePositionForwardInTime(gem, dt);
            unit dx = gem.internal_position.x;
            unit dy = gem.internal_position.y;
            gem.internal_odometer += dt*sqrt(dx*dx+dy*dy);
        }
    }
    for (Missile* m in missiles) {
        updatePositionForwardInTime(m, dt);
    }
    
}



-(unit) timeUntilNextCollisionWithinTime:(unit)maxTime: (NSObject<CollideableObject>*  *) objectInCollisionA : (NSObject<CollideableObject>*  *) objectInCollisionB   {
    unit maximumCollisionTimeFound = maxTime;
    for (int i = 0; i< [robots count]; i++) {
        GemBot* robot = [robots objectAtIndex:i];
        if (!robot.isAlive)
            continue;
        for (int j = 0; j < i; j++) {
            GemBot* otherRobot = [robots objectAtIndex:j];
            if (!otherRobot.isAlive)
                continue;
            computeCircleCollision(robot, otherRobot, &maximumCollisionTimeFound, objectInCollisionA, objectInCollisionB);
        }
        for (Missile* missile in missiles) {
            if (missile.owner != robot) {
                computeCircleCollision(robot, missile, &maximumCollisionTimeFound, objectInCollisionA, objectInCollisionB);
            }
        }
        for (Mine* mine in mines) {
            if (mine.owner != robot) {
                computeCircleCollision(robot, mine, &maximumCollisionTimeFound, objectInCollisionA, objectInCollisionB);
            }
        }
        computeWallCollision(robot, &maximumCollisionTimeFound, objectInCollisionA, objectInCollisionB);
    }
    for (Missile* missile in missiles) {
        computeWallCollision(missile, &maximumCollisionTimeFound, objectInCollisionA, objectInCollisionB);
    }
    
    return maximumCollisionTimeFound;
}




@end
