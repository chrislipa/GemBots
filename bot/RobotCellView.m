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
    [viewLayer setBackgroundColor:CGColorCreateGenericRGB(color.redComponent, color.greenComponent, color.blueComponent, 0.1)]; //RGB plus Alpha Channel
    [self setWantsLayer:YES]; // view's backing store is using a Core Animation Layer
    [self setLayer:viewLayer];

}

-(void) refreshTeams {
    int team = robotCellViewController.botContainer.team;
    NSArray* teams = [robotCellViewController.documentController teamTitles];
    [teamPicker removeAllItems];
    [teamPicker addItemsWithTitles:teams];
    if (team > 0) {
        [teamPicker selectItemWithTitle:[NSString stringWithFormat:@"%d",team]];
    }
}


-(void) refreshWithBot:(BotContainer*) b {
    [name setStringValue:[b name]];
    [author setStringValue:[b author]];
    NSString* d = [b descript];
    [descript setString:d];
    [descript setEditable:NO];
    int linesOfCodeInt = [b linesOfCode];
    if (linesOfCodeInt < 0) {
        [linesOfCode setStringValue:@""];
    } else {
        NSString* s = [[[NSNumberFormatter alloc] init] stringFromNumber:[NSNumber numberWithInt:linesOfCodeInt]];
        s = [s stringByAppendingString:@" LOC"];
        [linesOfCode setStringValue:s];
    }
    if (b.robot.compileErrors.count > 0) {
        [compileErrorButton setHidden:NO];
        NSString* text;
        if (b.robot.numberOfCompileErrors > 0) {
            text = [NSString stringWithFormat:@"%d Compile Errors",b.robot.numberOfCompileErrors];
        } else if (b.robot.numberOfCompileWarnings) {
            text = [NSString stringWithFormat:@"%d Compile Warnings",b.robot.numberOfCompileWarnings];
        }
        [compileErrorButton setTitle:text];
    } else {
        [compileErrorButton setHidden:YES];
    }
    
    //int team = [robotCellViewController.documentController emptyTeamForRobot:b.robot];
    [colorPicker setColor:b.color];
    [self refreshColor];
    [colorPicker addObserver:self forKeyPath:@"color" options:0 context:NULL];
    if ([d length] ==0) {
        [descriptionScrollView setHidden:YES];
    } else {
        [descriptionScrollView setHidden:NO];
    }
    [self refreshTeams];
}




@end
