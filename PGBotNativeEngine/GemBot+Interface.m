//
//  GemBot+Interface.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Interface.h"
#import "EngineDefinitions.h"
#import "EngineUtility.h"
#import "PGBotNativeEngine+Interface.h"
#import "Explosion.h"
#import "GemBot+Stats.h"
#import "GemBot+Movement.h"

@implementation GemBot (Interface)



-(void) dealInternalDamage:(unit) damage  {
    internal_armor -= damage;
}

-(void) die {
    internal_armor = 0;
    internal_heat = 0;
    isAlive = NO;
}


-(void) setScanTargetData {
    relativeHeadingOfMostRecentlyScannedTankAtTimeOfScan = anglemod(mostRecentlyScannedTank.heading - heading);
    speedOfMostRecentlyScannedTankAtTimeOfScan = mostRecentlyScannedTank.speedInCM;
}

@end
