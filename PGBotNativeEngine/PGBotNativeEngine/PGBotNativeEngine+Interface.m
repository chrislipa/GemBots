//
//  PGBotNativeEngine+Interface.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine+Interface.h"
#import "GemBot.h"
@implementation PGBotNativeEngine (Interface)
-(int) numberOfRobotsAlive {
    int count = 0;
    for (GemBot* b in robots) {
        if ([b isAlive]) {
            count++;
        }
    }
    return count;
}
@end
