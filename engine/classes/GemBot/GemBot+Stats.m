//
//  GemBot+Stats.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Stats.h"
#import "EngineUtility.h"
#import "EngineDefinitions.h"
#import "gameparameters.h"

@implementation GemBot (Stats)

-(int) numberOfStartingMines {
    return number_of_mines_config_options[config_mines];
}

-(unit) initialInternalArmor {
    return armorToInternalArmor(INITIAL_ARMOR) * armor_percentage_config_options[config_armor];
}
-(unit) internalScanRadius {
    return distanceToInternalDistance(scan_radius_config_options[config_scanner]);
}


-(unit) heatFromFiringMissile {
    return heatToInternalHeat(HEAT_FROM_FIRING_MISSILE)*weapon_percentage_config_options[config_weapon]*(overburnOn?1.25:1);
}


-(unit) internalMaxSpeed {
    return distanceToInternalDistance( DEFAULT_ROBOT_SPEED )  * armor_speed_percentage_config_options[config_armor] * engine_config_options[config_engine] * (overburnOn?OVER_DRIVE_MODIFICATION_TO_SPEED:1.0) * indexInto(speedPercentageMultiplierFromHeat, internal_heat) ;
}

-(unit) internal_speed_for_missile {
    return (distanceToInternalDistance(DEFAULT_MISSILE_SPEED) )* weapon_percentage_config_options[config_weapon] * (overburnOn?OVER_DRIVE_MODIFICATION_TO_MISSILE_VELOCITY:1.0);
}
-(unit) missileDamageMultiplier {
    return weapon_percentage_config_options[config_weapon] * (overburnOn? OVER_DRIVE_MODIFICATION_TO_MISSILE_DAMAGE:1.0);
}

-(unit) damagePerGameCycle {
    unit damageFromHeatPerGameCycle = indexInto(damagePerTurnFromHeat, internal_heat);
    
    return damageFromHeatPerGameCycle;
}

-(unit) tankExplosionDamageMultiplier {
    return (overburnOn?OVER_DRIVE_MODIFICATION_TO_DAMAGE_FROM_TANK_EXPLOSION:1.0);
}

-(unit) deltaHeatPerGameCycle {

    unit heatDissapation=0 , heatIncrease = 0;
    if (ABS(throttle) <= THROTTLE_THRESHHOLD_FOR_SLOW_HEAT_DISSAPATION) {
        heatDissapation += heatToInternalHeat(HEAT_DISSAPATION_WHILE_SLOW);
    } else {
        heatDissapation += heatToInternalHeat(STANDARD_HEAT_DISSAPATION);
    }
    heatDissapation *= heatsink_config_options[config_heatsinks];
    if (overburnOn) {
        heatDissapation *= OVER_DRIVE_HEAT_GENERATION_MULTIPLIER;
    }
    if (shieldOn) {
        heatDissapation = 0;
        heatIncrease += HEAT_EACH_TURN_FROM_SHIELD;
    }
    return heatIncrease - heatDissapation;
}

@end
