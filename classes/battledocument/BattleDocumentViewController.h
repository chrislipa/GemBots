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
#import "BattleDocumentWindow.h"
#import "AudioController.h"
@class BotContainer;
@class RobotListTableView;
@class BattleDocument;
@class ArenaView;


typedef enum {
    nobattle,
    runningbattle,
    pausedbattle
} BattleState;

@interface BattleDocumentViewController : NSViewController <NSTableViewDataSource,NSTableViewDelegate,NSWindowDelegate> {
    IBOutlet BattleDocumentWindow* battleDocumentWindow;
    IBOutlet BattleDocument* battleDocument;
    IBOutlet RobotListTableView* robotList;
    
    IBOutlet NSButton* openButton;
    IBOutlet NSButton* newButton;
    
    
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

    IBOutlet NSTextField* matchesNumeratorView;
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
    
    bool battleOngoing;
    CFTimeInterval lastTimeABufferSwapWasPerformed;
    
    IBOutlet NSTextFieldCell* startError;
    IBOutlet NSTextField* startErrorField;
    
    AudioController* audio;
    
    IBOutlet NSTabView* battleControl;
    
    BattleState battleState;
    
    IBOutlet NSButton* stopButton;
    IBOutlet NSButton* stepButton;
    IBOutlet NSButton* playPauseButton;
    NSImage* playButtonImage;
    NSImage* pauseButtonImage;
}

@property (readwrite,assign) bool battleOngoing;
@property (readwrite,assign) bool soundEnabled;
@property (readwrite,assign) bool graphicsEnabled;
@property (readwrite,assign) bool scanEnabled;
@property (readonly) BattleDocumentWindow* battleDocumentWindow;
@property (readwrite,retain) ArenaView* arenaView;
@property (readwrite,retain)  WeightClass* weightClass;
@property (readwrite,retain)  RobotListTableView* robotList;
- (IBAction) addRobotButtonEvent:(id)sender;
- (IBAction) newRobotButtonEvent:(id)sender;
-(void) addDuplicateOfRobot:(BotContainer*) container;
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


-(IBAction) stopButtonCallback:(id)sender;
-(IBAction) stepButtonCallback:(id)sender;
-(IBAction) playPauseButtonCallback:(id)sender;
@end
