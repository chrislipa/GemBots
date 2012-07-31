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
@synthesize sessionUniqueRobotIdentifier;

@synthesize name;
@synthesize description;
@synthesize author;
@synthesize x;
@synthesize y;
@synthesize heading;
@synthesize armor;
@synthesize heat;
@synthesize kills;
@synthesize deaths;
@synthesize wins;
@synthesize loses;
@synthesize shieldOn;
@synthesize overburnOn;
@synthesize numberOfMissilesFired;
@synthesize numberOfMissilesConnected;
@synthesize numberOfMinesLayed;
@synthesize numberOfMinesConnected;
@synthesize numberOfTimesHit;
@synthesize team;
@synthesize compiledCorrectly;
@synthesize compileError;

@synthesize memory;


@synthesize scanner;
@synthesize weapon;

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
        
        NSArray* lines = [self stripComments:string];
        [self readDescription:lines];
        lines = [self tokenize:lines];
        lines = [self readCompilerDirectives:lines];
        
        NSMutableDictionary* variables;
        
        lines = [self readVariables:lines withVariable:&variables];
        
        [self readmemory:lines withVariable:variables];
        
    }
    return self;
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

-(void) reallocRAM:(int) targetSize {
    if (memory == NULL) {
        memory = (int*)malloc(targetSize * sizeof(int));
        memorySize = targetSize;
        for (int i = 0; i < memorySize; i++) {
            memory[i] = 0;
        }
        return;
    } else {
        int old_size = memorySize;
        int new_size = memorySize;
        while (new_size < targetSize) {
            new_size <<= 2;
        }
        new_size = MIN(new_size, BOT_MAX_MEMORY);
        memory = (int*)realloc(memory, targetSize * sizeof(int));
        memorySize = targetSize;
        for (int i = old_size; i < memorySize; i++) {
            memory[i] = 0;
        }
    }
}
                        

-(void) readmemory:(NSArray*) a withVariable:(NSMutableDictionary*) variables{
    int numberOfInstructions = (int)[a count];
    [self reallocRAM:numberOfInstructions*3];
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
            
            while ([s hasPrefix:@"#"]) {
                s = [s substringFromIndex:1];
                rtype[i-1]++;
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



-(id) initWithBinary:(NSString*) binaryStr {
    if (self = [super init]) {
                                
    }
    return self;
}
+(GemBot*) gemBotFromBinary:(NSString*) binary{
    return [[self alloc] initWithBinary:binary];
}


-(void) dealloc {

    free(memory);
}
@end
