//
//  PGBotNativeEngine+Runtime.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

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
#import "PGBotNativeEngine+Explosions.h" 
#import "PGBotNativeEngine+Heat.h"

@implementation PGBotNativeEngine (Runtime)
 



-(bool) executeGameCycle {
    [self cleanPhase];
    [self robotCPUPhase];
    [self heatPhase];
    if ([self checkForAndDealWithSelfDestructingRobots]) return YES;
    [self communicationPhase];
    [self updateThrottlesPhase];
    if ([self movementAndExplosionPhase]) return YES;
    return NO;
}

@end
