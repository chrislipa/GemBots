//
//  GemBot+Memory.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot.h"

@interface GemBot (Memory)
-(void) cleanMemory;
-(void) reallocRAM:(int) targetSize;
-(void) setMemory:(int) addr :(int) value;
-(int) getMemory:(int) addr;

-(void) reallocROM:(int) targetSize;
-(void) setRomMemory:(int) addr :(int) value;
-(int) getRomMemory:(int) addr;
@end
