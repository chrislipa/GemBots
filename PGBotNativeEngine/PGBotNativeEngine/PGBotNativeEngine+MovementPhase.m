//
//  PGBotNativeEngine+MovementPhase.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/1/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine+MovementPhase.h"
#import "GemBot.h"
#import "Missile.h"
#import "GemBot+Interface.h"
#import "Missile+Interface.h"

@implementation PGBotNativeEngine (MovementPhase)
-(void) movementPhase {
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
