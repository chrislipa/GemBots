//
//  GemBot+Compiler.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Compiler.h"
#import "GemBot+BinaryCompiler.h"
#import "GemBot+SourceCodeCompiler.h"
@implementation GemBot (Compiler)

-(void) compile {
    [self cleanBetweenRounds];
    const char* bytes = [source bytes];
    int i = 0;
    for (int i = 0; i < [source length]; i++) {
        if (bytes[i] != ' ' && bytes[i] !='\n' && bytes[i] != '\t' && bytes[i] != '\r') {
            break;
        }
    }
    if (i < [source length] && bytes[i] == '{') {
        [self compileBinary];
    } else {
        [self compileSource];
    }
}

-(void) cleanBetweenRounds {
    
    
    name=nil;
    descript=nil;
    author=nil;
    
    config_scanner=0;
    config_weapon=0;
    config_engine=0;
    config_heatsinks=0;
    config_mines=0;
    config_shield=0;
    config_armor=0;
    
    free(memory);
    memory = 0;
    memorySize = 0;
    
    
    compiledCorrectly = NO;
    compileError = nil;
    linesOfCode = 0;

    internal_armor = 0;
    internal_x = 0;
    internal_y = 0;
    internal_heat =  0;
    
    shieldOn = NO;
    overburnOn = NO;
}

@end
