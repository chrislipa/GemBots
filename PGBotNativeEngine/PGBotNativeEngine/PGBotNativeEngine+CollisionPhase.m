//
//  PGBotNativeEngine+CollisionPhase.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/1/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine+CollisionPhase.h"
#import "Missile.h"
#import "GemBot.h"
#import "EngineUtility.h"
#import "EngineDefinitions.h"
#import "Missile+Interface.h"
#import "GemBot+Interface.h"
@implementation PGBotNativeEngine (CollisionPhase)

-(bool) doesMissile: (Missile*) missile hitRobot:(GemBot*) robot {
    return distance_between(missile, robot) <= distanceToInternalDistance(ROBOT_RADIUS);
}

-(void) checkForMissile:(Missile*) missile CollidingAgainstRobot:(GemBot*) robot {
    if  ([self doesMissile:missile hitRobot: robot]) {
        [missile explode];
    }
}

-(void) checkForMissileCollidingAgainstWall:(Missile*) missile {
    if (isObjectOutOfBounds(missile)) {
        
        [missile explode];
    }
}

-(void) checkForBotCollidingAgainstWall:(GemBot*) bot {
    if  (isObjectOutOfBounds(bot)) {
        
        [bot hadCollision];
    }
}



-(void) checkForRobot:(GemBot*) a collidingAgainstRobot:(GemBot*) b {
    if (distance_between(a, b) > distanceToInternalDistance(ROBOT_RADIUS*2)) {
        return;
    }
    
    [a hadCollision];
    [b hadCollision];
}

-(void) collisionPhase {
    for (GemBot* bot in robots) {
        if ([bot isAlive]) {
            bot.queued_dy = bot.queued_dx = 0;
        }
    }
    
    
    for (Missile* missile in missiles) {
        for (GemBot* bot in robots) {
            if ([bot isAlive]) {
                [self checkForMissile:missile CollidingAgainstRobot:bot];
            }
        }
        [self checkForMissileCollidingAgainstWall:missile];
    }
    for (GemBot* bot in robots) {
        if ([bot isAlive]) {
            [self checkForBotCollidingAgainstWall:bot];
        }
    }
    for (int i = 0; i < [robots count]; i++) {
        GemBot* a = [robots objectAtIndex:i];
        for (int j = i+1; j<[robots count] ; j++) {
            GemBot* b = [robots objectAtIndex:j];
            [self checkForRobot:a collidingAgainstRobot:b];
        }
    }
    
}
@end
