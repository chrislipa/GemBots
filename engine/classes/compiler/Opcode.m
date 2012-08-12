//
//  Opcode.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "Opcode.h"
#import "EngineDefinitions.h"
#import "EngineUtility.h"
@implementation Opcode
@synthesize name;
@synthesize opcode;
@synthesize time;
@synthesize selector;
@synthesize op1dereferenced;
@synthesize op2dereferenced;
@synthesize isOp1String;
@synthesize isOp2String;
@synthesize numberOfOperands;
@end

@implementation Device
@synthesize name;
@synthesize deviceNumber;
@synthesize time;
@synthesize selector;
@synthesize isWrite;
@synthesize op1dereferenced;
@end

@implementation SystemCall
@synthesize name;
@synthesize number;
@synthesize time;
@synthesize selector;
@end

NSMutableArray* newOpcodesFromTextFile(NSString* file) {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    NSString* fileName = pathToTextFile(file);
    NSString* contents =  [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    
    NSArray* lines = [contents componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    
    for (NSString* line in lines) {
        NSArray* lineComps = delimit(line);
        if ([lineComps count] >= 3) {
            int opcode = [[lineComps objectAtIndex:0] intValue];
            int time = [[lineComps objectAtIndex:1] intValue];
            NSString* name = [lineComps objectAtIndex:2];
            NSString* selectorStr = name;
            NSString* op1 = nil, *op2 = nil;
            int numberOfOperands = 0;
            
            if ([lineComps count] > 3) {
                
                op1 = [lineComps objectAtIndex:3];
                numberOfOperands++;
            }
            
            if ([lineComps count] > 4) {
                op2 = [lineComps objectAtIndex:4];
                numberOfOperands++;
            }
            NSString* last = [lineComps lastObject];
            if (![last isEqualToString:@"L"] &&
                ![last isEqualToString:@"R"] &&
                ![last isEqualToString:@"S"]) {
                selectorStr = last;
            }
            SEL sel = NSSelectorFromString(selectorStr);
            Opcode* o = [[Opcode alloc] init];
            o.opcode = opcode;
            o.time = time;
            o.name = [name uppercaseString];
            o.selector = sel;
            o.op1dereferenced = ([op1 isEqualToString:@"L"]);
            o.op2dereferenced = ([op2 isEqualToString:@"L"]);
            o.isOp1String = ([op1 isEqualToString:@"S"]);
            o.isOp2String = ([op2 isEqualToString:@"S"]);
            o.numberOfOperands = numberOfOperands;
            while ([array count] <= opcode) {
                [array addObject:[NSNull null]];
            }
            [array replaceObjectAtIndex:opcode withObject:o];
        }
    }
    return array;
}

NSArray* opcodeArray() {
    __strong static NSArray* opcodeArray = nil;
    if (opcodeArray == nil) {
        opcodeArray = [[NSArray alloc] initWithArray: newOpcodesFromTextFile(@"Opcodes")];
    }
    return opcodeArray;
}


Opcode* opcodeFromString(NSString* s) {
    __strong static NSMutableDictionary* opcodeDictionay = nil;
    if (opcodeDictionay == nil) {
        opcodeDictionay = [NSMutableDictionary dictionary];
        for (Opcode* o in opcodeArray()) {
            [opcodeDictionay setObject:o forKey:[o.name uppercaseString]];
        }
    }
    return [opcodeDictionay objectForKey:s];
}

NSArray* newDevicesFromTextFile(NSString* file, bool write) {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    NSString* fileName = pathToTextFile(file);
    NSString* contents =  [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    
    NSArray* lines = [contents componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    
    for (NSString* line in lines) {
        NSArray* lineComps = delimit(line);
        if ([lineComps count] >= 3) {
            int device = [[lineComps objectAtIndex:0] intValue];
            int time = [[lineComps objectAtIndex:1] intValue];
            NSString* selectorStr = [lineComps objectAtIndex:2];
            NSString* search;
            if (write) {
                
                search = @"w";
            } else {
                
                search = @"r";
            }
            SEL sel = NSSelectorFromString([selectorStr stringByAppendingString:search]);
            if  (((NSRange)[(NSString*)[lineComps objectAtIndex:3] rangeOfString:search]).location != NSNotFound)  {
                Device* d = [[Device alloc] init];
                d.deviceNumber = device;
                d.time = time;
                d.selector = sel;
                d.isWrite = write;
                d.op1dereferenced = write;
                d.name = [selectorStr uppercaseString];
                while ([array count] <= device) {
                    [array addObject:[NSNull null]];
                }
                [array replaceObjectAtIndex:device withObject:d];
            }
            
        }
    }
    return array;
}

NSArray* readDeviceArray() {
    __strong static NSArray* readDeviceDictionary = nil;
    if (readDeviceDictionary == nil) {
        readDeviceDictionary = [NSArray arrayWithArray:newDevicesFromTextFile(@"Devices", NO)];
    }
    return readDeviceDictionary;
}

NSArray* writeDeviceArray() {
    __strong static NSArray* writeDeviceDictionary = nil;
    if (writeDeviceDictionary == nil) {
        writeDeviceDictionary = [NSArray arrayWithArray:newDevicesFromTextFile(@"Devices", YES)];
    }
    return writeDeviceDictionary;
}



NSArray* newSystemCallsFromTextFile(NSString* file, bool write) {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    NSString* fileName = pathToTextFile(file);
    NSString* contents =  [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    
    NSArray* lines = [contents componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    
    for (NSString* line in lines) {
        NSArray* lineComps = delimit(line);
        if ([lineComps count] == 3) {
            int number = [[lineComps objectAtIndex:0] intValue];
            int time = [[lineComps objectAtIndex:1] intValue];
            NSString* selectorStr = [lineComps objectAtIndex:2];
            SEL sel = NSSelectorFromString(selectorStr);
            
            SystemCall* s = [[SystemCall alloc] init];
            s.number = number;
            s.time = time;
            s.selector = sel;
            s.name = [selectorStr uppercaseString];
            while ([array count] <= number) {
                [array addObject:[NSNull null]];
            }
            [array replaceObjectAtIndex:number withObject:s];

            
        }
    }
    return array;
}

NSArray* systemCallsArray() {
    __strong static NSArray* readDeviceDictionary = nil;
    if (readDeviceDictionary == nil) {
        readDeviceDictionary = [NSArray arrayWithArray:newSystemCallsFromTextFile(@"SystemCalls", NO)];
    }
    return readDeviceDictionary;
}


id indexIntoArray(NSArray* a, int index, int defaultIndex) {
    if (index < 0 || index >= [a count]) {
        return [a objectAtIndex:defaultIndex];
    }
    id x = [a objectAtIndex:index];
    if (x == [NSNull null]) {
        return [a objectAtIndex:defaultIndex];
    }
    return x;
}


Opcode* getOpcode(int opcodeNumber) {
    return indexIntoArray(opcodeArray(), opcodeNumber, INVALID_OP_CODE);
}

Device* getReadDevice(int deviceNumber) {
    return indexIntoArray(readDeviceArray(), deviceNumber, INVALID_READ_DEVICE);
}
Device* getWriteDevice(int deviceNumber) {
   return indexIntoArray(writeDeviceArray(), deviceNumber, INVALID_WRITE_DEVICE);
}

SystemCall* getSystemCall(int sysCallNumber) {
    return indexIntoArray(systemCallsArray(), sysCallNumber, INVALID_SYS_CALL);
}



NSMutableDictionary* getConstantsFromOpcodes() {
    NSMutableDictionary* d = [NSMutableDictionary dictionary];
    for (Opcode* op in opcodeArray()) {
        if ((NSNull*)op != [NSNull null])
            [d setObject:[NSNumber numberWithInt:op.opcode] forKey:op.name];
    }
    return d;
}
NSMutableDictionary* getConstantsFromDevices() {
    NSMutableDictionary* d = [NSMutableDictionary dictionary];
    for (Device* dev in readDeviceArray()) {
        if ((NSNull*)dev != [NSNull null])
            [d setObject:[NSNumber numberWithInt:dev.deviceNumber] forKey:dev.name];
    }
    for (Device* dev in writeDeviceArray()) {
        if ((NSNull*)dev != [NSNull null])
            [d setObject:[NSNumber numberWithInt:dev.deviceNumber] forKey:dev.name];
    }
    return d;
}
NSMutableDictionary* getConstantsFromSystemCalls() {
    NSMutableDictionary* d = [NSMutableDictionary dictionary];
    for (SystemCall* sys in systemCallsArray()) {
        if ((NSNull*)sys != [NSNull null])
            [d setObject:[NSNumber numberWithInt:sys.number] forKey:sys.name];
    }
    return d;
}


