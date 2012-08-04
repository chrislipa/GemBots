//
//  RobotCellView.h
//  bot
//
//  Created by Christopher Lipa on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BotContainer.h"
#import "RobotCellViewController.h"
#import "BotContainer.h"
@class RobotCellViewController;
@interface RobotCellView : NSView {
    IBOutlet NSScrollView* descriptionScrollView;
    IBOutlet NSTextField* name;
    IBOutlet NSTextField* author;
    IBOutlet NSTextView* descript;
    IBOutlet NSPopUpButton* teamPicker;
    IBOutlet NSColorWell* colorPicker;
    IBOutlet NSTextField* linesOfCode;
    IBOutlet RobotCellViewController* robotCellViewController;
    IBOutlet NSView* backingView;
}

@property (readonly) NSColorWell* colorPicker;
-(void) refreshWithBot:(BotContainer*) b;
-(void) refreshColor;
-(void) refreshTeams ;


@end
