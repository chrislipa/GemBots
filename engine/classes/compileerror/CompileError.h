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
}

@property (readwrite,retain) NSString* text;
@property (readwrite,assign) bool isError;
@property (readwrite,assign) bool isWarning;


+(CompileError*) errorWithText:(NSString*) text;
+(CompileError*) warningWithText:(NSString*) text;
@end
