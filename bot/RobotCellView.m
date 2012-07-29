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
    [name setStringValue:[[b urlToBot] absoluteString]];
}

@end
