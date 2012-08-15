//
//  PGBotNativeEngine+Heat.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/6/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine+Heat.h"
#import "GemBot.h"
#import "GemBot+Heat.h"
@implementation PGBotNativeEngine (Heat)

-(void) heatPhase {
    for (GemBot* bot in robots) {
        if  (bot.isAlive){
            [bot heatPhase];
        }
    }
}

@end
