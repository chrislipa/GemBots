//
//  GemBot+Reset.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/1/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Reset.h"
#import "GemBot+Memory.h"
#import "EngineUtility.h"
#import "GemBot+Stats.h"
@implementation GemBot (Reset)


-(void) reboot {
    if (memory) {
        free(memory);
    }
    memorySize = MAX(romMemorySize,SOURCE_START);
    memory = (int*)malloc(memorySize*sizeof(int));
    memcpy(memory,romMemory, romMemorySize*sizeof(int));
    for (int i =romMemorySize; i<memorySize; i++) {
        memory[i] = 0;
    }
    [self setMemory:IP :SOURCE_START];
    shieldOn = NO;
    overburnOn = NO;
    savedClockCycles = 0;
    numberOfConsecutiveConditionalJumps = 0;
    for (int i = 0; i < comm_write_ptr; i++) {
        comm_queue[i] = 0;
    }
}

-(void) cleanBetweenRounds {
    [self reboot];
    
    internal_armor =  [self initialInternalArmor];
    internal_heat =  heatToInternalHeat(INITIAL_HEAT);
    internal_odometer = 0;
    
    
    number_of_collisions = 0;
    
    
   
    internalLoggingArray = [NSMutableArray array];
    indexIntoInternalLoggingArray = 0;
    
    turretHeading = desiredHeading = heading;
    
    
    speed_in_terms_of_throttle =  throttle = STARTING_THROTTLE;
    shieldOn = 0;
    overburnOn = 0;
    keepshiftOn = NO;

    gameCycleOfLastDamage = 0;
    everTakenDamage = NO;
    numberOfMissilesFired =  numberOfMissilesConnected = 0;
    numberOfMinesLayed = numberOfMinesConnected = 0;
    numberOfMinesRemaining = [self numberOfStartingMines];
    numberOfTimesHit = 0;
    lastTimeFiredShotHitATank = 0;
    hasFiredShotEverHitTank = NO;
    
    lastCollisionTime = 0;
    hasEverCollided = NO;
    isAlive = YES;
    scan_arc_width = INITIAL_SCAN_ARC_WIDTH;
    
    // reset on instruction execution
    savedClockCycles = 0;
    numberOfConsecutiveConditionalJumps = 0;
    wasLastInstructionAByteMaskedSet = NO;
    addressOfLastBytMaskedSet  = 0;
    quarterClockCyclesIntoByteMaskedSet = 0;
    
    
    // temp decoding of opcodes
    
  
    
    // misc
    
    markForSelfDestruction = NO;
    mostRecentlyScannedTank = nil;
    speedOfMostRecentlyScannedTankAtTimeOfScan = 0;
    relativeHeadingOfMostRecentlyScannedTankAtTimeOfScan = 0;
    
    
    
    ///
    //comm
    ///
    comm_channel = 0;
    comm_channel_to_switch_to = 0;
    swtich_comm_channel_this_turn = NO;
    comm_write_ptr = 0 ;
    comm_read_ptr = 0;
    //comm_transmits_this_turn[NUMBER_OF_CLOCK_CYCLES_PER_GAME_CYCLE];
    number_of_comm_transmits_this_turn = 0;
    
    internal_shutdown_temp = 350;
    isShutDownFromHeat = NO;
}

-(void) resetForNewSetOfMatches {
    wins = losses = kills = deaths = 0;
}


-(void) cleanForRecompile {
    userVariables = [NSMutableDictionary dictionary];
    labelsReverseLookup = [NSMutableDictionary dictionary];
    userVariablesReverseLookup = [NSMutableDictionary dictionary];
    highestAddressofRomWrittenTo= 0;
    numberOfCompileErrors = 0;
    numberOfCompileWarnings = 0;
    compileErrors = [NSMutableArray array];
    compiledCorrectly = YES;
    name = nil;
    descript = nil;
    author = nil;
    
    [self cleanMemory];

    
    memorySize = romMemorySize = 0;
    name = nil;
    descript = nil;
    
    
    linesOfCode = 0;
    
    config_armor = DEFAULT_ARMOR_CONFIG;
    config_engine = DEFAULT_ENGINE_CONFIG;
    config_heatsinks = DEFAULT_HEATSINKS_CONFIG;
    config_mines = DEFAULT_MINES_CONFIG;
    config_scanner = DEFAUL_SCANNER_CONFIG;
    config_shield = DEFAULT_SHIELD_CONFIG;
    config_weapon = DEFAULT_WEAPON_CONFIG;
}
@end
