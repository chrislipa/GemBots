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
#import "ArenaView.h"

@class BotContainer;
@class RobotListTableView;
@class BattleDocument;
@class ArenaView;

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
    
    IBOutlet NSTextFieldCell* teamTextCell;

    NSTimer* gameTimer;
    NSObject<GameStateDescriptor>* currentGameStateDescription;
    IBOutlet NSButtonCell* startStopButtonCell;
    
    IBOutlet NSTextFieldCell* matchesNumeratorCell;
    IBOutlet NSTextFieldCell* matchesDenominatorCell;
    IBOutlet NSTextFieldCell* gameCycleNumeratorCell;
    IBOutlet NSTextFieldCell* gameCycleDenominatorCell;
    IBOutlet NSTextFieldCell* gameCycleTextCell;
    IBOutlet NSTextFieldCell* matchesTextCell;
    IBOutlet NSTextFieldCell* gameCycleSlashCell;
    IBOutlet NSTextFieldCell* matchesSlashCell;
    IBOutlet ArenaView* arenaView;
    IBOutlet NSSlider* gamespeedSlider;
    
    float delayBetweenGameCycles;
    bool flagToCreateNewTimer;
    int gameCycleShown;
    int matchShown;
    
    
    bool soundEnabled;
    bool graphicsEnabled;
    bool scanEnabled;
    
    IBOutlet NSButton* soundButton;
    IBOutlet NSButton* graphicsButton;
    IBOutlet NSButton* scanButton;
}

@property (readwrite,assign) bool soundEnabled;
@property (readwrite,assign) bool graphicsEnabled;
@property (readwrite,assign) bool scanEnabled;

@property (readwrite,retain) ArenaView* arenaView;
@property (readwrite,retain)  WeightClass* weightClass;
@property (readwrite,retain)  RobotListTableView* robotList;
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
-(void) notifyOfRecompile:(NSURL*) url;
-(void) notifyOfTeamsChange;
-(void) computeGameSpeedBasedOnSlider;
-(IBAction) gamespeedSliderCallback:(id)sender;


-(IBAction)soundEnabledCallback:(id)sender ;
-(IBAction)graphicsEnabledCallback:(id)sender ;
-(IBAction)scanEnabledCallback:(id)sender ;

@end
