//
//  GemBot+BinaryCompiler.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+BinaryCompiler.h"
#import "SBJson.h"
#import "EngineDefinitions.h"
#import "EngineUtility.h"
#import "GemBot+Memory.h"
@implementation GemBot (BinaryCompiler)


-(void) compileBinary {
    


            const char* bytes = [source bytes];
            NSUInteger length = [source length];
            int i;
            for(i = 0; i<length && bytes[i]!=0;i++);
            NSString* json = [NSString stringWithCString:bytes encoding:NSUTF8StringEncoding];
            NSDictionary* compilerConfig = [json JSONValue];
            for (NSString* key in compilerConfig) {
                id value = [compilerConfig objectForKey:key];
                NSString* upperCaseKey = [key uppercaseString];
                if ([upperCaseKey isEqualToString:@"NAME"]) {
                    self.name = value;
                } if ([upperCaseKey isEqualToString:@"AUTHOR"]) {
                    self.author = value;
                } if ([upperCaseKey isEqualToString:@"DESCRIPTION"]) {
                    self.descript = value;
                } else if ([upperCaseKey isEqualToString:@"ARMAMENT"]) {
                    for (NSString* key2 in (NSDictionary*)value) {
                        int value2 = readInteger([compilerConfig objectForKey:key2]);
                        NSString* upperCaseKey2 = [key2 uppercaseString];
                        if  ([upperCaseKey2 isEqualToString:@"WEAPON"]) {
                            config_weapon = value2;
                        } else if  ([upperCaseKey2 isEqualToString:@"RADAR"]) {
                            config_scanner = value2;
                        } else if  ([upperCaseKey2 isEqualToString:@"ARMOR"]) {
                            config_armor = value2;
                        } else if  ([upperCaseKey2 isEqualToString:@"MINES"]) {
                            config_mines = value2;
                        } else if  ([upperCaseKey2 isEqualToString:@"SHIELD"]) {
                            config_shield = value2;
                        } else if  ([upperCaseKey2 isEqualToString:@"HEATSINK"]) {
                            config_heatsinks = value2;
                        } else if  ([upperCaseKey2 isEqualToString:@"ENGINE"]) {
                            config_engine = value2;
                        }
                    }
                }
            }
            
            const char* code = bytes+i+1;
            NSUInteger codeLen = length-i-1;
            int numberOfMemoryLocations = (codeLen+3) / 4;
            [self reallocRAM:numberOfMemoryLocations+BOT_SOURCE_CODE_START];
            for (int i = 0; i<codeLen; i+=4) {
                int byte0 = (i<codeLen ?  code[i] : 0);
                int byte1 = (i+1<codeLen ?  code[i+1] : 0);
                int byte2 = (i+2<codeLen ?  code[i+2] : 0);
                int byte3 = (i+3<codeLen ?  code[i+3] : 0);
                int word = (byte0) + (byte1<<8) + (byte2<<16) + (byte3 << 24);
                memory[i+BOT_SOURCE_CODE_START] = word;
            }
            linesOfCode = (numberOfMemoryLocations+2)/3;
             
}
@end
