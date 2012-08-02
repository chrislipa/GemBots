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
    
}





@end
