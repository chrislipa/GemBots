//
//  GemBot+Runtime.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot.h"
#import "PGBotNativeEngine.h"

@interface GemBot (Runtime)


-(bool) executeClockCycles:(int) clockCycles :(bool) executeZeroTimeInstructions;

@end
