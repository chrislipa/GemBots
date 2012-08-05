//
//  CompileError.h
//  bot
//
//  Created by Christopher Lipa on 8/4/12.
//
//

#import <Foundation/Foundation.h>

@protocol CompileErrorProtocol <NSObject>

-(NSString*) text;
-(bool) isError;
-(bool) isWarning;

@end
