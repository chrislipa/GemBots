//
//  PGBotNativeEngine+Runtime.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine+Runtime.h"
#import "GemBot+Runtime.h"

@implementation PGBotNativeEngine (Runtime)
 

-(void) setUpNewSetOfRounds {
    
}

-(void) setUpNewRound {
    
}




-(void) isRoundOver {
    
}

-(void) isSetOfRoundsOver {
    
}


-(void) executeGameCycle {
    for (GemBot* bot in robots) {
        if ([bot isAlive]) {
            [bot executeClockCycles:NUMBER_OF_CLOCK_CYCLES_PER_GAME_CYCLE];
        }
    }
    
}
@end
