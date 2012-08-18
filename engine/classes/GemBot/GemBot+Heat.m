//
//  GemBot+Heat.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/6/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Heat.h"
#import "GemBot+Stats.h"
#import "GemBot+Interface.h"
#import "EngineUtility.h"

@implementation GemBot (Heat)
-(void) heatPhase {

    unit damage = [self damagePerGameCycle] ;
    if (damage) {
        [self dealInternalDamage:damage:nil];
    }
    unit deltaheat = [self deltaHeatPerGameCycle];
    [self dealInternalHeat:deltaheat];
    
    if (isShutDownFromHeat) {
        [self checkForReviveFromShutDownFromHeat];
    } else {
        [self checkForShutDownFromHeat];
    }
}

-(void) checkForReviveFromShutDownFromHeat {
    if (internal_heat <= internal_shutdown_temp - heatToInternalHeat(DIFFERENCE_BETWEEN_HEAT_SHUTOFF_AND_REVIVE) ) {
        isShutDownFromHeat = NO;
    }
}

-(void) shutDownFromHeat {
    isShutDownFromHeat = YES;
    throttle = 0;
    shieldOn = NO;
    overburnOn = NO;
}

-(void) checkForShutDownFromHeat {
    if (internal_heat >= internal_shutdown_temp) {
        [self shutDownFromHeat];
    }
}

@end
