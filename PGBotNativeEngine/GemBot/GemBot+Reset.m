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
    memorySize = MAX(romMemorySize,SOURCE_START);
    memory = (int*)malloc(memorySize*sizeof(int));
    memcpy(memory,romMemory, romMemorySize*sizeof(int));
    for (int i =romMemorySize; i<memorySize; i++) {
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
    highestAddressofRomWrittenTo= 0;
    numberOfCompileErrors = 0;
    numberOfCompileWarnings = 0;
    compileErrors = [NSMutableArray array];
    compiledCorrectly = YES;
    name = nil;
    descript = nil;
    author = nil;
    
    [self cleanMemory];

    
    memorySize = romMemorySize = 0;
    name = nil;
    descript = nil;
    compiledCorrectly = NO;
    
    linesOfCode = 0;
    
    config_armor = DEFAULT_ARMOR_CONFIG;
    config_engine = DEFAULT_ENGINE_CONFIG;
    config_heatsinks = DEFAULT_HEATSINKS_CONFIG;
    config_mines = DEFAULT_MINES_CONFIG;
    config_scanner = DEFAUL_SCANNER_CONFIG;
    config_shield = DEFAULT_SHIELD_CONFIG;
    config_weapon = DEFAULT_WEAPON_CONFIG;
}
@end
