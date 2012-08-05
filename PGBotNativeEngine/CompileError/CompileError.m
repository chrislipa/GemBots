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

-(id) initWithText:(NSString*) ptext {
    if (self = [super init]) {
        text = ptext;
    }
    return self;
}

+(CompileError*) errorWithText:(NSString*) text {
    CompileError* error = [[CompileError alloc] initWithText: text];
    error.isError = YES;
    return error;
}
+(CompileError*) warningWithText:(NSString*) text {
    CompileError* error = [[CompileError alloc] initWithText: text];
    error.isWarning = YES;
    return error;
}
@end
