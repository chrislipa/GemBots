//
//  EngineDefinitions.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#ifndef PGBotNativeEngine_EngineDefinitions_h
#define PGBotNativeEngine_EngineDefinitions_h

#define BOT_MAX_MEMORY 67108864
#define BOT_SOURCE_CODE_START 2048

#define SPEED_OF_ROBOT 4
#define SPEED_OF_MISSILE 32

#define ARMOR_MULTIPLIER 0x40000000
#define DISTANCE_MULTIPLIER 0x40000000
#define HEAT_MULTIPLIER 0x40000000
#define SIZE_OF_INSTRUCTION 3
#define MAXINT 0x7fffffff
#define MININT 0x80000000
#define INITIAL_ARMOR 100
#define NUMBER_OF_CLOCK_CYCLES_PER_GAME_CYCLE 5

#define ROBOT_DEATH_EXPLOSION_RADIUS 25
#define MINE_EXPLOSION_RADIUS 35
#define MISSILE_EXPLOSION_RADIUS 14
#define MISSILE_RADIUS 0

typedef signed long long lint;

#define ROBOT_RADIUS 2

#define NOP 0
#define SYS_CALL_NOP 20
#define READ_DEVICE_NOP 20
#define WRITE_DEVICE_NOP 20

#define SETS0 48
#define SETS1 49


extern int left_filled_mask[33];

extern int right_filled_mask[33];

#define B0 0x000000FF
#define B1 0x0000FF00
#define B2 0x00FF0000
#define B3  0xFF000000
#define NOTB0 0xFFFFFF00
#define NOTB1 0xFFFF00FF
#define NOTB2 0xFF00FFFF
#define NOTB3 0x00FFFFFF
#define S0 0x0000FFFF
#define S1 0xFFFF0000
#define NOTS1 0x0000FFFF
#define NOTS0 0xFFFF0000

#define COMMUNICATION_MEMORY_START 256
#define COMMUNICATION_MEMORY_END 512

#define SONAR_RADIUS 250

#define SIZE_OF_ARENA 1024

#define DEFAULT_ARMOR_CONFIG 2;
#define DEFAULT_ENGINE_CONFIG 2;
#define DEFAULT_HEATSINKS_CONFIG 1;
#define DEFAULT_MINES_CONFIG 0;
#define DEFAUL_SCANNER_CONFIG 5;
#define DEFAULT_SHIELD_CONFIG 0;
#define DEFAULT_WEAPON_CONFIG 2;
#endif
