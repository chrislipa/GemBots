//
//  GemBot+Memory.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Memory.h"

@implementation GemBot (Memory)


void clean(int** addressOfArray, int* addressOfCurrentArraySize) {
    if ((*addressOfArray)) {
        free(*addressOfArray);
        *addressOfArray = NULL;
    }
    *addressOfCurrentArraySize = 0;
}

-(void) cleanMemory {
    clean(&memory, &memorySize);
    clean(&romMemory, &romMemorySize);
}

void reallocRAM(int** addressOfArray,  int* addressOfCurrentArraySize, int targetSize) {
    targetSize = MIN(BOT_MAX_MEMORY, MAX(SOURCE_START,targetSize ));
    int old_size = *addressOfCurrentArraySize;
    int new_size = MAX(1,*addressOfCurrentArraySize);
    while (new_size < targetSize) {
        new_size <<= 2;
    }
    int *pointerToOldArray = *addressOfArray;
    (*addressOfArray) = (int*)malloc(new_size * sizeof(int));
    
    *addressOfCurrentArraySize = new_size;
    int i = 0;
    for (; i < old_size; i++) {
        (*addressOfArray)[i] = pointerToOldArray[i];
    }
    for (; i < new_size; i++) {
        (*addressOfArray)[i] = 0;
    }
    if (pointerToOldArray != NULL) {
        free(pointerToOldArray);
        
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


void setMemory(int** array, int* currentMemorySize,int addr ,int value ){
    addr &= (BOT_MAX_MEMORY - 1);
    if (addr >=(*currentMemorySize)) {
        reallocRAM(array,  currentMemorySize, addr);
    }
    (*array)[addr] = value;
}

-(void) reallocRAM:   (int) targetSize {
    reallocRAM(&memory,  &memorySize, targetSize);
}
-(void) reallocROM:   (int) targetSize {
    reallocRAM(&romMemory, &romMemorySize , targetSize);
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
    highestAddressofRomWrittenTo = MAX(addr,highestAddressofRomWrittenTo);
    setMemory(&romMemory, &romMemorySize, addr, value);
}


@end
