//
//  GemBot+Memory.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Memory.h"

@implementation GemBot (Memory)



-(void) reallocRAM:(int) targetSize {
    if (memory == NULL) {
        memory = (int*)malloc(targetSize * sizeof(int));
        memorySize = targetSize;
        for (int i = 0; i < memorySize; i++) {
            memory[i] = 0;
        }
    } else {
        int old_size = memorySize;
        int new_size = memorySize;
        while (new_size < targetSize) {
            new_size <<= 2;
        }
        new_size = MIN(new_size, BOT_MAX_MEMORY);
        memory = (int*)realloc(memory, targetSize * sizeof(int));
        memorySize = targetSize;
        for (int i = old_size; i < memorySize; i++) {
            memory[i] = 0;
        }
    }
}


-(int) getMemory:(int) addr {
    addr &= (BOT_MAX_MEMORY - 1);
    if (addr >=memorySize ) {
        return 0;
    } else {
        return memory[addr];
    }
}

-(void) setMemory:(int) addr :(int) value {
    addr &= (BOT_MAX_MEMORY - 1);
    if (addr >=memorySize ) {
        [self reallocRAM:addr];
    }
    memory[addr] = value;
}



@end
