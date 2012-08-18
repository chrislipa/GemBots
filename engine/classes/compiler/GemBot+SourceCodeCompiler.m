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
#import "GemBot+Memory.h"
#import "GemBot+Compiler.h"
#import "EngineUtility.h"

@interface SourceLine : NSObject {
    int lineNumber;
    NSString* originalCaseLine;
    NSString* upperCaseLine;
    NSMutableArray* tokens;
    NSMutableArray* originalCaseTokens;
    NSMutableArray* rangesOfTokens;
}
@property (readwrite,retain) NSString* originalCaseLine;
@property (readwrite,retain) NSString* upperCaseLine;
@property (readwrite,assign) int lineNumber;
@property (readwrite,retain) NSMutableArray* tokens;
@property (readwrite,retain) NSMutableArray* originalCaseTokens;
@property (readwrite,retain) NSMutableArray* rangesOfTokens;
@end

@implementation SourceLine
@synthesize originalCaseLine;
@synthesize lineNumber;
@synthesize upperCaseLine;
@synthesize tokens;
@synthesize originalCaseTokens;
@synthesize rangesOfTokens;
@end


@interface UserVariable : NSObject <UserVariableProtocol> {
    NSString* name;
    bool in_line;
    int location;
    int size;
    NSMutableArray* initialValue;
    NSMutableArray* memoryLocationsOfReferences;
}
@property (readwrite,retain) NSString* name;
@property (readwrite,assign) bool in_line;
@property (readwrite,assign) int location;
@property (readwrite,assign) int size;
@property (readwrite,retain) NSMutableArray* initialValue;

@property (readwrite,retain) NSMutableArray* memoryLocationsOfReferences;

@end

@implementation UserVariable

@synthesize name;
@synthesize in_line;
@synthesize location;
@synthesize size;
@synthesize initialValue;
@synthesize memoryLocationsOfReferences;
@end


@interface Label : NSObject {
    NSString* name;

    int location;
    NSMutableArray* memoryLocationsOfReferences;
}

@property (readwrite,retain) NSString* name;
@property (readwrite,assign) int location;
@property (readwrite,retain) NSMutableArray* memoryLocationsOfReferences;
@end

@implementation Label
@synthesize name;
@synthesize location;
@synthesize memoryLocationsOfReferences;
@end


@implementation GemBot (SourceCodeCompiler)

NSString* stripQuotes(NSString* s) {
    int firstQuote = -1, lastQuote = -1;
    for (int i = 0; i < s.length; i++) {
        if ([s characterAtIndex:i] == '\"') {
            firstQuote = i;
            break;
        }
    }
    for (int i = (int)s.length-1; i >= 0; i--) {
        if ([s characterAtIndex:i] == '\"') {
            lastQuote = i;
            break;
        }
    }
    if (firstQuote < lastQuote) {
        return [s substringWithRange:NSMakeRange(firstQuote+1, lastQuote-firstQuote-1)];
    } else {
        return s;
    }
}

-(void) readDescription:(NSMutableArray*) lines {
    for (int i = 0 ; i < lines.count; i++) {
        SourceLine* s = [lines objectAtIndex:i];
        if (s.tokens.count <1) {
            continue;
        }
        NSString* token = [s.tokens objectAtIndex:0];
        if ([token isEqualToString:@"#NAME"]) {
            self.name = stripQuotes([s.originalCaseLine substringFromIndex:[token length]+1]) ;
            [lines removeObjectAtIndex:i]; i--;
        } else if ([token isEqualToString:@"#AUTHOR"]) {
            self.author = stripQuotes([s.originalCaseLine substringFromIndex:[token length]+1]);
            [lines removeObjectAtIndex:i]; i--;
        } else if ([token isEqualToString:@"#DESCRIPTION"]) {
            self.descript = stripQuotes([s.originalCaseLine substringFromIndex:[token length]+1]);
            [lines removeObjectAtIndex:i]; i--;
        }
    }
}

-(NSMutableArray*) parse:(NSString*) s {
    NSArray* lines = [s componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSMutableArray* parsedLines = [NSMutableArray array];
    for (int lineNumber = 0; lineNumber< lines.count ; lineNumber++) {
        NSString* l = [lines objectAtIndex:lineNumber];
        NSRange r = [l rangeOfString:@"//"];
        NSString* m;
        if (r.location != NSNotFound) {
            m = [l substringToIndex:r.location];
        } else {
            m = l;
        }
        NSRange nonwschar = [m rangeOfCharacterFromSet:[[NSCharacterSet whitespaceAndNewlineCharacterSet] invertedSet]];
        if (nonwschar.location == NSNotFound) {
            continue;
        }
        SourceLine* sl =[[SourceLine alloc] init];
        sl.lineNumber = lineNumber;
        sl.originalCaseLine = m;
        sl.upperCaseLine = [m uppercaseString];
        NSArray* tokensPlusWS = [sl.upperCaseLine componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        sl.tokens = [NSMutableArray array];
        for (NSString* t in tokensPlusWS) {
            if (t.length > 0) {
                [sl.tokens addObject:t];
            }
        }
        NSArray* octokensPlusWS = [sl.originalCaseLine componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        sl.originalCaseTokens = [NSMutableArray array];
        for (NSString* t in octokensPlusWS) {
            if (t.length > 0) {
                [sl.originalCaseTokens addObject:t];
            }
        }
        
        
        sl.rangesOfTokens = [NSMutableArray array];
        unsigned long col = 0;
        for (NSString* token in sl.tokens) {
            NSRange searchRange = NSMakeRange(col, sl.upperCaseLine.length - col);
            NSRange rangeOfToken = [sl.upperCaseLine rangeOfString:token options:0 range:searchRange];
            [sl.rangesOfTokens addObject:[NSValue valueWithRange:rangeOfToken]];
            col = rangeOfToken.location + rangeOfToken.length;
        }
        
        
        [parsedLines addObject:sl];
    }
    return parsedLines;
}


-(void) compileSource {
    NSString* string = [[NSString alloc] initWithData:source encoding:NSUTF8StringEncoding];
    NSMutableArray* lines = [self parse:string];
    [self readDescription:lines];
    [self readArmaments:lines];
    

    NSMutableDictionary* userConstants;
    NSMutableDictionary* labels;
    NSMutableDictionary* strings;
    int sizeOfCode;
    [self readConstants:lines intoConstants:&userConstants];
    [self identifyLabels:lines withConstants:userConstants intoLabels:&labels];
    [self identifyVariables:lines withConstants:userConstants andLabels:labels];
    [self readLogStrings:lines intoLogStrings:&strings];
    [self readmemory:lines withConstants:userConstants andLabels:labels  andSize:&sizeOfCode];
    [self populateLabels:labels];
    [self populateVariables:userVariables at:sizeOfCode];
    logStrings = [NSDictionary dictionaryWithDictionary:strings];
    
}


-(void) populateLabels:(NSMutableDictionary*) labels {

    for (NSString* labelName in labels) {
        Label* label = [labels objectForKey:labelName];
        for (NSNumber* loc in label.memoryLocationsOfReferences) {
            int intloc = [loc intValue];
            [self setRomMemory:intloc :label.location];
        }
        NSNumber* key = [NSNumber numberWithInt:label.location];
        NSMutableSet* setOfLabelsAtPoint = [labelsReverseLookup objectForKey:key];
        if (setOfLabelsAtPoint == nil) {
            setOfLabelsAtPoint = [NSMutableSet set];
            [labelsReverseLookup setObject:setOfLabelsAtPoint forKey:key];
        }
        [setOfLabelsAtPoint addObject:label.name];
    }
}


-(void) populateVariables:(NSMutableDictionary*) variables at:(int) memloc {
    
    
    for (NSString* variableName in variables) {
        UserVariable* var = [variables objectForKey:variableName];
        if (!var.in_line) {
            var.location = memloc;
            memloc += var.size;
        }
        for (int i = 0; i< var.size; i++) {
            [self setRomMemory:var.location+i : [[var.initialValue objectAtIndex:i] intValue]];
        }
        
        
        for (NSNumber* loc in var.memoryLocationsOfReferences) {
            int intloc = [loc intValue];
            [self setRomMemory:intloc: var.location];
        }
        [userVariablesReverseLookup setObject:var.name forKey:[NSNumber numberWithInt:var.location]];
    }
    dataSegmentEndAddress = memloc-1;
}

-(void) readLogStrings:(NSMutableArray*)lines intoLogStrings:(NSMutableDictionary**) plogStrings {
    NSMutableDictionary* zlogStrings = [NSMutableDictionary dictionary];
    for (SourceLine* line in lines) {
        if (line.tokens.count >= 1) {
            NSString* op = [line.tokens objectAtIndex:0];
            Opcode *opc = opcodeFromString(op);
            if (opc) {
                bool found = NO;
                NSRange lastToken;
                int indexOfString=0;
                if (opc.isOp1String) {
                    lastToken = [[line.rangesOfTokens objectAtIndex:0] rangeValue];
                    found = YES;
                    indexOfString = 1;
                }
                if (opc.isOp2String) {
                    if (line.rangesOfTokens.count < 2) {
                        [self compileError:line.lineNumber :NO_RANGE:@"Could not find token on line expecting token and string"];
                        lastToken = [[line.rangesOfTokens objectAtIndex:0] rangeValue];
                    } else {
                        lastToken = [[line.rangesOfTokens objectAtIndex:1] rangeValue];
                    }
                    found = YES;
                    indexOfString = 2;
                }
                if (found) {
                    unsigned long col = lastToken.location + lastToken.length + 1;
                    NSRange rangeOfText = NSMakeRange(col, line.originalCaseLine.length - col);
                    if (rangeOfText.length > line.originalCaseLine.length) {
                        rangeOfText = NSMakeRange(0, 0);
                    }
                    NSString* text = stripQuotes([line.originalCaseLine substringWithRange:rangeOfText]);
                    NSNumber* newLogNumber = [NSNumber numberWithInt:(int)zlogStrings.count];
                    [zlogStrings setObject:text forKey:newLogNumber];
                    NSMutableArray* replacementTokens = [NSMutableArray array];
                    for (int i = 0; i < indexOfString; i++) {
                        [replacementTokens addObject:[line.tokens objectAtIndex:i]];
                    }
                    [replacementTokens addObject:[NSString stringWithFormat:@"%d",[newLogNumber intValue] ]];
                    line.tokens = replacementTokens;
                    
                }
                
            }
        }
    }
    
    
    *plogStrings = zlogStrings;
}

-(void) identifyVariables:(NSMutableArray*) lines withConstants:(NSDictionary*) userConstants andLabels:(NSMutableDictionary*) labels  {
    NSMutableDictionary* variables = [NSMutableDictionary dictionary];
    
    NSDictionary* defaultconstants = constantDictionary();
    for (int i = 0; i < lines.count; i++) {
        SourceLine* line = [lines objectAtIndex:i];
        if (line.tokens.count ==0) {
            return;
        }
        NSString* token = [line.tokens objectAtIndex:0];
        if ([token isEqualToString:@"#DEF"]) {
            int index = 1;
            bool in_line = NO;
            if ([[line.tokens objectAtIndex:index] isEqualToString:@"INLINE"]) {
                index++;
                in_line = YES;
            }
            if (index >= line.tokens.count)  {
                [self compileError:line.lineNumber :NO_RANGE:@"No name given for variable definition"];
                [lines removeObjectAtIndex:i]; i--; continue;
            }
            NSString* ident = [line.tokens objectAtIndex:index];
            
            if ([labels objectForKey:ident]) {
                [self compileError:line.lineNumber :[[line.rangesOfTokens objectAtIndex:index] rangeValue]:@"Variable and label name conflict '%@'",ident];
                [lines removeObjectAtIndex:i]; i--; continue;
            }
            if ([defaultconstants objectForKey:ident]) {
                [self compileError:line.lineNumber :[[line.rangesOfTokens objectAtIndex:index] rangeValue]:@"Variable conflicts with built-in constant '%@'",[line.originalCaseTokens objectAtIndex:index]];
                [lines removeObjectAtIndex:i]; i--; continue;
            }
            if ([userConstants objectForKey:ident]) {
                [self compileError:line.lineNumber :[[line.rangesOfTokens objectAtIndex:index] rangeValue]:@"Label conflicts with user-defined constant '%@'",[line.originalCaseTokens objectAtIndex:index]];
                [lines removeObjectAtIndex:i]; i--; continue;
            }
            if ([variables objectForKey:ident]) {
                [self compileError:line.lineNumber :[[line.rangesOfTokens objectAtIndex:index] rangeValue]:@"Redefinition of variable '%@'",[line.originalCaseTokens objectAtIndex:index]];
                [lines removeObjectAtIndex:i]; i--; continue;
            }
            NSMutableArray* initialValue = [NSMutableArray array];
            
            bool hadError = NO;
            for (index++; index < line.tokens.count; index++) {
                NSString* ivs = [line.tokens objectAtIndex:index];
                if ([ivs isEqualToString:@"="] ) {
                    continue;
                }
                if (!isInteger(ivs)) {
                    [self compileError:line.lineNumber :[[line.rangesOfTokens objectAtIndex:index] rangeValue]:@"Variable definition with non-integer literal '%@'",[line.originalCaseTokens objectAtIndex:index]];
                    hadError = YES;
                    break;
                }
                NSNumber* v = [NSNumber numberWithInt:readInteger(ivs)];
                [initialValue addObject:v];
            }
            if (hadError) {
                [lines removeObjectAtIndex:i]; i--; continue;
            }
            
            if (initialValue.count == 0) {
                [initialValue addObject:[NSNumber numberWithInt:0]];
            }
            
            UserVariable* var = [[UserVariable alloc] init];
            var.name = ident;
            var.in_line = in_line;
            var.initialValue = initialValue;
            var.size = initialValue.count;
            var.memoryLocationsOfReferences = [NSMutableArray array];
            [variables setObject:var forKey:ident];
            
        }
    }
        
    userVariables = variables;
}

-(void) identifyLabels:(NSMutableArray*) lines withConstants:(NSDictionary*) userConstants intoLabels:(NSMutableDictionary**) plabels {
    NSMutableDictionary* labels = [NSMutableDictionary dictionary];
    NSDictionary* defaultconstants = constantDictionary();
    for (int i = 0; i < lines.count; i++) {
        SourceLine* line = [lines objectAtIndex:i];
        if (line.tokens.count ==0) {
            return;
        }
        NSString* token = [line.tokens objectAtIndex:0];
        if ([token hasSuffix:@":"]) {
            token = [token substringToIndex:token.length-1];
            NSString* originalCaseToken = [[line.originalCaseTokens objectAtIndex:0] substringToIndex:token.length-1];
            if (token.length == 0) {
                [self compileError:line.lineNumber :[[line.rangesOfTokens objectAtIndex:0] rangeValue]:@"Cannot have zero-length label"];
                [lines removeObjectAtIndex:i]; i--;
                continue;
            }
            if (line.tokens.count > 1) {
                [self compileWarning:line.lineNumber :[[line.rangesOfTokens objectAtIndex:0] rangeValue]:@"Extraneous token after label '%@'",originalCaseToken];
            }
            if ([labels objectForKey:token]) {
                [self compileError:line.lineNumber :[[line.rangesOfTokens objectAtIndex:0] rangeValue]:@"Duplicate label '%@'",originalCaseToken];
                [lines removeObjectAtIndex:i]; i--;
                continue;
            }
            if ([defaultconstants objectForKey:token]) {
                [self compileError:line.lineNumber :[[line.rangesOfTokens objectAtIndex:0] rangeValue]:@"Label conflicts with built-in constant '%@'",originalCaseToken];
                [lines removeObjectAtIndex:i]; i--;
                continue;
            }
            if ([userConstants objectForKey:token]) {
                [self compileError:line.lineNumber :[[line.rangesOfTokens objectAtIndex:0] rangeValue]:@"Label conflicts with user-defined constant '%@'",originalCaseToken];
                [lines removeObjectAtIndex:i]; i--;
                continue;
            }
            Label* label = [[Label alloc] init];
            label.name = token;
            label.memoryLocationsOfReferences = [NSMutableArray array];
            [labels setObject:label forKey:token];
        }
    }
    
    *plabels = labels;
}

-(void) readConstants:(NSMutableArray*) lines intoConstants:(NSMutableDictionary**) pconstants {
    NSDictionary* defaultconstants = constantDictionary();
    NSMutableDictionary* constants = [NSDictionary dictionary];
    
    for (int i = 0; i<lines.count; i++) {
        SourceLine* line = [lines objectAtIndex:i];
        if (line.tokens.count >= 1 && [[line.tokens objectAtIndex:0] isEqualToString:@"#CONST"]) {
            [lines removeObjectAtIndex:i]; i--;
            if (line.tokens.count < 2) {
                [self compileError:line.lineNumber :NO_RANGE :@"Constant declaration missing identifier"];
                continue;
            }
            if (line.tokens.count < 3) {
                [self compileError:line.lineNumber :NO_RANGE :@"Constant declaration missing value"];
                continue;
            }
            NSString* constantIdentifier = [line.tokens objectAtIndex:1];
            NSString* constantValueStr = [line.tokens objectAtIndex:2];
            if (!isInteger(constantValueStr)) {
                [self compileError:line.lineNumber :[[line.rangesOfTokens objectAtIndex:2] rangeValue] :@"Constant value '%@' is not integer literal", constantValueStr];
                continue;
            }
            if ([defaultconstants objectForKey:constantIdentifier]) {
                [self compileError:line.lineNumber :[[line.rangesOfTokens objectAtIndex:1] rangeValue] :@"Constant name '%@' conflicts with built-in constant", constantIdentifier];
                continue;
            }
            if ([constants objectForKey:constantIdentifier]) {
                [self compileError:line.lineNumber :[[line.rangesOfTokens objectAtIndex:1] rangeValue] :@"Constant name '%@' declared twice", constantIdentifier];
                continue;
            }
            NSNumber* va = [NSNumber numberWithInt:readInteger(constantValueStr)];
            [constants setObject:va forKey:constantIdentifier];
        }
    }
    *pconstants = constants;
}






-(void) readArmaments:(NSMutableArray*) a {

    for (int i = 0; i<a.count; i++) {
        SourceLine* l = [a objectAtIndex:i];
        NSString* firstToken = nil, *secondToken = nil, *thirdToken = nil;
        if ([l.tokens count] > 0) {
            firstToken = [l.tokens objectAtIndex:0];
        }
        if ([l.tokens count] > 1) {
            secondToken = [l.tokens objectAtIndex:1];
        }
        if ([l.tokens count] > 2) {
            thirdToken = [l.tokens objectAtIndex:2];
        }
        
        
        if (firstToken && [firstToken isEqual:@"#ARMAMENT"]) {
            [a removeObjectAtIndex:i];
            i--;
        }
        if (firstToken && [firstToken isEqual:@"#ARMAMENT"] && secondToken && thirdToken) {
            if (!isInteger(thirdToken)) {
                [self compileError: (l.lineNumber) :[[l.rangesOfTokens objectAtIndex:2] rangeValue] :@"Bad armament value %@",[l.originalCaseTokens objectAtIndex:2]];
                continue;
            }
            int v = readInteger(thirdToken);
            if ([secondToken isEqualToString:@"RADAR"]) {
                self.config_scanner = v;
            } else if ([secondToken isEqualToString:@"WEAPON"]) {
                self.config_weapon = v;
            } else if ([secondToken isEqualToString:@"ARMOR"]) {
                self.config_armor = v;
            } else if ([secondToken isEqualToString:@"ENGINE"]) {
                self.config_engine = v;
            } else if ([secondToken isEqualToString:@"HEATSINK"]) {
                self.config_heatsinks = v;
            } else if ([secondToken isEqualToString:@"MINES"]) {
                self.config_mines = v;
            }  else if ([secondToken isEqualToString:@"SHIELD"]) {
                self.config_shield = v;
            } else {
                [self compileError: (l.lineNumber) :[[l.rangesOfTokens objectAtIndex:1] rangeValue] :@"Bad armament type %@",[l.originalCaseTokens objectAtIndex:1]];
                
            }
        } else if (firstToken && [firstToken isEqual:@"#ARMAMENT"] && secondToken) {
            [self compileError: (l.lineNumber) :NO_RANGE:@"Missing armament value"];
            
        } else if (firstToken && [firstToken isEqual:@"#ARMAMENT"]) {
            [self compileError: (l.lineNumber) :NO_RANGE:@"Missing armament type and value"];
        } else {
            
        }
    }

}




-(void) readmemory:(NSArray*) a withConstants:(NSDictionary*) userConstants andLabels:(NSDictionary*) labels  andSize:(int*) size {

    NSDictionary* defaultConstants = constantDictionary();
    NSDictionary* defaultVariables = defaultVariablesDictionary();

    int pc = BOT_SOURCE_CODE_START;
    for (SourceLine* p in a) {
        if ([p.tokens count] == 0) {
            continue;
        }
        NSString* firstToken = [p.tokens objectAtIndex:0];
        if ([firstToken hasSuffix:@":"]) {
            NSString* strippedToken = [firstToken substringToIndex:firstToken.length-1];
            Label* label = [labels objectForKey:strippedToken];
            label.location = pc;
        } else if ([firstToken isEqualToString:@"#DEF"]) {
            if ([[p.tokens objectAtIndex:1] isEqualToString:@"INLINE"]) {
                UserVariable* var = [userVariables objectForKey:[p.tokens objectAtIndex:2]];
                var.location = pc;
                pc += var.size;
            }
        } else {
            if ([p.tokens count] > 3) {
                [self compileWarning: (p.lineNumber) :[[p.rangesOfTokens objectAtIndex:3] rangeValue] :@"Extraneous tokens on line"];
            }
            
            int rtype[2] = {0,0};
            int bytes[3] = {0,0,0};
            bool instructionThisLine = NO;
            
            for (int i = MIN(2, (int)[p.tokens count]-1); i>=0; i--) {
                
                
                NSString* s = [p.tokens objectAtIndex:i];
                
                while ([s hasPrefix:@"*"] || [s hasPrefix:@"&"]) {
                    if  ([s hasPrefix:@"*"]) {
                        rtype[i-1]++;
                    } else if ([s hasPrefix:@"&"]) {
                        rtype[i-1]--;
                    }
                    s = [s substringFromIndex:1];
                }
                
                if ([s hasSuffix:@":"]) {
                    s = [s substringToIndex:s.length-1];
                }
                
                
                if ([labels objectForKey:s]) {
                    Label* label = [labels objectForKey:s];
                    instructionThisLine = YES;
                    [label.memoryLocationsOfReferences addObject:[NSNumber numberWithInt:pc+i]];
                    
                    
                } else if ([defaultVariables objectForKey:s]) {
                    bytes[i] = [[defaultVariables objectForKey:s] intValue];
                    rtype[i-1]++;
                    instructionThisLine = YES;
                } else if ([userVariables objectForKey:s]) {
                    
                    UserVariable* var = [userVariables objectForKey:s];
                    [var.memoryLocationsOfReferences addObject:[NSNumber numberWithInt:pc+i]];
                    
                    rtype[i-1]++;
                    instructionThisLine = YES;
                } else if ([defaultConstants objectForKey:s]) {
                    bytes[i] = [[defaultConstants objectForKey:s] intValue];
                    instructionThisLine = YES;
                } else if ([userConstants objectForKey:s]) {
                    bytes[i] = [[userConstants objectForKey:s] intValue];
                    instructionThisLine = YES;
                } else if (isInteger(s)) {
                    bytes[i] = readInteger(s);
                    instructionThisLine = YES;
                } else {
                    [self compileError:p.lineNumber:[[p.rangesOfTokens objectAtIndex:i] rangeValue]:   @"Unrecognized token: '%@'",s ];
                }
            }
            if (instructionThisLine) {
                bytes[0] |= ((rtype[0] << 16) | (rtype[1] << 24));
                for (int i =0; i<3; i++) {
                    [self setRomMemory:pc++ :bytes[i]];
                }
            }
        }
    }
    *size = pc;
}


@end
