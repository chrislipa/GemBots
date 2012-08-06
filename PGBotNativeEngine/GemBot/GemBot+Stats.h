//
//  GemBot+Stats.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot.h"

@interface GemBot (Stats)

-(lint) internalScanRadius;
-(lint) maxSpeedNumerator;
-(lint) maxSpeedDenomenator;
-(lint) initialInternalArmor;
-(unit) internal_speed_for_missile;
-(unit) missileDamageMultiplier;
-(int) numberOfMinesConfig;
-(unit) heatFromFiringMissile;
-(unit) damageFromHeatPerGameCycle;
-(unit) heatReductionPerGameCycle;
@end
