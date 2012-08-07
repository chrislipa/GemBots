//
//  PGBotNativeEngine+RobotCPUPhase.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/1/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine+RobotCPUPhase.h"
#import "GemBot+Runtime.h"

@implementation PGBotNativeEngine (RobotCPUPhase)

-(void) robotCPUPhase {
    for (GemBot* bot in robots) {
        if ([bot isAlive]) {
            [bot executeClockCycles:NUMBER_OF_CLOCK_CYCLES_PER_GAME_CYCLE];
        }
    }
}
@end
