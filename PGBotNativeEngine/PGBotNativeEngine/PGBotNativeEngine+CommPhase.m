//
//  PGBotNativeEngine+CommPhase.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/1/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine+CommPhase.h"
#import "GemBot.h"
#import "GemBot+Communication.h"

@implementation PGBotNativeEngine (CommPhase)


-(void) communicationPhase {
    for (GemBot* bot in robots) {
        if ([bot isAlive]) {
            [bot communicationPhaseSend];
        }
    }
    for (GemBot* bot in robots) {
        if ([bot isAlive]) {
            [bot communicationPhaseSwitchChannels];
        }
    }
}
@end
