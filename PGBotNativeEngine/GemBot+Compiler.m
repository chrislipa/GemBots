//
//  GemBot+Compiler.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Compiler.h"
#import "GemBot+BinaryCompiler.h"
#import "GemBot+SourceCodeCompiler.h"
#import "GemBot+Memory.h"
@implementation GemBot (Compiler)

-(void) compile {
    [self cleanBetweenRounds];
    const char* bytes = [source bytes];
    int i = 0;
    for (int i = 0; i < [source length]; i++) {
        if (bytes[i] != ' ' && bytes[i] !='\n' && bytes[i] != '\t' && bytes[i] != '\r') {
            break;
        }
    }
    if (i < [source length] && bytes[i] == '{') {
        [self compileBinary];
    } else {
        [self compileSource];
    }
    [self saveCompiledCode];
}

-(void) saveCompiledCode {
    if (savedMemory) {
        free(savedMemory);
    }
    savedMemorySize = memorySize;
    savedMemory = (int*)malloc(memorySize*(sizeof(int)));
    memccpy(savedMemory, memory, memorySize, sizeof(int));
}

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
    internal_armor = 100*ARMOR_MULTIPLIER;
    internal_x = 0;
    internal_y = 0;
    internal_heat =  0;
    shieldOn = NO;
    overburnOn = NO;
    savedClockCycles = 0;
    
}

@end
