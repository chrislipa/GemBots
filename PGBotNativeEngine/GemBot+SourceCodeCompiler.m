//
//  GemBot+SourceCodeCompiler.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+SourceCodeCompiler.h"
#import "EngineDefinitions.h"
#import "EngineUtility.h"

@implementation GemBot (SourceCodeCompiler)


-(NSArray*) readDescription:(NSArray*) lines {
    NSMutableArray* o = [[NSMutableArray alloc] init];
    for (NSString* s in lines) {
        NSString* t = nil;
        
        NSArray* tags = [NSArray arrayWithObjects:@"#NAME ",@"#AUTHOR ",@"#DESCRIPTION ", nil];
        for (NSString* tag in tags) {
            if  ([s hasPrefix:tag]) {
                t = [s substringFromIndex:[tag length]];
            }
        }
        if ([s hasPrefix:@"#NAME "]) {
            self.name = t;
        } else if ([s hasPrefix:@"#AUTHOR "]) {
            self.author = t;
        } else if ([s hasPrefix:@"#DESCRIPTION "]) {
            self.descript = t;
        } else {
            [o addObject:s];
        }
    }
    return o;
}



-(void) compileSource {
    NSString* string = [[NSString alloc] initWithData:source encoding:NSUTF8StringEncoding];
    NSArray* lines = [self stripComments:string];
    [self readDescription:lines];
    lines = [self tokenize:lines];
    lines = [self readCompilerDirectives:lines];
    
    NSMutableDictionary* variables;
    
    lines = [self readVariables:lines withVariable:&variables];
    
    [self readmemory:lines withVariable:variables];
    
    
}

-(NSArray*) tokenize:(NSArray*) inA {
    NSMutableArray* o = [[NSMutableArray alloc] init];
    for (NSString* line in inA) {
        NSArray* a = [line componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([a count] > 0) {
            [o addObject:a];
        }
    }
    return o;
}

-(NSArray*) stripComments:(NSString*) s {
    NSArray* lines = [s componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSMutableArray* outputlines = [NSMutableArray array];
    for (NSString* l in lines) {
        NSRange r = [l rangeOfString:@"//"];
        NSString* m;
        if (r.location != NSNotFound) {
            m = [l substringToIndex:r.location];
        } else {
            m = l;
        }
        [outputlines addObject:m];
    }
    return outputlines;
}


-(NSArray*) readCompilerDirectives:(NSArray*) a {
    NSMutableArray* o = [NSMutableArray array];
    for (NSArray* l in a) {
        NSString* firstToken = nil, *secondToken = nil, *thirdToken = nil;
        if ([l count] > 0) {
            firstToken = [l objectAtIndex:0];
        }
        if ([l count] > 1) {
            secondToken = [l objectAtIndex:1];
        }
        if ([l count] > 2) {
            thirdToken = [l objectAtIndex:2];
        }
        
        if (firstToken && [firstToken isEqual:@"#ARMAMENT"] && secondToken && thirdToken) {
            int v = readInteger(thirdToken);
            if ([secondToken isEqualToString:@"RADAR"]) {
                self.scanner = v;
            } else if ([secondToken isEqualToString:@"WEAPON"]) {
                self.weapon = v;
            } else if ([secondToken isEqualToString:@"ARMOR"]) {
                self.armor = v;
            } else if ([secondToken isEqualToString:@"ENGINE"]) {
                self.engine = v;
            } else if ([secondToken isEqualToString:@"HEATSINK"]) {
                self.heatsinks = v;
            } else if ([secondToken isEqualToString:@"MINES"]) {
                self.mines = v;
            }  else if ([secondToken isEqualToString:@"SHIELD"]) {
                self.shield = v;
            }
        } else {
            [o addObject:l];
        }
    }
    return o;
}


-(NSArray*) readVariables:(NSArray*) a withVariable:(NSMutableDictionary**) variablesPTR {
    NSMutableDictionary* variables = [NSMutableDictionary dictionaryWithDictionary: defaultVariablesDictionary()];
    NSMutableDictionary* variablesReverseLookup = [NSMutableDictionary dictionary];
    int currentlyOpenVariableSlot = 512;
    int maxVariableSlot = 1023;
    
    
    NSMutableArray* o = [NSMutableArray array];
    for (NSArray* p in a) {
        if ([[p objectAtIndex:0] isEqualToString:@"#DEF"]) {
            if ([p count] >= 2) {
                int memLocation = -1;
                if ([p count] >= 3) {
                    memLocation = readInteger([p objectAtIndex:2]);
                } else {
                    while ([variablesReverseLookup objectForKey:[NSNumber numberWithInt:currentlyOpenVariableSlot] ]) {
                        currentlyOpenVariableSlot++;
                    }
                    memLocation = currentlyOpenVariableSlot;
                    if (memLocation > maxVariableSlot) {
                        memLocation = -1;
                    }
                    
                }
                if (memLocation > 0) {
                    NSString* varname = [p objectAtIndex:1];
                    if ([variables objectForKey:name]==nil) {
                        [variables setObject:[NSNumber numberWithInt:memLocation] forKey:varname];
                        [variablesReverseLookup setObject:varname forKey:[NSNumber numberWithInt:memLocation]];
                    }
                }
                
            }
        } else {
            [o addObject:p];
        }
    }
    (*variablesPTR) = variables;
    return o;
}

-(void) readmemory:(NSArray*) a withVariable:(NSMutableDictionary*) variables{
    int numberOfInstructions = (int)[a count];
    [self reallocRAM:numberOfInstructions*3+BOT_SOURCE_CODE_START];
    NSDictionary* constants = constantDictionary();
    NSMutableDictionary* labels = [NSMutableDictionary dictionary];
    NSMutableArray* pointersToLabels = [NSMutableArray array];
    int pc = BOT_SOURCE_CODE_START;
    for (NSArray* p in a) {
        
        int rtype[2] = {0,0};
        int bytes[3] = {0,0,0};
        bool isLabel = NO;
        for (int i = (int)[p count]-1; i>=0; i--) {
            
            
            NSString* s = [p objectAtIndex:i];
            
            while ([s hasPrefix:@"*"] || [s hasPrefix:@"&"]) {
                if  ([s hasPrefix:@"*"]) {
                    rtype[i-1]++;
                } else if ([s hasPrefix:@"&"]) {
                    rtype[i-1]--;
                }
                s = [s substringFromIndex:1];
            }
            if (i == 0 && [s hasSuffix:@":"]) {
                [labels setObject:[NSNumber numberWithInt:pc] forKey:s];
                isLabel = YES;
            } else if ([s hasSuffix:@":"]) {
                [pointersToLabels addObject:[NSArray arrayWithObjects:[NSNumber numberWithInt:pc], s, nil ]];
            } else if ([variables objectForKey:s]) {
                bytes[i] = [[variables objectForKey:s] intValue];
                rtype[i-1]++;
            } else if ([constants objectForKey:s]) {
                bytes[i] = [[constants objectForKey:s] intValue];
            } else {
                bytes[i] = readInteger(s);
            }
        }
        bytes[0] |= ((rtype[0] << 16) | (rtype[1] << 24));
        for (int i =0; i<3; i++) {
            memory[pc++] = bytes[i];
        }
    }
    for (NSArray* a in pointersToLabels) {
        int memLoc = [[a objectAtIndex:0] intValue];
        NSString* label = [a objectAtIndex:1];
        int labelLoc = [[labels objectForKey:label] intValue];
        memory[memLoc] = labelLoc;
    }
    linesOfCode = (pc - 1024 + 2) / 3;
}


@end
