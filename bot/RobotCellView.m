//
//  RobotCellView.m
//  bot
//
//  Created by Christopher Lipa on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <CoreGraphics/CoreGraphics.h>
#import <Quartz/Quartz.h>

#import "RobotCellView.h"

@implementation RobotCellView
@synthesize colorPicker;
-(id) init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == colorPicker) {
        [self refreshColor];
    }
}

-(void) refreshColor {
    NSColor* color = [colorPicker color];
    CALayer *viewLayer = [CALayer layer];
    [viewLayer setBackgroundColor:CGColorCreateGenericRGB(color.redComponent, color.greenComponent, color.blueComponent, 0.4)]; //RGB plus Alpha Channel
    [self setWantsLayer:YES]; // view's backing store is using a Core Animation Layer
    [self setLayer:viewLayer];

}


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
    //int team = [robotCellViewController.documentController emptyTeamForRobot:b.robot];
    [self refreshColor];
    [colorPicker addObserver:self forKeyPath:@"color" options:0 context:NULL];
}



@end
