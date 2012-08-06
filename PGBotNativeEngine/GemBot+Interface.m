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


-(void) updateThrottle {
    if (ABS(speed_in_terms_of_throttle -throttle) <= MAX_THROTTLE_MOVEMENT_PER_TURN) {
        speed_in_terms_of_throttle = throttle;
    } else  if (throttle > speed_in_terms_of_throttle) {
        speed_in_terms_of_throttle = MIN(MAX_THROTTLE, speed_in_terms_of_throttle+ MAX_THROTTLE_MOVEMENT_PER_TURN);
    } else {
        speed_in_terms_of_throttle = MIN(MAX_THROTTLE, speed_in_terms_of_throttle-MAX_THROTTLE_MOVEMENT_PER_TURN);
    }
    
    int angleOff = ABS(heading -desiredHeading);
    if  (angleOff > 128) { angleOff = 256-angleOff;}
    if (angleOff <= MAX_HEADING_MOVEMENT_PER_TURN) {
        heading = desiredHeading;
    } else  if (((desiredHeading - heading+256)&255) < ((heading -desiredHeading+256)&255)) {
        heading = (256+heading+ MAX_HEADING_MOVEMENT_PER_TURN)&255;
    } else {
        heading =  (256+heading-MAX_HEADING_MOVEMENT_PER_TURN)&255;
    }
    heading = heading;
}

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
