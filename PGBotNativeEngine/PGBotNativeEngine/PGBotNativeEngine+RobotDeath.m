//
//  PGBotNativeEngine+RobotDeath.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/1/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine+RobotDeath.h"
#import "GemBot.h"
#import "GemBot+Interface.h"
#import "EngineUtility.h"
#import "EngineDefinitions.h"

@implementation PGBotNativeEngine (RobotDeath)

-(void) checkForRobotDeathPhase {
    for (GemBot* bot in robots) {
        if ([bot isAlive] && bot.internal_armor <= 0) {
            [bot die];
            int explosion_internalRadius = distanceToInternalDistance(ROBOT_DEATH_EXPLOSION_RADIUS);
            [self spawnExplosionAt:bot ofRadius:explosion_internalRadius];
        }
    }
}
@end
