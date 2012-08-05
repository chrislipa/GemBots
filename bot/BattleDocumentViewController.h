//
//  BattleDocumentViewController.h
//  bot
//
//  Created by Christopher Lipa on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RobotListTableView.h"
#import "BattleDocument.h"
#import "GameStateDescriptor.h"
#import "PGBotEngineProtocol.h"
#import "BotContainer.h"
#import "WeightClass.h"
#import "TimeLimit.h"
@class BotContainer;
@class RobotListTableView;
@class BattleDocument;
@interface BattleDocumentViewController : NSViewController <NSTableViewDataSource,NSTableViewDelegate> {
    IBOutlet BattleDocument* battleDocument;
    IBOutlet RobotListTableView* robotList;
    
    
    
    NSMutableArray* robots;
    NSMutableDictionary* robotCellViewControllers;
    
    NSObject<PGBotEngineProtocol>* engine;
    NSMutableArray* editors;
    NSMutableArray* teamTitles;
    bool battleCurrentlyInProgress;
    WeightClass* weightClass;
    TimeLimit* timeLimit;
    int numberOfMatches;

    IBOutlet NSPopUpButton* weightClassPicker;
    IBOutlet NSTextField* numberOfMatchesField;
    IBOutlet NSPopUpButton* gameCycleTimeOutPicker;
    
    
}

@property (readwrite,retain)    WeightClass* weightClass;

- (IBAction) addRobotButtonEvent:(id)sender;


-(int) numberOfTeams;
-(NSArray*) teamTitles ;
-(int) emptyTeamForRobot:(NSObject<RobotDescription>*) bot;
-(void) addEditor:(id) editor;
-(void) reccompileRobot:(BotContainer*) bot;
-(NSColor*) unusedColorForNewRobot;
-(int) unusedTeamForRobot:(BotContainer*) bot;
-(void) removeRobot:(BotContainer*) bot;


-(IBAction)locPickerChanged:(id)sender;
-(IBAction)timeLimitPickerChaged:(id)sender;
-(IBAction)numberOfMatchesChanged:(id)sender;

@end
