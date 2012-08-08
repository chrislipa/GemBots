//
//  EditWindowController.h
//  GemBotEditor
//
//  Created by Christopher Lipa on 8/2/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BattleDocumentViewController.h"
#import "EditWindow.h"
#import "BotContainer.h"
@class EditWindow;
@interface EditWindowController : NSViewController {
    IBOutlet NSTextField* textView;
    IBOutlet NSTextFieldCell* textCell;
    IBOutlet EditWindow* editWindow;
    BattleDocumentViewController* battleController;
    BotContainer* botContainer;
}
@property (readwrite,retain) BotContainer* botContainer;
@property (readwrite,retain) BattleDocumentViewController* battleController;
@property (readwrite,retain) IBOutlet EditWindow* editWindow;

-(void) buildCallback;
-(void) buildAndRunCallback;

-(id) initWithBotContainer:(BotContainer*)bc andBattleDocumentContriller:(BattleDocumentViewController*) controller;
@end