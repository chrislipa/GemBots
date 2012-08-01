//
//  GemBot+Stats.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Stats.h"

const int scan_radius[6] = {250,500,750,1000,1250,1500};
const int weapon_percentage[6] = {50,80,100,120,135,150};
const int number_of_mines[6] = {2,4,6,10,16,24};
const int armor_percentage[6] = {50,66,100,120,130,150};
const int armor_speed_percentage[6] = {133,120,100,85,75,66};
const int shield[6] = {0,0,0,67,50,33};
const int heatsink[6] = {750,1000,1125,1250,1330,1500};
const int engine[6] = {50,80,100,120,135,150};


@implementation GemBot (Stats)

-(int) scanRadius {
    return scan_radius[config_scanner];
}
@end
