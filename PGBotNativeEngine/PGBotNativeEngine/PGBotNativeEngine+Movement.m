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
@implementation PGBotNativeEngine (Movement)


-(unit) timeUntilNextCollisionWithinTime:(unit)maxTime: (NSObject<CollideableObject>**) objectInCollisionA : (NSObject<CollideableObject>**) objectInCollisionB   {
    
    
    
}

-(bool) movementAndExplosionPhase {
    unit timeLeftToDealWith = convertGameCycleToUnit(1);
    
    
    while (timeLeftToDealWith > 0) {
        NSObject<CollideableObject> *objectInCollisionA=nil, *objectInCollisionB=nil;
        unit timeUntilNextCollision = [self timeUntilNextCollisionWithinTime: timeLeftToDealWith : &objectInCollisionA : &objectInCollisionB] ;
        
        [self updatePositionsForwardInTime:timeUntilNextCollision];
        timeLeftToDealWith -= timeUntilNextCollision;
        
        [objectInCollisionA dealWithCollisionWithObject:objectInCollisionB];
        [objectInCollisionB dealWithCollisionWithObject:objectInCollisionA];
        if (objectInCollisionA || objectInCollisionB) {
            if ([self dealWithExplosions]) {
                return YES;
            }
        }
        
        
        
    }
    return NO;
    
}


-(void) updatePositionsForwardInTime:(unit) dt {
    for (GemBot* gem in robots) {
        updatePositionForwardInTime(gem, dt);
    }
    for (Missile* m in missiles) {
        updatePositionForwardInTime(m, dt);
    }
    
}
@end
