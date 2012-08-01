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



-(int) computeRadarFromBot:(GemBot*)bot {
    
}

-(int) computeWideRadarFromBot:(GemBot*)bot {
    
}


-(int) computeSonarFromBot:(GemBot*)bot {
    int rv = -1;
    for (GemBot* g in robots) {
        if ([g isAlive] && g != bot) {
            int 
        }
    }
        
    
}


@end
