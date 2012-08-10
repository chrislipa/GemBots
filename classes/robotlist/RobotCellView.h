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
#import "ProgressBar.h"

@class RobotCellViewController;
@class ProgressBar;
@interface RobotCellView : NSView {
    bool showingBattleView;
    //
    
    IBOutlet NSTabView* tabview;
    IBOutlet NSView* view1;
    IBOutlet NSView* view2;
    //
    
    IBOutlet NSScrollView* descriptionScrollView;
    IBOutlet NSTextField* name;
    IBOutlet NSTextField* author;
    IBOutlet NSTextView* descript;
    IBOutlet NSPopUpButton* teamPicker;
    IBOutlet NSColorWell* colorPicker;
    IBOutlet NSTextField* linesOfCode;
    IBOutlet RobotCellViewController* robotCellViewController;
    IBOutlet NSView* backingView;
    IBOutlet NSView* backingView2;
    IBOutlet NSButton* compileErrorButton;
    
    IBOutlet NSTextField* loggingLine;
    
    //
    
    
    IBOutlet ProgressBar* armorProgressBar2;
    IBOutlet ProgressBar* heatProgressBar2;
    IBOutlet NSTextField* name2;
    IBOutlet NSTextField* author2;
    IBOutlet NSTextField* teamLabel2;
    
    IBOutlet NSTextField* winsTextField;
    IBOutlet NSTextField* lossesTextField;
    int wins, losses;
    NSString* executionLogString;
    float heat, armor;
    
    IBOutlet NSTextField* winslosses;
}

@property (readonly) NSColorWell* colorPicker;
-(void) refreshWithBot:(BotContainer*) b;
-(void) refreshColor;
-(void) refreshTeams ;

-(IBAction) chooseTeamCallback:(id) sender;


-(void) notifyOfBattleStarting;
-(void) notifyOfBattleEnding;
-(void) refreshForGameCycle;
-(void) refreshForMatch;
-(IBAction)duplicateButtonCallback:(id)sender;

-(void) enableUIButtons;
-(void) disableUIButtons;
@end
