//
//  GemBot+Disassembly.h
//  GemBotEngine
//
//  Created by Christopher Lipa on 8/12/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot.h"

@interface GemBot (Disassembly)
-(NSArray*) internalDisassembledSourceAtAddress:(int)pc ;
NSString* sizeTo10(NSString* s) ;
@end
