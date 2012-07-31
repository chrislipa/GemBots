//
//  Opcode.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>

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
NSDictionary* readDeviceArray();
NSDictionary* writeDeviceArray();
NSArray* systemCallsArray();