//
//  GemBot.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GameStateDescriptor.h"

#define BOT_MAX_MEMORY 67108864


@interface GemBot : RobotDescription {
    int* memory;
    int memorySize;
    
    NSMutableDictionary* variables;


    

 
    
    
    
    
    int scanner;
    int weapon;
    int armor;
    int engine;
    int heatsinks;
    int mines;
    int shield;
}


@property (readwrite,assign) int* code;









@property (readwrite,assign) int scanner;
@property (readwrite,assign) int weapon;
@property (readwrite,assign) int armor;
@property (readwrite,assign) int engine;
@property (readwrite,assign) int heatsinks;
@property (readwrite,assign) int mines;
@property (readwrite,assign) int shield;



+(GemBot*) gemBotFromData:(NSData*) data;
+(GemBot*) gemBotFromString:(NSString*) string;

@end
