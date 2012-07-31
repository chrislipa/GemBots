//
//  GemBot.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GameStateDescriptor.h"
#import "EngineDefinitions.h"



@interface GemBot : NSObject <RobotDescription> {
    NSData* source;
    
    NSString* name;
    NSString* descript;
    NSString* author;
    
    int config_scanner;
    int config_weapon;
    int config_engine;
    int config_heatsinks;
    int config_mines;
    int config_shield;
    int config_armor;
    
    int* memory;
    int memorySize;
    
    //////////////////////////////////////
    // Everything above this line comes from the bot description (source or binary
    /////////////////////////////////////
    
    bool compiledCorrectly;
    NSString* compileError;
    int linesOfCode;
    
    //////////////////////////////////////
    // 
    /////////////////////////////////////
    
    
    
    NSString* sessionUniqueRobotIdentifier;
    int team;
    
    lint internal_armor;
    lint internal_x;
    lint internal_y;
    lint internal_heat;
    
    int x,y,heading;
    int armor;
    int heat;
    bool shieldOn;
    bool overburnOn;
    
    
    
    int kills, deaths, wins, losses;
    int numberOfMissilesFired, numberOfMissilesConnected;
    int numberOfMinesLayed, numberOfMinesConnected;
    int numberOfTimesHit;
    
    
    
    
    

    
}

@property (readwrite,assign) int* memory;

@property (readwrite,assign) int scanner;
@property (readwrite,assign) int weapon;
@property (readwrite,assign) int armor;
@property (readwrite,assign) int engine;
@property (readwrite,assign) int heatsinks;
@property (readwrite,assign) int mines;
@property (readwrite,assign) int shield;

@property (readwrite,retain) NSString* sessionUniqueRobotIdentifier;

@property (readwrite,retain) NSString* name;
@property (readwrite,retain) NSString* descript;
@property (readwrite,retain) NSString* author;

@property (readwrite,assign) int x;
@property (readwrite,assign) int y;
@property (readwrite,assign) int heading;

@property (readwrite,assign) int heat;
@property (readwrite,assign) int kills;
@property (readwrite,assign) int deaths;
@property (readwrite,assign) int wins;
@property (readwrite,assign) int loses;
@property (readwrite,assign) bool shieldOn;
@property (readwrite,assign) bool overburnOn;


@property (readwrite,assign) int numberOfMissilesFired;
@property (readwrite,assign) int numberOfMissilesConnected;
@property (readwrite,assign) int numberOfMinesLayed;
@property (readwrite,assign) int numberOfMinesConnected;
@property (readwrite,assign) int numberOfTimesHit;


@property (readwrite,assign) bool compiledCorrectly;
@property (readwrite,retain) NSString* compileError;
@property (readwrite,assign) int team;

+(GemBot*) gemBotFromSource:(NSData*) source;
-(void) setGemBotSource:(NSData*)source;
-(void) reallocRAM:(int) targetSize;

@end
