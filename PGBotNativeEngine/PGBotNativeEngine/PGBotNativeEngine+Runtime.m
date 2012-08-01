//
//  PGBotNativeEngine+Runtime.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine+Runtime.h"
#import "GemBot+Runtime.h"
#import "Missile.h"
@implementation PGBotNativeEngine (Runtime)
 

-(void) setUpNewSetOfRounds {
    
}

-(void) setUpNewRound {
    
}




-(void) isRoundOver {
    
}

-(void) isSetOfRoundsOver {
    
}

//1. Give each tanks 5 clock cycles.  They free only to modify their memory, emit missiles, mines, scan, adjust steering and throttle here, but no changes are made to positions.
//
//2. Update direction and speed based on steering and throttle for the bots only.
//
//3. Move everything forward by its velocity.
//
//4. Check for collisions.  Detonate explosions.  Remove missiles.
//
//5. Deal damage.  Kill robots.
//
//6. Check end round conditions.
-(void) executeGameCycle {
    
    ////----- Robot CPU execution phase
    for (GemBot* bot in robots) {
        if ([bot isAlive]) {
            [bot executeClockCycles:NUMBER_OF_CLOCK_CYCLES_PER_GAME_CYCLE];
        }
    }
    
    //-------- Robot Comm Phase
    for (GemBot* bot in robots) {
        if ([bot isAlive]) {
            [bot communicationPhase];
        }
    }
    
    
    
    ////---- Movement phase
    
    for (GemBot* bot in robots) {
        if ([bot isAlive]) {
            [bot updatePosition];
        }
    }
    for (Missile* missile in missiles) {
        [missile updatePosition];
    }
    
    
    
    
    
    
}
@end
