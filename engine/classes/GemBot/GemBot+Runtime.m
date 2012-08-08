//
//  GemBot+Runtime.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//


#import "GemBot+Runtime.h"
#import "PGBotNativeEngine.h"
#import "Opcode.h"
#import "EngineUtility.h"
#import "GemBot+Memory.h"
#import <objc/message.h>
@implementation GemBot (Runtime)





-(int) clockCyclesRequiredForSystemCall {
    systemCall = getSystemCall(op1);
    return systemCall.time;
    NSLog(@" //");
}

-(int) clockCyclesRequiredForReadDevice {
    device = getReadDevice(op1);
    return 4 + device.time;
}

-(int) clockCyclesRequiredForWriteDevice {
    device = getWriteDevice(op1);
    return 4 + device.time;
}

-(int) timeRequiredForByteMaskedOperation {
    if (wasLastInstructionAByteMaskedSet) {
        if (op1 == addressOfLastBytMaskedSet) {
            int quarterTimeUsed = (opcode.opcode == SETS0 || opcode.opcode == SETS1 ? 2 : 1 );
            return (quarterTimeUsed + quarterClockCyclesIntoByteMaskedSet) > 4;
        } else {
            return 1;
        }
    } else {
        return 1;
    }
}

-(int) clockCyclesRequiredForNextInstruction {
    int time = opcode.time;
    if (time >= 0) {
        return time;          // normal instruction
    } else if (time == -1) {
        return op1;            // delay R
    } else if (time == -2) {
        return (numberOfConsecutiveConditionalJumps == 19); // conditional_jump
    } else if (time == -3) {
        return [self clockCyclesRequiredForSystemCall]; // sys call
    } else if (time == -4) {
        return [self clockCyclesRequiredForReadDevice]; // read device
    } else if (time == -5) {
        return [self clockCyclesRequiredForWriteDevice]; // write device
    } else if (time == -6) {
        return [self timeRequiredForByteMaskedOperation]; // byte masked mov
    } else {
        return 1; //never
    }
}

-(void) resetROMMemory {
    memory[DESIRED_HEADING] = desiredHeading;
    memory[DESIRED_THROTTLE] = throttle;
    memory[TURRET_OFFSET] = turretHeading;
    memory[TIME_SINCE_DETECTION] = (hasEverBeenDetected?[engine gameCycle] - gameCycleOfLastDetection:MAX_ROBOT_MEMORY_VALUE);
    
}



-(void) executeClockCycles:(int) clockCycles  {
    savedClockCycles += clockCycles;
    
    while (TRUE) {
        [self resetROMMemory];
        
        
        int ip = memory[IP];
        int extended_opcode = [self getMemory:ip];
        op1 = [self getMemory:ip+1];
        op2 = [self getMemory:ip+2];
        
        [self setMemory:IP :ip+SIZE_OF_INSTRUCTION];
        
        int opcodenum = extended_opcode & 0x000000ff;
        opcode = getOpcode(opcodenum);
        int rtype1 = (extended_opcode & 0x00030000) >> 16;
        int rtype2 = (extended_opcode & 0x03000000) >> 24;
        
        
        if (rtype1 == 3) {
            opcode = getOpcode(NOP);
        }
        if (rtype2 == 3) {
            opcode = getOpcode(NOP);
        }
        
        while (rtype1 > opcode.op1dereferenced) {
            op1 = [self getMemory:op1];
            rtype1--;
        }
        while (rtype2 > opcode.op2dereferenced) {
            op2 =[self getMemory:op2];
            rtype2--;
        }
        
        int clockCyclesRequiredForNext = [self clockCyclesRequiredForNextInstruction];
        if (clockCyclesRequiredForNext > savedClockCycles || markForSelfDestruction) {
            [self setMemory:IP :[self getMemory:IP]-SIZE_OF_INSTRUCTION];
            break;
        }
        
        objc_msgSend(self, opcode.selector);
        

        savedClockCycles -= clockCyclesRequiredForNext;
        
        
        
    }
    
}
@end
