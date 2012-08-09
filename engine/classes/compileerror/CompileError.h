//
//  CompileError.h
//  bot
//
//  Created by Christopher Lipa on 8/4/12.
//
//

#import <Foundation/Foundation.h>
#import "CompileErrorProtocol.h"
@interface CompileError : NSObject<CompileErrorProtocol>  {
    NSString* text;
    bool isError;
    bool isWarning;
    int line;
    NSRange range;
}

@property (readwrite,retain) NSString* text;
@property (readwrite,assign) bool isError;
@property (readwrite,assign) bool isWarning;
@property (readwrite,assign) int line;
@property (readwrite,assign) NSRange range;

+(CompileError*) errorWithText:(NSString*) text : (int) line :  (NSRange) range;
+(CompileError*) warningWithText:(NSString*) text : (int) line :  (NSRange) range;
@end
