//
//  PGBotNativeEngine+CheckForEndOfMatch.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/1/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine+CheckForEndOfMatch.h"
#import "GemBot.h"
@implementation PGBotNativeEngine (CheckForEndOfMatch)

-(bool) checkForEndMatchPhase {
    bool foundRobot = NO;
    int teamOfFoundRobot = -1;
    for (GemBot* bot in robots) {
        if ([bot isAlive]) {
            if (!foundRobot) {
                foundRobot = YES;
                teamOfFoundRobot = bot.team;
            } else {
                if (bot.team != teamOfFoundRobot) {
                    return NO;
                }
            }
        }
    }
    return YES;
}
@end
