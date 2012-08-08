//
//  gameparameters.c
//  GemBotEngine
//
//  Created by Christopher Lipa on 8/7/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "EngineDefinitions.h"



unit indexInto(const unit a[][2], unit v) {
    for (int i =0; ; i++) {
        if (v < a[i][0]) {
            return a[i][1];
        }
    }
    return 0;
}


const int scan_radius_config_options[6] = {250,500,750,1000,1250,1500};
const unit weapon_percentage_config_options[6] = {.50,.80,1.00,1.20,1.35,1.50};
const unit number_of_mines_config_options[6] = {2,4,6,10,16,24};
const int armor_percentage_config_options[6] = {.50,.66,1.00,1.20,1.30,1.50};
const unit armor_speed_percentage_config_options[6] = {1.33,1.20,1.00,.85,.75,.66};
const unit shield_heat_config_options[6] = {0,0,0,67,50,33};
const unit shield_damage_config_options[6] = {1,1,1,.67,.50,.33};
const unit heatsink_config_options[6] = {.750,1.000,1.125,1.250,1.330,1.500};
const unit engine_config_options[6] = {0.50,0.80,1.00,1.20,1.35,1.50};


const unit speedPercentageMultiplierFromHeat[5][2] ={
    {(80) ,1.00},
    {(100), .98},
    {(150), .85},
    {(200), .70},
    {1000               , .50}
};

const unit damagePerTurnFromHeat[6][2] ={
    {(300),1.0/64.0},
    {(350),1.0/32.0},
    {(400),1.0/16.0},
    {(450),1.0/8.0},
    {(475),1.0/4.0},
    {1000,1000}
};


