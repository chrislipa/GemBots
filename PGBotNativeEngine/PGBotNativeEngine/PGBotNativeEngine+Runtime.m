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
#import "PGBotNativeEngine+CollisionPhase.h"
#import "PGBotNativeEngine+CommPhase.h"
#import "PGBotNativeEngine+CheckForStartNextMatch.h"
#import "PGBotNativeEngine+CleanPhase.h"
#import "PGBotNativeEngine+Movement.h"
#import "PGBotNativeEngine+RobotDeath.h"
#import "PGBotNativeEngine+CheckForEndOfMatch.h"

@implementation PGBotNativeEngine (Runtime)
 

-(bool) dealWithExplosions {
    while (numberOfExplosionsAppliedThisCycle < [explosions count]) {
        [self dealDamagePhase];
        [self checkForRobotDeathPhase];
    }
    return ([self checkForEndMatchPhase]);
}

-(void) executeGameCycle {
    [self checkForStartNextMatchPhase];
    [self cleanPhase];
    [self robotCPUPhase];
    if ([self dealWithExplosions]) return;
    [self communicationPhase];
    [self movementPhase];
    [self collisionPhase];
    if ([self dealWithExplosions]) return;
    
}

@end
