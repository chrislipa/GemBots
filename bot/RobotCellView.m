//
//  RobotCellView.m
//  bot
//
//  Created by Christopher Lipa on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RobotCellView.h"

@implementation RobotCellView

-(void) refreshWithBot:(BotDescription*) b {
    [name setStringValue:[b name]];
    [author setStringValue:[b author]];
    [descript setString:[b descript]];
    [descript setEditable:NO];
    int linesOfCodeInt = [b linesOfCode];
    if (linesOfCodeInt < 0) {
        [linesOfCode setStringValue:@""];
    } else {
        NSString* s = [[[NSNumberFormatter alloc] init] stringFromNumber:[NSNumber numberWithInt:linesOfCodeInt]];
        s = [s stringByAppendingString:@" LOC"];
        [linesOfCode setStringValue:s];
    }
    int team = 0;

}



@end
