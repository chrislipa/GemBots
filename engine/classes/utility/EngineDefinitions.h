//
//  EngineDefinitions.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#ifndef PGBotNativeEngine_EngineDefinitions_h
#define PGBotNativeEngine_EngineDefinitions_h




typedef int robotmemory;

#define MAX_ROBOT_MEMORY_VALUE 0x7fffffff
#define MIN_ROBOT_MEMORY_VALUE 0x80000000


typedef double unit;


#define UNIT_MAX 10000

#define MAXINT 0x7fffffff
#define MININT 0x80000000

#define OVER_DRIVE_HEAT_GENERATION_MULTIPLIER 0.66
#define HEAT_EACH_TURN_FROM_SHIELD 1

#define BOT_MAX_MEMORY 67108864
#define BOT_SOURCE_CODE_START 2048
#define SIZE_OF_INSTRUCTION 3


#define INITIAL_ARMOR 100

#define SIZE_OF_COMM_QUEUE 256
#define NUMBER_OF_CLOCK_CYCLES_PER_GAME_CYCLE 5
#define MAX_THROTTLE_MOVEMENT_PER_TURN 4
#define MAX_HEADING_MOVEMENT_PER_TURN 8
#define SPEED_NECCESSARY_TO_DO_DAMAGE_ON_COLLISION 50
#define DAMAGE_DONE_ON_COLLISION 1

#define INITIAL_HEAT 0 
#define HEAT_FROM_FIRING_MISSILE 20

#define MAX_THROTTLE 100
#define MIN_THROTTLE -75
#define STARTING_THROTTLE 0

#define ROBOT_DEATH_EXPLOSION_RADIUS (23+engine.rules.robotRadius)
#define MINE_EXPLOSION_RADIUS (33+engine.rules.robotRadius)
#define MISSILE_EXPLOSION_RADIUS (2+engine.rules.robotRadius)

#define DIFFERENCE_BETWEEN_HEAT_SHUTOFF_AND_REVIVE 50

#define STANDARD_HEAT_DISSAPATION 1.0
#define HEAT_DISSAPATION_WHILE_SLOW 1.125
#define THROTTLE_THRESHHOLD_FOR_SLOW_HEAT_DISSAPATION 25

typedef struct {
    unit x,y;
} position;

#define MISSILE_INTERNAL_RADIUS ((unit)0.120)

#define INITIAL_SCAN_ARC_WIDTH 128
#define DEFAULT_MISSILE_SPEED 32
#define DEFAULT_ROBOT_SPEED 4
#define NOP 0
#define SYSTEM_CALL_OPCODE 37
#define READ_DEVICE_OPCODE 38
#define WRITE_DEVICE_OPCODE 39
#define JUMP_OP_CODE 26
#define JNZ_OP_CODE 34


#define INVALID_OP_CODE 53
#define INVALID_SYS_CALL 20
#define INVALID_READ_DEVICE 20
#define INVALID_WRITE_DEVICE 20

#define SETS0 48
#define SETS1 49

#define AMOUNT_OF_TIME_THAT_PASSES_PER_GAME_LOOP ((unit)1.0)

extern int left_filled_mask[33];

extern int right_filled_mask[33];





#define SONAR_RADIUS 250

#define SIZE_OF_ARENA 1024



// Armament definitions
#define MAX_ARMAMENT_WEIGHT 12
#define DEFAULT_ARMOR_CONFIG 2;
#define DEFAULT_ENGINE_CONFIG 2;
#define DEFAULT_HEATSINKS_CONFIG 1;
#define DEFAULT_MINES_CONFIG 0;
#define DEFAUL_SCANNER_CONFIG 5;
#define DEFAULT_SHIELD_CONFIG 0;
#define DEFAULT_WEAPON_CONFIG 2;


// bitmasks
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



#define NUMBER_OF_CM_IN_M 100
#endif
