//
//  Opcode.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AX 0
#define BX 1
#define CX 2
#define DX 3
#define EX 4
#define FX 5
#define CMP_RESULT 7
#define SP 8
#define IP 9
#define LOOP_CTR 10
#define DESIRED_THROTTLE 100
#define DESIRED_HEADING 101
#define TURRET_OFFSET 102
#define TIME_SINCE_DETECTION 104
#define COLLISIONS 104
#define ODOMETER 105
#define COMM_QUEUE 256
#define STACK 1024
#define SOURCE_START 2048




@interface Opcode : NSObject {
    int opcode;
    int time;
    SEL selector;
    int numberOfOperands;
    bool op1dereferenced;
    bool op2dereferenced;
}
@property (readwrite,assign) int opcode;
@property (readwrite,assign) int time;
@property (readwrite,assign) SEL selector;
@property (readwrite,assign) int numberOfOperands;
@property (readwrite,assign) bool op1dereferenced;
@property (readwrite,assign) bool op2dereferenced;
@end

@interface Device : NSObject {
    int deviceNumber;
    int time;
    SEL selector;
    bool isWrite;
    bool op1dereferenced;
}
@property (readwrite,assign) int deviceNumber;
@property (readwrite,assign) int time;
@property (readwrite,assign) SEL selector;
@property (readwrite,assign) bool isWrite;
@property (readwrite,assign) bool op1dereferenced;
@end

@interface SystemCall : NSObject {
    int number;
    int time;
    SEL selector;
}
@property (readwrite,assign) int number;
@property (readwrite,assign) int time;
@property (readwrite,assign) SEL selector;

@end


NSArray* opcodeArray();
NSArray* readDeviceArray();
NSArray* writeDeviceArray();
NSArray* systemCallsArray();

Opcode* getOpcode(int opcodeNumber);
Device* getReadDevice(int deviceNumber);
Device* getWriteDevice(int deviceNumber) ;
SystemCall* getSystemCall(int sysCallNumber);
