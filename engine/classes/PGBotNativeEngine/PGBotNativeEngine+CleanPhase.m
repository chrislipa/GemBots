//
//  PGBotNativeEngine+CleanPhase.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/1/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine+CleanPhase.h"
#import "GemBot.h"
@implementation PGBotNativeEngine (CleanPhase)

-(void) cleanPhase {
    internal_explosions_index = 0;

    numberOfExplosionsAppliedThisCycle = 0;


    internal_scans_index = 0;
    internal_soundEffectsInitiatedThisCycle_index = 0;

    for (GemBot* bot in robots) {
        bot.diedLastTurn = NO;
    }
}

@end
