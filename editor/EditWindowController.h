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
@class EditWindow;
@interface EditWindowController : NSViewController {
    IBOutlet NSTextField* textView;
    IBOutlet EditWindow* editWindow;
    BattleDocumentViewController* battleController;
}

@property (readwrite,retain) BattleDocumentViewController* battleController;
@property (readwrite,retain) IBOutlet EditWindow* editWindow;

-(IBAction) doneButtonPressed:(id) sender ;

@end
