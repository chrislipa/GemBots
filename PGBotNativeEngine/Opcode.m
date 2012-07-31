//
//  Opcode.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "Opcode.h"
#import "EngineDefinitions.h"
@implementation Opcode
@synthesize opcode;
@synthesize time;
@synthesize selector;
@synthesize op1dereferenced;
@synthesize op2dereferenced;
@synthesize numberOfOperands;
@end

@implementation Device
@synthesize deviceNumber;
@synthesize time;
@synthesize selector;
@synthesize isWrite;
@synthesize op1dereferenced;
@end

@implementation SystemCall
@synthesize number;
@synthesize time;
@synthesize selector;
@end

NSMutableArray* newOpcodesFromTextFile(NSString* file) {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    NSString* fileName = [[NSBundle mainBundle] pathForResource:file ofType:@"txt"];
    NSString* contents =  [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    
    NSArray* lines = [contents componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    
    for (NSString* line in lines) {
        NSArray* lineComps = [line componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([lineComps count] == 3) {
            int opcode = [[lineComps objectAtIndex:0] intValue];
            int time = [[lineComps objectAtIndex:1] intValue];
            NSString* selectorStr = [lineComps objectAtIndex:2];
            
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
            SEL sel = NSSelectorFromString(selectorStr);
            Opcode* o = [[Opcode alloc] init];
            o.opcode = opcode;
            o.time = time;
            o.selector = sel;
            o.op1dereferenced = ([op1 isEqualToString:@"L"]);
            o.op2dereferenced = ([op2 isEqualToString:@"L"]);
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

NSArray* newDevicesFromTextFile(NSString* file, bool write) {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    NSString* fileName = [[NSBundle mainBundle] pathForResource:file ofType:@"txt"];
    NSString* contents =  [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    
    NSArray* lines = [contents componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    
    for (NSString* line in lines) {
        NSArray* lineComps = [line componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([lineComps count] == 3) {
            int device = [[lineComps objectAtIndex:0] intValue];
            int time = [[lineComps objectAtIndex:1] intValue];
            NSString* selectorStr = [lineComps objectAtIndex:2];
            NSString* search;
            if (write) {
                
                search = @"w";
            } else {
                
                search = @"r";
            }
            SEL sel = NSSelectorFromString(selectorStr);
            if  (((NSRange)[(NSString*)[lineComps objectAtIndex:3] rangeOfString:search]).location != NSNotFound)  {
                Device* d = [[Device alloc] init];
                d.deviceNumber = device;
                d.time = time;
                d.selector = sel;
                d.isWrite = write;
                d.op1dereferenced = write;
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
    
    NSString* fileName = [[NSBundle mainBundle] pathForResource:file ofType:@"txt"];
    NSString* contents =  [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    
    NSArray* lines = [contents componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    
    for (NSString* line in lines) {
        NSArray* lineComps = [line componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([lineComps count] == 3) {
            int number = [[lineComps objectAtIndex:0] intValue];
            int time = [[lineComps objectAtIndex:1] intValue];
            NSString* selectorStr = [lineComps objectAtIndex:2];
            SEL sel = NSSelectorFromString(selectorStr);
            
            SystemCall* s = [[SystemCall alloc] init];
            s.number = number;
            s.time = time;
            s.selector = sel;
            
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
    return indexIntoArray(opcodeArray(), opcodeNumber, NOP);
}

Device* getReadDevice(int deviceNumber) {
    return indexIntoArray(readDeviceArray(), deviceNumber, READ_DEVICE_NOP);
}
Device* getWriteDevice(int deviceNumber) {
   return indexIntoArray(writeDeviceArray(), deviceNumber, WRITE_DEVICE_NOP);
}

SystemCall* getSystemCall(int sysCallNumber) {
    return indexIntoArray(writeDeviceArray(), sysCallNumber, SYS_CALL_NOP);
}




