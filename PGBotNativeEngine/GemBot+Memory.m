//
//  GemBot+Memory.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Memory.h"

@implementation GemBot (Memory)



void reallocRAM(int** ivaraddr, int targetSize, int* memoryivaraddr) {
    targetSize = MAX(targetSize, SOURCE_START);
    if (*ivaraddr == NULL) {
        *ivaraddr = (int*)malloc(targetSize * sizeof(int));
        *memoryivaraddr = targetSize;
        for (int i = 0; i < *memoryivaraddr; i++) {
            (*ivaraddr)[i] = 0;
        }
    } else {
        int old_size = *memoryivaraddr;
        int new_size = *memoryivaraddr;
        while (new_size < targetSize) {
            new_size <<= 2;
        }
        new_size = MIN(new_size, BOT_MAX_MEMORY);
        *ivaraddr = (int*)realloc(*ivaraddr, targetSize * sizeof(int));
        *memoryivaraddr = targetSize;
        for (int i = old_size; i < *memoryivaraddr; i++) {
            (*ivaraddr)[i] = 0;
        }
    }
}

int getMemory(int* array, int memorySize, int addr) {
    addr &= (BOT_MAX_MEMORY - 1);
    if (addr >=memorySize ) {
        return 0;
    } else {
        return array[addr];
    }
}


void setMemory(int** array, int* memorySize,int addr ,int value ){
    addr &= (BOT_MAX_MEMORY - 1);
    if (addr >=(*memorySize)) {
        reallocRAM(array, addr, memorySize);
    }
    (*array)[addr] = value;
}

-(void) reallocRAM:   (int) targetSize {
    reallocRAM(&memory, targetSize, &memorySize);
}
-(void) reallocROM:   (int) targetSize {
    reallocRAM(&romMemory, targetSize, &romMemorySize);
}



-(int) getMemory:(int) addr {
    return getMemory(memory,memorySize, addr);
}
-(int) getRomMemory:(int) addr {
    return getMemory(romMemory,romMemorySize ,addr);
}



-(void) setMemory:(int) addr :(int) value {
    setMemory(&memory, &memorySize, addr, value);
}
-(void) setRomMemory:(int) addr :(int) value {
    setMemory(&romMemory, &romMemorySize, addr, value);
}


@end
