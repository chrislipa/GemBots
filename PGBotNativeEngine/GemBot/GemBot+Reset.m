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

@implementation GemBot (Reset)


-(void) reboot {
    if (memory) {
        free(memory);
    }
    memorySize = savedMemorySize;
    memory = (int*)malloc(memorySize*sizeof(int));
    memccpy(memory,savedMemory, memorySize, sizeof(int));
    [self setMemory:IP :SOURCE_START];
}

-(void) cleanBetweenRounds {
    [self reboot];
    numberOfConsecutiveConditionalJumps = 0;
    internal_armor =  armorToInternalArmor(INITIAL_ARMOR);
    internal_x = 0;
    internal_y = 0;
    internal_heat =  0;
    shieldOn = NO;
    overburnOn = NO;
    savedClockCycles = 0;
    
}
@end
