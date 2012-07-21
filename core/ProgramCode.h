//
//  ProgramCode.h
//  core
//
//  Created by Christopher Lipa on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgramCode : NSObject {
    short int* code;
    char* dereferenceCount;
    char* isLabel;
    
    NSMutableDictionary* variables;
    NSMutableDictionary* constants;
    NSMutableDictionary* labels;
    NSMutableArray* labelEnumeration;
    int timeslice;
    NSString* message;
    
    int scanner;
    int weapon;
    int armor;
    int engine;
    int heatsinks;
    int mines;
    int shield;
}


@property (readwrite,assign) short int* code;

@property (readwrite,retain) NSMutableDictionary* variables;
@property (readwrite,retain) NSMutableDictionary* labels;

@property (readwrite,assign) int timeslice;
@property (readwrite,retain) NSString* message;

@property (readwrite,assign) int scanner;
@property (readwrite,assign) int weapon;
@property (readwrite,assign) int armor;
@property (readwrite,assign) int engine;
@property (readwrite,assign) int heatsinks;
@property (readwrite,assign) int mines;
@property (readwrite,assign) int shield;

-(ProgramCode*) programCodeFromFile:(NSString*) path;

@end
