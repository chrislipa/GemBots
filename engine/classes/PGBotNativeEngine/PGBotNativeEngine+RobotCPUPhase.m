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

-(bool) robotCPUPhase:(NSArray*) trace {
    if (trace ==nil) {
        int numberToExecute = NUMBER_OF_CLOCK_CYCLES_PER_GAME_CYCLE - gameCycleStateCPUCyclesExecuted;
        for (GemBot* bot in robots) {
            if ([bot isAlive]) {
                [bot executeClockCycles:numberToExecute:YES];
            }
        }
        gameCycleStateCPUCyclesExecuted += numberToExecute;
        return YES;
    } else {
        int maxnumberToExecute = NUMBER_OF_CLOCK_CYCLES_PER_GAME_CYCLE - gameCycleStateCPUCyclesExecuted;
        int numberActuallyExecuted = 0;

        
        bool tracedRobotExecutedInstruction = NO;
        
        
        
            for (GemBot* bot in robots) {
                if ([bot isAlive]) {
                    bool didFinishInstruction = [bot executeClockCycles:0:YES];
                    if (didFinishInstruction && [trace containsObject:bot.sessionUniqueRobotIdentifier]) {
                        tracedRobotExecutedInstruction = YES;
                    }
                }
            }
            
        
        if (!tracedRobotExecutedInstruction) {
            for (int i =0; i<maxnumberToExecute; i++) {
                for (GemBot* bot in robots) {
                    if ([bot isAlive]) {
                        bool didFinishInstruction = [bot executeClockCycles:1:NO];
                        if (didFinishInstruction && [trace containsObject:bot.sessionUniqueRobotIdentifier]) {
                            tracedRobotExecutedInstruction = YES;
                        }
                    }
                }
                numberActuallyExecuted++;
                if (tracedRobotExecutedInstruction) {
                    break;
                }
            }
        }
        
        gameCycleStateCPUCyclesExecuted += numberActuallyExecuted;
        return tracedRobotExecutedInstruction;
    }
}
@end
