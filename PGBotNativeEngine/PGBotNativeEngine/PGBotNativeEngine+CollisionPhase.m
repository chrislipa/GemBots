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

@implementation PGBotNativeEngine (CollisionPhase)


-(void) collisionPhase {
    
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
            [self checkForCollision]
        }
    }
    
}
@end
