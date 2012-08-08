//
//  GemBot+Compiler.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot.h"

@interface GemBot (Compiler)

-(void) compile;
-(void) compileWarning:(NSString*) format , ... ;
-(void) compileError:(NSString*) format , ... ;

@end