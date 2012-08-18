//
//  PGBotNativeEngine+Explosions.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/5/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine+Explosions.h"
#import "PGBotNativeEngine+Runtime.h"
#import "GemBot+Runtime.h"
#import "Missile.h"
#import "GemBot+Communication.h"
#import "GemBot+Interface.h"
#import "Missile+Interface.h"
#import "Explosion.h"
#import "PGBotNativeEngine+DealDamage.h"
#import "PGBotNativeEngine+RobotCPUPhase.h"

#import "PGBotNativeEngine+CommPhase.h"

#import "PGBotNativeEngine+CleanPhase.h"
#import "PGBotNativeEngine+Movement.h"
#import "PGBotNativeEngine+RobotDeath.h"
#import "PGBotNativeEngine+CheckForEndOfMatch.h"
#import "PGBotNativeEngine+Interface.h"


@implementation PGBotNativeEngine (Explosions)
-(bool) dealWithExplosions {
    while (numberOfExplosionsAppliedThisCycle < internal_explosions_index) {
        [self dealDamagePhase];
        [self checkForRobotDeathPhase];
    }
    return ([self checkForEndMatchPhase]);
}


-(bool) checkForAndDealWithSelfDestructingRobots {
    for (GemBot* b in robots) {
        if (b.markForSelfDestruction) {
            [b die];
        }
    }
    return [self dealWithExplosions];
}

@end
