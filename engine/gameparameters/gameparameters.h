//
//  gameparameters.h
//  GemBotEngine
//
//  Created by Christopher Lipa on 8/7/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#ifndef GemBotEngine_gameparameters_h
#define GemBotEngine_gameparameters_h


extern int scan_radius_config_options[6];
extern unit weapon_percentage_config_options[6];
extern unit number_of_mines_config_options[6];
extern unit armor_percentage_config_options[6];
extern unit armor_speed_percentage_config_options[6];
extern unit shield_heat_config_options[6];
extern unit shield_damage_config_options[6];
extern unit heatsink_config_options[6];
extern unit engine_config_options[6];


const unit speedPercentageMultiplierFromHeat[5][2];

const unit damagePerTurnFromHeat[6][2];





unit indexInto(const unit a[][2], unit v);

#define OVER_DRIVE_MODIFICATION_TO_SPEED 1.3
#define OVER_DRIVE_MODIFICATION_TO_MISSILE_DAMAGE 1.25
#define OVER_DRIVE_MODIFICATION_TO_MISSILE_VELOCITY 1.25
#define OVER_DRIVE_MODIFICATION_TO_MISSILE_HEAT_GENERATION 1.5
#define OVER_DRIVE_MODIFICATION_TO_DAMAGE_FROM_TANK_EXPLOSION 1.3
#define OVER_DRIVE_MODIFICATION_TO_HEAT_DISSIPATION 0.66

#define STARTING_ARMOR_FOR_UI 100

#endif
