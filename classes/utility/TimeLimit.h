//
//  TimeLimit.h
//  bot
//
//  Created by Christopher Lipa on 8/4/12.
//
//

#import <Cocoa/Cocoa.h>

@interface TimeLimit : NSView {
    int cycles;
    NSString* shortStringDescription;
    NSString* longStringDescription;
    bool isDefault;
}
@property (readwrite) bool isDefault;
@property (readwrite) int cycles;
@property (readwrite) NSString* shortStringDescription;
@property (readwrite) NSString* longStringDescription;
+(NSArray*) standardTimeLimits;
+(TimeLimit*) defaultTimeLimit;
+(TimeLimit*) timeLimitWithTitle:(NSString*)t;
@end
