//
//  GemBot+Stats.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot.h"


@interface GemBot (Stats)

-(unit) internalScanRadius;
-(unit) internalMaxSpeed;
-(unit) initialInternalArmor;
-(unit) internal_speed_for_missile;
-(unit) missileDamageMultiplier;
-(int)  numberOfStartingMines;
-(unit) heatFromFiringMissile;
-(unit) damagePerGameCycle;
-(unit) tankExplosionDamageMultiplier;
-(unit) deltaHeatPerGameCycle ;
@end
