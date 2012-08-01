//
//  GemBot.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GameStateDescriptor.h"
#import "EngineDefinitions.h"
#import "PGBotNativeEngine.h"
#import "Opcode.h"
#import "TangibleObject.h"
#import "OrientedObject.h"
#import "TurretedObject.h"

@interface GemBot : NSObject <RobotDescription,TangibleObject, OrientedObject,TurretedObject> {
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
    
    int* savedMemory;
    int savedMemorySize;
    
    //////////////////////////////////////
    // Everything above this line comes from the bot description (source or binary
    /////////////////////////////////////
    
    bool compiledCorrectly;
    NSString* compileError;
    int linesOfCode;
    
    //////////////////////////////////////
    // 
    /////////////////////////////////////
    
    
    int unique_tank_id;
    int collisions;
    int odometer;
    
    NSString* sessionUniqueRobotIdentifier;
    int team;
    
    lint internal_armor;
    lint internal_x;
    lint internal_y;
    lint internal_heat;
    
    int heading, desiredHeading;
    int internal_speed, throttle;
    int armor;
    int heat;
    bool shieldOn;
    bool overburnOn;
    bool keepshiftOn;
    int turretHeading;
    
    
    int kills, deaths, wins, losses;
    int killsThisMatch;
    int numberOfMissilesFired, numberOfMissilesConnected;
    int numberOfMinesLayed, numberOfMinesConnected;
    int numberOfTimesHit;
    
    
    
    
    
    int savedClockCycles;
    int numberOfConsecutiveConditionalJumps;
    
    bool wasLastInstructionAByteMaskedSet;
    int addressOfLastBytMaskedSet;
    int quarterClockCyclesIntoByteMaskedSet;
    
    __weak PGBotNativeEngine* engine;
    
    Opcode* opcode;
    Device* device;
    SystemCall* systemCall;
    int op1;
    int op2;
    bool markForSelfDestruction;
    GemBot* mostRecentlyScannedTank;
    int gameCycleOfLastDamage;
    int lastTimeFiredShotHitATank;
    
    bool alive;
    
    ///
    //comm
    ///
int comm_channel;
int comm_channel_to_switch_to;
bool swtich_comm_channel_this_turn;
int comm_write_ptr;
int comm_read_ptr;
int comm_transmits_this_turn[NUMBER_OF_CLOCK_CYCLES_PER_GAME_CYCLE];
int number_of_comm_transmits_this_turn;
int scan_arc_half_width;
    
}

@property (readwrite,retain) GemBot* mostRecentlyScannedTank;
@property (readwrite, assign) lint internal_x;
@property (readwrite, assign) lint internal_y;
@property (readwrite,assign)  bool alive;
@property (readwrite,assign) int scan_arc_half_width;
@property (readwrite,assign) int throttle;
@property (readwrite,assign) int lastTimeFiredShotHitATank;
@property (readwrite,assign) int gameCycleOfLastDamage;
@property (readwrite,assign) int desiredHeading;

@property (readwrite,assign) int internal_speed;
@property (readwrite,assign) int unique_tank_id;
@property (readwrite,weak)     PGBotNativeEngine* engine;
@property (readwrite,assign) int* memory;

@property (readwrite,assign) int config_scanner;
@property (readwrite,assign) int config_weapon;
@property (readwrite,assign) int config_armor;
@property (readwrite,assign) int config_engine;
@property (readwrite,assign) int config_heatsinks;
@property (readwrite,assign) int config_mines;
@property (readwrite,assign) int config_shield;

@property (readwrite,retain) NSString* sessionUniqueRobotIdentifier;

@property (readwrite,retain) NSString* name;
@property (readwrite,retain) NSString* descript;
@property (readwrite,retain) NSString* author;


@property (readwrite,assign) int heading;


@property (readwrite,assign) int kills;
@property (readwrite,assign) int deaths;
@property (readwrite,assign) int wins;
@property (readwrite,assign) int loses;
@property (readwrite,assign) bool shieldOn;
@property (readwrite,assign) bool overburnOn;
@property (readwrite,assign) bool keepshiftOn;
@property (readwrite,assign) int turretHeading;

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



-(bool) isAlive;
@end
