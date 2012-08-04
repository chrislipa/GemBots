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
#import "GemBot+Memory.h"
#import "EngineUtility.h"
#import "Gembot+Reset.h"

@implementation GemBot (Compiler)

-(void) compile {
    [self cleanForRecompile];
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
    
    [self countLinesOfCode];
    [self checkIfValid];
}



-(void) countLinesOfCode {
    int x = romMemorySize-1;
    while (x >= SOURCE_START && romMemory[x] == 0) {x--;}
    linesOfCode = (x - SOURCE_START + 3) / 3;
}


-(void) verifyParameter:(int*) verifyParameter {
    if (*verifyParameter < 0 || *verifyParameter > 5) {
        compiledCorrectly = NO;
    }
}

-(void) checkIfValid {
    [self verifyParameter:&config_armor];
    [self verifyParameter:&config_engine];
    [self verifyParameter:&config_heatsinks];
    [self verifyParameter:&config_mines];
    [self verifyParameter:&config_scanner];
    [self verifyParameter:&config_shield];
    [self verifyParameter:&config_weapon];
    if (config_armor + config_engine + config_heatsinks + config_mines + config_scanner + config_shield + config_weapon > MAX_ARMAMENT_WEIGHT) {
        compiledCorrectly = NO;
    }
}


@end
