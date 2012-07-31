//
//  GemBot+Runtime.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Runtime.h"
#import "PGBotNativeEngine.h"

@implementation GemBot (Runtime)



-(void) executeClockCycles:(int) clockCycles withEnvironment:(PGBotNativeEngine*) engine {
    savedClockCycles += clockCycles;
    
}
@end
