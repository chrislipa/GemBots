//
//  DebuggerWindowController.h
//  Gem Bots
//
//  Created by Christopher Lipa on 8/11/12.
//
//

#import <Cocoa/Cocoa.h>
#import "DebuggerWindow.h"
#import "BattleDocumentViewController.h"
#import "BotContainer.h"
#import "DebuggerWindow.h"

@class DebuggerWindow;
@interface DebuggerWindowController : NSViewController {
    BattleDocumentViewController* battleController;
    BotContainer* botContainer;
    IBOutlet DebuggerWindow* debuggerWindow;
    IBOutlet NSTextView* registers;
    IBOutlet NSTextView* namedMemoryLocations;
}

@property (readwrite,retain) BotContainer* botContainer;
@property (readwrite,retain) BattleDocumentViewController* battleController;
@property (readwrite,retain) IBOutlet DebuggerWindow* debuggerWindow;


-(id) initWithBotContainer:(BotContainer*)bc andBattleDocumentContriller:(BattleDocumentViewController*) controller;
-(void) refreshUI;

@end
