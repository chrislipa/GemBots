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
#import "CompileError.h"

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


-(void) verifyParameter:(int*) verifyParameter :(NSString*) armname {
    if (*verifyParameter < 0 || *verifyParameter > 5) {
        [self compileError:@"%@ armament set to %d", armname, *verifyParameter];
    }
}

-(void) checkIfValid {
    [self verifyParameter:&config_armor:@"armor"];
    [self verifyParameter:&config_engine:@"engine"];
    [self verifyParameter:&config_heatsinks:@"heatsink"];
    [self verifyParameter:&config_mines:@"mines"];
    [self verifyParameter:&config_scanner:@"scanner"];
    [self verifyParameter:&config_shield:@"shield"];
    [self verifyParameter:&config_weapon:@"weapon"];
    int sumOfArms = config_armor + config_engine + config_heatsinks + config_mines + config_scanner + config_shield + config_weapon;
    if (sumOfArms > MAX_ARMAMENT_WEIGHT) {
        [self compileError:@"Sum of armaments is %d", sumOfArms];
    }
    if (highestAddressofRomWrittenTo >= BOT_MAX_MEMORY ) {
        [self compileError:@"Robot too large (%d > %@)",highestAddressofRomWrittenTo, BOT_MAX_MEMORY-1];
    }
}

-(void) compileError:(NSString*) format , ... {
    compiledCorrectly = NO;
    numberOfCompileErrors++;
    va_list args;
    va_start(args, format);
    NSString* string = [[NSString alloc] initWithFormat:format  arguments: args];
    [compileErrors addObject:[CompileError errorWithText:string]];
    
}

-(void) compileWarning:(NSString*) format , ... {
    numberOfCompileWarnings++;
    va_list args;
    va_start(args, format);
    NSString* string = [[NSString alloc] initWithFormat:format arguments: args];
    [compileErrors addObject:[CompileError errorWithText:string]];
}


@end
