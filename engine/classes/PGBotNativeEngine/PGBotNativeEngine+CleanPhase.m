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
    explosions = [NSMutableArray array];
    numberOfExplosionsAppliedThisCycle = 0;
    scans = [NSMutableArray array];
    explosions =[NSMutableArray array];
    soundEffectsInitiatedThisCycle = [NSMutableArray array];
    for (GemBot* bot in robots) {
        bot.diedLastTurn = NO;
    }
}

@end
