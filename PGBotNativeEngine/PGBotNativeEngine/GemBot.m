//
//  GemBot.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot.h"
#import "EngineUtility.h"
@implementation GemBot
@synthesize memory;

@synthesize variables;
@synthesize labels;

@synthesize timeslice;
@synthesize message;

@synthesize scanner;
@synthesize weapon;
@synthesize armor;
@synthesize engine;
@synthesize heatsinks;
@synthesize mines;
@synthesize shield;

+(GemBot*) gemBotFromString:(NSString*) string; {
    return [[self alloc] initWithString:string];
}

-(NSArray*) readDescription:(NSArray*) lines {
    NSMutableArray* o = [[NSMutableArray alloc] init];
    for (NSString* s in lines) {
        NSString* t = nil;
        int indent = 0;
        NSArray* tags = [NSArray arrayWithObjects:@"#NAME ",@"#AUTHOR ",@"#DESCRIPTION ", nil]
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
            self.description = t;
        } else {
            [o addObject:s];
        }
    }
    return o;
}

-(id) initWithString:(NSString*) string {
    if (self = [super init]) {
        memory = NULL;
        memorySize = 0;
        
        variables = [NSMutableDictionary dictionary];
        currentlyOpenVariableSlot = 512;
        variablesReverseLookup = [NSMutableDictionary dictionary];
        
        NSArray* lines = [self stripComments:string];
        [self readDescription:lines];
        lines = [self tokenize:lines];
        lines = [self readCompilerDirectives:lines];
        
        lines = [self readVariables:lines];
        
        [self readmemory:lines];
        
    }
    return self;
}

-(NSArray*) tokenize:(NSArray*) inA {
    NSMutableArray* o = [[NSMutableArray alloc] init];
    for (NSString* line = inA) {
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
        NSString* firstToken = nil, secondToken = nil, thirdToken = nil;
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



-(NSArray*) readVariables:(NSArray*) a {
    NSMutableDictionary* variablesReverseLookup = [NSMutableDictionary dictionary];
    int currentlyOpenVariableSlot = 512;
    int maxVariableSlot = 1023;
    self.variables = [NSMutableDictionary dictionaryWithDictionary: defaultVariablesDictionary()];
    
    NSMutableArray* o = [NSMutableArray array];
    for (NSArray* p in a) {
        if ([[p objectAtIndex:0] isEqualToString:@"#DEF"]) {
            if ([p count] >= 2) {
                int memLocation = -1;
                if ([p count] >= 3) {
                    memLocation = readInteger([p objectAtIndex:2])
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
                    NSString* name = [p objectAtIndex:1];
                    if ([self.variables objectForKey:name]==nil)
                        
                    {
                        
                        [self.variables setObject:[NSNumber numberWithInt:memLocation] forKey:name];
                        [currentlyOpenVariableSlot setObject:name forKey:[NSNumber numberWithInt:memLocation]];
                        
                        
                    }
                }
                        
            }
        } else {
            [o addObject:l];
        }
    }
    return o;
}

-(void) reallocRAM:(int) targetSize {
    if (memory == NULL) {
        memory = (int*)malloc(targetSize * sizeof(int));
        memorySize = targetSize;
        return;
    } else {
        int new_size = memorySize;
        while (new_size < targetSize) {
            new_size <<= 2;
        }
        new_size = MIN(new_size, BOT_MAX_MEMORY);
        memory = (int*)realloc(memory, targetSize * sizeof(int));
        memorySize = targetSize;
    }
}
                        

-(void) readmemory:(NSArray*) a {
    int numberOfInstructions = [a count];
    [self reallocRAM:numberOfInstructions*3];
    
    NSMutableDictionary* labels = [NSMutableDictionary dictionary];
    NSMutableArray* labelEnumeration = [NSMutableDictionary dictionary];
    

    
    dereferenceCount = malloc(65536*sizeof(char));
    isLabel = malloc(65536*sizeof(char));
    labels = [NSMutableDictionary dictionary];
    for (int i = 0; i < 65536; i++) {
        memory[i] = 0;
        dereferenceCount[i] = 0;
        isLabel = 0;
    }
    int pc = 1024;
    for (NSString* l in a) {
        NSArray* p = [self parse:l];
        bool first = YES;
        for (NSString* t in p) {
            NSString* s = t;
            while ([s hasPrefix:@"@"] || ([s hasPrefix:@"["] && [s hasSuffix:@"]"])) {
                if ([s hasPrefix:@"@"]) {
                    s = [s substringFromIndex:1];
                    dereferenceCount[pc]++;
                } else if ([s hasPrefix:@"["] && [s hasSuffix:@"]"]) {
                    s = [s substringWithRange:NSMakeRange(1, [s length]-2)];
                    dereferenceCount[pc]++;
                }
            }
            if (first && ([s hasPrefix:@":"] || [s hasPrefix:@"!"])) {
                [labels setObject:[NSNumber numberWithInt:pc] forKey:s];
            } else if ([s hasPrefix:@":"] || [s hasPrefix:@"!"]) {
                isLabel[pc] = YES;
                memory[pc] = [labelEnumeration count];
                [labelEnumeration addObject:s];
            } else if ([self.variables objectForKey:s]) {
                memory[pc] = [[self.variables objectForKey:s] shortValue];
                dereferenceCount[pc]++;
            } else if ([constants objectForKey:s]) {
                memory[pc] = [[self.variables objectForKey:s] shortValue];
            } else if ([s hasPrefix:@"0x"] || [s hasPrefix:@"-0x"]) {
                NSScanner *sc = [NSScanner scannerWithString:s];
                unsigned int r = 0;
                [sc setScanLocation:0];
                [sc scanHexInt:&r];
                memory[pc] = r;
            } else {
                memory[pc]  = [s intValue];
            }
            
            
            first = NO;
        }
    }
    
}


-(void) dealloc {
    free(isLabel);
    free(memory);
    free(dereferenceCount);
}
@end
