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
#import "MoveableObject.h"
#import "CollideableObject.h"

@class PGBotNativeEngine;
@interface GemBot : NSObject <RobotDescription,TangibleObject, OrientedObject,TurretedObject,MoveableObject,CollideableObject> {
    // Never refreshed
    
    NSString* sessionUniqueRobotIdentifier;
    PGBotNativeEngine* engine;
    id color;
    // Refreshed on compile
    
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
    
    int* romMemory;
    int romMemorySize;
    int linesOfCode;
    bool compiledCorrectly;
    
    NSMutableArray* compileErrors;
    int numberOfCompileErrors;
    int numberOfCompileWarnings;
    int highestAddressofRomWrittenTo;
    
    // Refreshed on new set
    int killsThisMatch;
    int team;

    int kills, deaths, wins, losses;
    // Refreshed on new match

    int* memory;
    int memorySize;
    int unique_tank_id;
    int number_of_collisions;

    
    unit internal_armor;
    position internal_position;

    unit internal_heat;
    
    int heading, desiredHeading;
    int speed_in_terms_of_throttle, throttle;
    bool shieldOn;
    bool overburnOn;
    bool keepshiftOn;
    int turretHeading;
    int gameCycleOfLastDamage;
    bool everTakenDamage;
    
    int numberOfMissilesFired, numberOfMissilesConnected;
    int numberOfMinesLayed, numberOfMinesConnected;
    int numberOfMinesRemaining;
    int numberOfTimesHit;
    int lastTimeFiredShotHitATank;
    bool hasFiredShotEverHitTank;
    NSMutableDictionary* userVariables;
    int lastCollisionTime;
    bool hasEverCollided;
    bool isAlive;
    int scan_arc_width;
    
    // reset on instruction execution
    int savedClockCycles;
    int numberOfConsecutiveConditionalJumps;
    bool wasLastInstructionAByteMaskedSet;
    int addressOfLastBytMaskedSet;
    int quarterClockCyclesIntoByteMaskedSet;
    
    
    // temp decoding of opcodes
    
    
    Opcode* opcode;
    Device* device;
    SystemCall* systemCall;
    int op1;
    int op2;
    
    
    // misc
    
    bool markForSelfDestruction;
    GemBot* mostRecentlyScannedTank;
    int speedOfMostRecentlyScannedTankAtTimeOfScan;
    int relativeHeadingOfMostRecentlyScannedTankAtTimeOfScan;
    
    
    
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
    
    int internal_shutdown_temp;
    
    
    int gameCycleOfLastDetection;
    bool hasEverBeenDetected;
    
    int order;
    int orderingInt;
    
    NSString* executionLogString;
    
    NSMutableDictionary* logStrings;
    
    unit internal_odometer;
    bool diedLastTurn;
    NSMutableDictionary* userVariablesReverseLookup;
    NSMutableDictionary* labelsReverseLookup;
}
@property (readwrite,assign)     bool hasEverBeenDetected;
@property (readwrite,assign)     bool diedLastTurn;
@property (readwrite,assign) unit internal_odometer;
@property (readwrite,retain) NSDictionary* strings;
@property (readwrite,retain) NSString* executionLogString;
@property (readwrite,assign) int order;
@property (readwrite,assign) int orderingInt;

@property (readwrite,retain) NSData* source;
@property (readwrite,assign) bool hasEverCollided;
@property (readwrite,assign) bool hasFiredShotEverHitTank;
@property (readwrite,assign) bool everTakenDamage;
@property (readwrite,retain) id color;
@property (readwrite,assign)     int comm_channel;
@property (readwrite,assign) bool markForSelfDestruction;
@property (readwrite,retain) NSMutableArray* compileErrors;
@property (readwrite,assign) int numberOfCompileErrors;
@property (readwrite,assign) int numberOfCompileWarnings;

@property (readwrite,assign) int relativeHeadingOfMostRecentlyScannedTankAtTimeOfScan;
@property (readwrite,assign) int speedOfMostRecentlyScannedTankAtTimeOfScan;
@property (readwrite,assign) unit queued_dx;
@property (readwrite,assign) unit queued_dy;

@property (readwrite,assign) int lastCollisionTime;
@property (readwrite,assign) int number_of_collisions;
@property (readwrite,assign) unit internal_armor;
@property (readwrite,retain) GemBot* mostRecentlyScannedTank;
@property (readwrite, assign) position internal_position;
@property (readwrite,assign)  bool isAlive;
@property (readwrite,assign) int scan_arc_width;
@property (readwrite,assign) int throttle;
@property (readwrite,assign) int lastTimeFiredShotHitATank;
@property (readwrite,assign) int gameCycleOfLastDamage;
@property (readwrite,assign) int desiredHeading;

@property (readwrite,assign) int speed_in_terms_of_throttle;
@property (readwrite,assign) int unique_tank_id;
@property (readwrite,retain)     PGBotNativeEngine* engine;
@property (readwrite,assign) int* memory;
@property (readwrite,assign) int linesOfCode;
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

@property (readwrite,retain) NSMutableDictionary* userVariables;
@property (readwrite,assign) int kills;
@property (readwrite,assign) int deaths;
@property (readwrite,assign) int wins;
@property (readwrite,assign) int losses;
@property (readwrite,assign) bool shieldOn;
@property (readwrite,assign) bool overburnOn;
@property (readwrite,assign) bool keepshiftOn;
@property (readwrite,assign) int turretHeading;

@property (readwrite,assign) int numberOfMissilesFired;
@property (readwrite,assign) int numberOfMissilesConnected;
@property (readwrite,assign) int numberOfMinesLayed;
@property (readwrite,assign) int numberOfMinesRemaining;
@property (readwrite,assign) int numberOfMinesConnected;
@property (readwrite,assign) int numberOfTimesHit;


@property (readwrite,assign) bool compiledCorrectly;
@property (readwrite,retain) NSString* compileError;
@property (readwrite,assign) int team;

+(GemBot*) gemBotFromSource:(NSData*) source;
-(void) setGemBotSource:(NSData*)source;
-(void) recompileWithSource:(NSData*) data;
+(GemBot*) gemBot;
-(NSURL*) url;

-(void) executionError:(NSString*) str;
-(void) executionLog:(NSString*) str;
-(int) getMemory:(int) addr;
-(void) setMemory:(int) addr :(int) value;

@end
