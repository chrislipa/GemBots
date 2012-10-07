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
#import "Wall.h"
#import "CollideableObject.h"
#import "Random.h"
@implementation PGBotNativeEngine (Movement)

-(void) pushRobotOffWall:(GemBot*) a :(Wall*) b {
    position p = a.internal_position;
    p.x = MAX(MIN(p.x, distanceToInternalDistance(SIZE_OF_ARENA)),distanceToInternalDistance(0));
    p.y = MAX(MIN(p.y, distanceToInternalDistance(SIZE_OF_ARENA)),distanceToInternalDistance(0));
    a.internal_position = p;
}

-(void) pushRobotsApart:(GemBot*) a : (GemBot*) b {
    unit current_distance = internal_distance_between(a, b);
    unit needed_distance = a.internal_radius + b.internal_radius;
    unit totalToMove = MAX(0, needed_distance - current_distance);
    unit amountToMoveEach = totalToMove * 0.501;
    unit dy = b.internal_position.y - a.internal_position.y;
    unit dx = b.internal_position.x - a.internal_position.x;
    unit dlen = sqrt(dy*dy+dx*dx);
    while (dlen == 0) {
        dx = [random randomIntInInclusiveRange:-100 :100];
        dy = [random randomIntInInclusiveRange:-100 :100];
        dlen = sqrt(dy*dy+dx*dx);
    }
    dx /= dlen;
    dy /= dlen;
    position newBPos;
    newBPos.x = b.internal_position.x + dx * amountToMoveEach;
    newBPos.y = b.internal_position.y + dy * amountToMoveEach;
    position newAPos;
    newAPos.x = a.internal_position.x - dx * amountToMoveEach;
    newAPos.y = a.internal_position.y - dy * amountToMoveEach;
    a.internal_position = newAPos;
    b.internal_position = newBPos;
}
-(void) pushObjectsApart:(NSObject<CollideableObject>*) a  :(NSObject<CollideableObject>*) b {
    if ([a isKindOfClass:[Wall class]] && [b isKindOfClass:[GemBot class]]) {
        [self pushRobotOffWall:(GemBot*)b:(Wall*)a];
    } else if ([b isKindOfClass:[Wall class]] && [a isKindOfClass:[GemBot class]]) {
        [self pushRobotOffWall:(GemBot*)a:(Wall*)(Wall*)b];
    } else if ([b isKindOfClass:[GemBot class]] && [a isKindOfClass:[GemBot class]]) {
        [self pushRobotsApart:(GemBot*)a:(GemBot*)b];
    }
}

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
            [self pushObjectsApart:objectInCollisionA:objectInCollisionB];
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
            position velocity = internal_velocity(gem);
            unit dx = velocity.x;
            unit dy = velocity.y;
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
