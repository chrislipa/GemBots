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

const int scan_radius_config_options[6] = {250,500,750,1000,1250,1500};
const lint weapon_percentage_config_options[6] = {50,80,100,120,135,150};
const lint number_of_mines_config_options[6] = {2,4,6,10,16,24};
const int armor_percentage_config_options[6] = {50,66,100,120,130,150};
const lint armor_speed_percentage_config_options[6] = {133,120,100,85,75,66};
const lint shield_config_options[6] = {0,0,0,67,50,33};
const lint heatsink_config_options[6] = {750,1000,1125,1250,1330,1500};
const lint engine_config_options[6] = {50,80,100,120,135,150};


const lint speedPercentageMultiplierFromHeat[5][2] ={
    {80*HEAT_MULTIPLIER,100},
    {100*HEAT_MULTIPLIER,98},
    {150*HEAT_MULTIPLIER,85},
    {200*HEAT_MULTIPLIER,70},
    {INT64_MAX,50}
};
    


lint indexInto(const lint a[][2], lint v) {
    for (int i =0; ; i++) {
        if (v < a[i][0]) {
            return a[i][1];
        }
    }
    return 0;
}


@implementation GemBot (Stats)
-(lint) initialInternalArmor {
    return armorToInternalArmor(INITIAL_ARMOR * armor_percentage_config_options[config_armor])/100;
}
-(lint) internalScanRadius {
    return distanceToInternalDistance(scan_radius_config_options[config_scanner]);
}




-(lint) maxSpeedNumerator {
    return distanceToInternalDistance( SPEED_OF_ROBOT )  * armor_speed_percentage_config_options[config_armor] * engine_config_options[config_engine] * (overburnOn?13:10) * indexInto(speedPercentageMultiplierFromHeat, internal_heat) ;
}
-(lint) maxSpeedDenomenator {
    return 100 * 100 * 10 * 100;
}
@end
