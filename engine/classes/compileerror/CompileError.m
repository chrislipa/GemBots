//
//  CompileError.m
//  bot
//
//  Created by Christopher Lipa on 8/4/12.
//
//

#import "CompileError.h"

@implementation CompileError
@synthesize text;
@synthesize isError;
@synthesize isWarning;
@synthesize line;
@synthesize range;
-(id) initWithText:(NSString*) ptext {
    if (self = [super init]) {
        text = ptext;
    }
    return self;
}

+(CompileError*) errorWithText:(NSString*) text : (int) line :  (NSRange) range {
    CompileError* error = [[CompileError alloc] initWithText: text];
    error.isError = YES;
    error.line = line;
    error.range = range;
    return error;
}
+(CompileError*) warningWithText:(NSString*) text : (int) line :  (NSRange) range {
    CompileError* error = [[CompileError alloc] initWithText: text];
    error.isWarning = YES;
    error.line = line;
    error.range = range;
    return error;
}
@end
