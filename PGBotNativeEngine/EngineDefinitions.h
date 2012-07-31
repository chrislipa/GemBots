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

#define ARMOR_MULTIPLIER 0x40000000
#define DISTANCE_MULTIPLIER 0x40000000
#define HEAT_MULTIPLIER 0x40000000

#define MAXINT 0x7fffffff
#define MININT 0x80000000

#define NUMBER_OF_CLOCK_CYCLES_PER_GAME_CYCLE 5

typedef unsigned long long lint;



#define NOP 0
#define SYS_CALL_NOP 20
#define READ_DEVICE_NOP 18
#define WRITE_DEVICE_NOP 18

#define SETS0 48
#define SETS1 49



#endif
