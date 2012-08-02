//
//  GemBot+Reset.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/1/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Reset.h"
#import "GemBot+Memory.h"
#import "EngineUtility.h"
#import "GemBot+Stats.h"
@implementation GemBot (Reset)


-(void) reboot {
    if (memory) {
        free(memory);
    }
    memorySize = MAX(savedMemorySize,SOURCE_START);
    memory = (int*)malloc(memorySize*sizeof(int));
    memcpy(memory,savedMemory, savedMemorySize*sizeof(int));
    for (int i =savedMemorySize; i<memorySize; i++) {
        memory[i] = 0;
    }
    [self setMemory:IP :SOURCE_START];
    shieldOn = NO;
    overburnOn = NO;
    savedClockCycles = 0;
    numberOfConsecutiveConditionalJumps = 0;
}

-(void) cleanBetweenRounds {
    [self reboot];
    
    internal_armor =  [self initialInternalArmor];
    internal_x = 0;
    internal_y = 0;
    internal_heat =  0;
    
}

-(void) cleanForRecompile {
    config_armor = DEFAULT_ARMOR_CONFIG;
    
    
    [self cleanForRecompile];
}
@end
