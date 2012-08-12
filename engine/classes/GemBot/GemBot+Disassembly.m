//
//  GemBot+Disassembly.m
//  GemBotEngine
//
//  Created by Christopher Lipa on 8/12/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Disassembly.h"
#import "GemBot+Memory.h"
#import "Opcode.h"
#import "EngineUtility.h"
#import "EngineDefinitions.h"

@implementation GemBot (Disassembly)


-(NSString*) parseOperand:(int)x:(int) r {
    if (r == 0) {
        return [NSString stringWithFormat:@"%08X",x];
    } else if (r == 1) {
        NSString* variableName = [defaultVariablesReverseLookupDictionary() objectForKey:[NSNumber numberWithInt:x]];
        if (!variableName) {
            variableName = [userVariablesReverseLookup objectForKey:[NSNumber numberWithInt:x]];
        }
        if (variableName) {
            return variableName;
        }
    }
    return [NSString stringWithFormat:@"*%@",[self parseOperand:[self getMemory:x] :r-1]];
}

NSString* sizeTo10(NSString* s) {
    if (s.length >= 10) {
        return [s substringToIndex:10];
    } else {
        NSMutableString* t = [NSMutableString stringWithString:@""];
        while (t.length+s.length < 10 ) {
            [t appendString:@" "];
        }
        return [t stringByAppendingString:s];
    }
}

-(NSArray*) internalDisassembledSourceAtAddress:(int)pc  {

    int op = [self getMemory:pc];
    int o1 = [self getMemory:pc+1];
    int o2 = [self getMemory:pc+2];
    int basic_op_code = op & 0xff;
    int rt1 = (op>>16) & 0x3 ;
    int rt2 = (op>>24) & 0x3 ;
    Opcode* opc = getOpcode(basic_op_code);
    
    NSString* opcodestring = @"", *op1string = @"",*op2string = @"";
    if (opc.opcode == INVALID_OP_CODE || rt1 == 3 || rt2 == 3) {
        opcodestring = [NSString stringWithFormat:@"%08X",op];
        op1string = [NSString stringWithFormat:@"%08X",o1];
        op2string = [NSString stringWithFormat:@"%08X",o1];
    } else {
        opcodestring = opc.name;
        if (opc.opcode == READ_DEVICE_OPCODE && rt1 == 0 && getReadDevice(o1).deviceNumber != INVALID_READ_DEVICE) {
            op1string = getReadDevice(o1).name;
        } else if (opc.opcode == WRITE_DEVICE_OPCODE && rt1 == 0 && getReadDevice(o1).deviceNumber != INVALID_WRITE_DEVICE) {
            op1string = getWriteDevice(o1).name;
        } else if (opc.opcode == SYSTEM_CALL_OPCODE && rt1 == 0 && getSystemCall(o1).number != INVALID_SYS_CALL) {
            op1string = getSystemCall(o1).name;
        } else if (opc.numberOfOperands >= 1 || o1 !=0 || o2!=0 || rt1 !=0 || rt2!=0) {
            op1string = [self parseOperand:o1:rt1];
        }
        if (opc.numberOfOperands >= 2 || o2!=0 || rt2 !=0) {
            op2string = [self parseOperand:o2:rt2];
        }
    }
    NSMutableArray* a = [NSMutableArray array];
    NSString* line = [NSString stringWithFormat:@"%@%08X: %@ %@ %@",(pc == memory[IP]?@"-\u2192":@"  "),pc, sizeTo10(opcodestring),sizeTo10(op1string),sizeTo10(op2string)];
    NSMutableSet* labelsAtThisLine = [labelsReverseLookup objectForKey:[NSNumber numberWithInt:pc]];

    for (NSString* label in labelsAtThisLine) {
        NSString* labelLine = [NSString stringWithFormat:@" %@:",label];
        [a addObject:labelLine];
    }
    [a addObject:line];
    return a;
}

@end
