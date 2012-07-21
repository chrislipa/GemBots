//
//  ProgramCode.m
//  core
//
//  Created by Christopher Lipa on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProgramCode.h"

@implementation ProgramCode

@synthesize code;

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

+(ProgramCode*) programCodeFromFile:(NSString*) path {
    return [[self alloc] initWithProgramCodeFromFile:path];
}

-(id) initWithProgramCodeFromFile:(NSString*) path {
    if (self = [super init]) {
        
        
        
        NSString* codeString =[self normalizeLineEndings:[[NSMutableString alloc] initWithData:[NSData dataWithContentsOfFile:path] encoding:NSASCIIStringEncoding]];
        ;
        NSArray* lines = [self stripComments:codeString];
        lines = [self readCompilerDirectives:lines];
        lines = [self readVariables:lines];
        [self readConstants];
        [self readCode:lines];
        
    }
    return self;
}

-(void) addConstant:(NSString*) s : (int) x {
    [constants setObject:[NSNumber numberWithInt:x] forKey:s];
}

-(void) readConstants {
    constants = [NSMutableDictionary dictionary];
    [self addConstant:@"nop":0];
    [self addConstant:@"add":1];
    [self addConstant:@"or":2];
    [self addConstant:@"and":4];
    [self addConstant:@"xor":5];
    [self addConstant:@"not":6];
    [self addConstant:@"mpy":7];
    [self addConstant:@"div":8];
    [self addConstant:@"mod":9];
    [self addConstant:@"ret":10];
    [self addConstant:@"gsb":11];
    [self addConstant:@"call":11];
    [self addConstant:@"jmp":12];
    [self addConstant:@"goto":12];
    [self addConstant:@"jls":13];
    [self addConstant:@"jb":13];
    [self addConstant:@"jgr":14];
    [self addConstant:@"ja":14];
    [self addConstant:@"jne":15];
    [self addConstant:@"jeq":16];
    [self addConstant:@"je":16];
    [self addConstant:@"xchg":17];
    [self addConstant:@"swap":17];
    [self addConstant:@"do":18];
    [self addConstant:@"loop":19];
    [self addConstant:@"cmp":20];
    [self addConstant:@"test":21];
    [self addConstant:@"set":22];
    [self addConstant:@"mov":22];
    [self addConstant:@"loc":23];
    [self addConstant:@"get":24];
    [self addConstant:@"put":25];
    [self addConstant:@"int":26];
    [self addConstant:@"ipo":27];
    [self addConstant:@"in":27];
    [self addConstant:@"opo":28];
    [self addConstant:@"out":28];
    [self addConstant:@"del":29];
    [self addConstant:@"delay":29];
    [self addConstant:@"push":30];
    [self addConstant:@"pop":31];
    [self addConstant:@"err":32];
    [self addConstant:@"error":32];
    [self addConstant:@"inc":33];
    [self addConstant:@"dec":34];
    [self addConstant:@"shl":35];
    [self addConstant:@"shr":36];
    [self addConstant:@"rol":37];
    [self addConstant:@"ror":38];
    [self addConstant:@"jz":39];
    [self addConstant:@"jnz":40];
    [self addConstant:@"jae":41];
    [self addConstant:@"jge":41];
    [self addConstant:@"jbe":42];
    [self addConstant:@"jle":42];
    [self addConstant:@"sal":43];
    [self addConstant:@"sar":44];
    [self addConstant:@"neg":45];
    [self addConstant:@"jtl":46];
    [self addConstant:@"p_spedometer":1];
    [self addConstant:@"p_heat":2];
    [self addConstant:@"p_compass":3];
    [self addConstant:@"p_turret_ofs":4];
    [self addConstant:@"p_turret_abs":5];
    [self addConstant:@"p_damage":6];
    [self addConstant:@"p_armor":6];
    [self addConstant:@"p_scan":7];
    [self addConstant:@"p_accuracy":8];
    [self addConstant:@"p_radar":9];
    [self addConstant:@"p_random":10];
    [self addConstant:@"p_rand":10];
    [self addConstant:@"p_throttle":11];
    [self addConstant:@"p_ofs_turret":12];
    [self addConstant:@"p_trotate":12];
    [self addConstant:@"p_abs_turret":13];
    [self addConstant:@"p_taim":13];
    [self addConstant:@"p_steering":14];
    [self addConstant:@"p_weap":15];
    [self addConstant:@"p_weapon":15];
    [self addConstant:@"p_fire":15];
    [self addConstant:@"p_sonar":16];
    [self addConstant:@"p_arc":17];
    [self addConstant:@"p_scanarc":17];
    [self addConstant:@"p_overburn":18];
    [self addConstant:@"p_transponder":19];
    [self addConstant:@"p_shutdown":20];
    [self addConstant:@"p_channel":21];
    [self addConstant:@"p_minelayer":22];
    [self addConstant:@"p_minetrigger":23];
    [self addConstant:@"p_shield":24];
    [self addConstant:@"p_shields":24];
    [self addConstant:@"i_destruct":0];
    [self addConstant:@"i_reset":1];
    [self addConstant:@"i_locate":2];
    [self addConstant:@"i_keepshift":3];
    [self addConstant:@"i_overburn":4];
    [self addConstant:@"i_id":5];
    [self addConstant:@"i_timer":6];
    [self addConstant:@"i_angle":7];
    [self addConstant:@"i_tid":8];
    [self addConstant:@"i_targetid":8];
    [self addConstant:@"i_tinfo":9];
    [self addConstant:@"i_targetinfo":9];
    [self addConstant:@"i_ginfo":10];
    [self addConstant:@"i_gameinfo":10];
    [self addConstant:@"i_rinfo":11];
    [self addConstant:@"i_robotinfo":11];
    [self addConstant:@"i_collisions":12];
    [self addConstant:@"i_resetcolcnt":13];
    [self addConstant:@"i_transmit":14];
    [self addConstant:@"i_receive":15];
    [self addConstant:@"i_dataready":16];
    [self addConstant:@"i_clearcom":17];
    [self addConstant:@"i_kills":18];
    [self addConstant:@"i_deaths":18];
    [self addConstant:@"i_clearmeters":19];
}

-(NSString*) normalizeLineEndings:(NSMutableString*) s {
    [s replaceOccurrencesOfString:@"\r\n" withString:@"\n" options:0 range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\n" options:0 range:NSMakeRange(0, [s length])];
    return [s lowercaseString];
}

-(NSArray*) stripComments:(NSString*) s {
    NSArray* lines = [s componentsSeparatedByString:@"\n"];
    NSMutableArray* outputlines = [NSMutableArray array];
    for (NSString* l in lines) {
        NSRange r = [l rangeOfString:@";"];
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

-(NSArray*) parse:(NSString*)s {
    return [s componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \t=,"]];
}

-(NSArray*) readCompilerDirectives:(NSArray*) a {
    NSMutableArray* o = [NSMutableArray array];
    for (NSString* l in a) {
        if ([l hasPrefix:@"#time"]) {
            self.timeslice = [[[self parse:l] objectAtIndex:1] intValue];
        } else if ([l hasPrefix:@"#msg"]) {
            self.message = [[self parse:l] objectAtIndex:1];
        } else if ([l hasPrefix:@"#config"]) {
            NSArray* p = [l componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \t=,"]];
            NSString* n = [p objectAtIndex:1];
            int v = [[p objectAtIndex:2] intValue];
            if ([n isEqualToString:@"scanner"]) {
                self.scanner = v;
            } else if ([n isEqualToString:@"weapon"]) {
                self.weapon = v;
            } else if ([n isEqualToString:@"armor"]) {
                self.armor = v;
            } else if ([n isEqualToString:@"engine"]) {
                self.engine = v;
            } else if ([n isEqualToString:@"heatsinks"]) {
                self.heatsinks = v;
            } else if ([n isEqualToString:@"mines"]) {
                self.mines = v;
            }  else if ([n isEqualToString:@"shield"]) {
                self.shield = v;
            } 
        } else {
            [o addObject:l];
        }
    }
    return o;
}

-(void) addVariable:(NSString*) s : (int) loc {
     [self.variables setObject:[NSNumber numberWithInt:loc] forKey:s];
}

-(NSArray*) readVariables:(NSArray*) a {
    int numberOfVariables = 0;
    self.variables = [NSMutableDictionary dictionary];
    NSMutableArray* o = [NSMutableArray array];
    for (NSString* l in a) {
        NSArray* p = [self parse:l];
        if ([[p objectAtIndex:0] isEqualToString:@"#def"]) {
            NSString* name = [p objectAtIndex:1];
            if ([self.variables objectForKey:name]==nil && 
                self.variables.count < 256)
                {
                    [self.variables setObject:[NSNumber numberWithInt:128+numberOfVariables] forKey:name];
                    numberOfVariables++;
                 }
        } else {
            [o addObject:l];
        }
    }
    [self addVariable:@"dspd":0];
    [self addVariable:@"dhd":1];
    [self addVariable:@"tpos":2];
    [self addVariable:@"acc":3];
    [self addVariable:@"swap":4];
    [self addVariable:@"tr-id":5];
    [self addVariable:@"tr-dir":6];
    [self addVariable:@"tr-spd":7];
    [self addVariable:@"colcnt":8];
    [self addVariable:@"meters":9];
    [self addVariable:@"combase":10];
    [self addVariable:@"comend":11];
    [self addVariable:@"tr-vel":13];
    [self addVariable:@"flags":64];
    [self addVariable:@"ax":65];
    [self addVariable:@"bx":66];
    [self addVariable:@"cx":67];
    [self addVariable:@"dx":68];
    [self addVariable:@"ex":69];
    [self addVariable:@"fx":70];
    [self addVariable:@"sp":71];
    
    return o;
}



-(void) readCode:(NSArray*) a {
    code = malloc(65536*sizeof(short int));
    dereferenceCount = malloc(65536*sizeof(char));
    isLabel = malloc(65536*sizeof(char));
    labels = [NSMutableDictionary dictionary];
    for (int i = 0; i < 65536; i++) {
        code[i] = 0;
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
                code[pc] = [labelEnumeration count];
                [labelEnumeration addObject:s];
            } else if ([self.variables objectForKey:s]) {
                code[pc] = [[self.variables objectForKey:s] shortValue];
                dereferenceCount[pc]++;
            } else if ([constants objectForKey:s]) {
                code[pc] = [[self.variables objectForKey:s] shortValue];
            } else if ([s hasPrefix:@"0x"] || [s hasPrefix:@"-0x"]) {
                NSScanner *sc = [NSScanner scannerWithString:s];
                unsigned int r = 0;
                [sc setScanLocation:0];
                [sc scanHexInt:&r];
                code[pc] = r;
            } else {
                code[pc]  = [s intValue];
            }
            
            
            first = NO;
        }
    }
    
}


-(void) dealloc {
    free(isLabel);
    free(code);
    free(dereferenceCount);
}

@end
