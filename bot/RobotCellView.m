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
        NSColor* color = [colorPicker color];
        [robotCellViewController.botContainer setColor:color];
        [self refreshColor];
    }
}

-(void) refreshColor {
    NSColor* color = robotCellViewController.botContainer.color;
    CALayer *viewLayer = [CALayer layer];
    [viewLayer setBackgroundColor:CGColorCreateGenericRGB(color.redComponent, color.greenComponent, color.blueComponent, 0.1)]; //RGB plus Alpha Channel
    [view1 setWantsLayer:YES]; // view's backing store is using a Core Animation Layer
    [view1 setLayer:viewLayer];

    [view2 setWantsLayer:YES]; // view's backing store is using a Core Animation Layer
    [view2 setLayer:viewLayer];
    

}


-(void) refreshHeatAndArmor  {
    float heat = ((float)robotCellViewController.botContainer.robot.heat)/ 500.0;
    float armor = ((float)robotCellViewController.botContainer.robot.heat)/ 100.0;
    [heatProgressBar2 setPercentageComplete:heat];
    [armorProgressBar2 setPercentageComplete:armor];
}


-(void) refreshTeams {
    int team = robotCellViewController.botContainer.team;
    NSArray* teams = [robotCellViewController.documentController teamTitles];
    [teamPicker removeAllItems];
    [teamPicker addItemsWithTitles:teams];
    if (team > 0) {
        [teamPicker selectItemWithTitle:[NSString stringWithFormat:@"%d",team]];
    }
    [teamLabel2 setStringValue:[NSString stringWithFormat:@"Team %d", team]];
    [self refreshHeatAndArmor];
}


-(void) refreshWithBot:(BotContainer*) b {
    [name setStringValue:[b name]];
    [name2 setStringValue:[b name]];
    [author setStringValue:[b author]];
    [author2 setStringValue:[b author]];
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
            text = [NSString stringWithFormat:@"%d Compile Error",b.robot.numberOfCompileErrors];
            if (b.robot.numberOfCompileErrors > 1) {
                text = [text stringByAppendingString:@"s"];
            }
        } else if (b.robot.numberOfCompileWarnings) {
            text = [NSString stringWithFormat:@"%d Warning",b.robot.numberOfCompileWarnings];
            if (b.robot.numberOfCompileWarnings > 1) {
                text = [text stringByAppendingString:@"s"];
            }
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

-(IBAction) chooseTeamCallback:(id) sender {
    robotCellViewController.botContainer.team = [[teamPicker titleOfSelectedItem] intValue];
    [robotCellViewController.documentController notifyOfTeamsChange];
}

-(void) notifyOfBattleStarting {
    //[view1 setHidden:NO];
    //[view2 setHidden:YES];
    
    [tabview selectTabViewItemAtIndex:1];
}

-(void) notifyOfBattleEnding {
    //[view2 setHidden:YES];
    //[view2 setHidden:NO];
    
    [tabview selectTabViewItemAtIndex:0];
}



@end
