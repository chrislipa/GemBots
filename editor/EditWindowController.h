//
//  EditWindowController.h
//  GemBotEditor
//
//  Created by Christopher Lipa on 8/2/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BattleDocumentViewController.h"
@interface EditWindowController : NSViewController {
    IBOutlet NSTextView* textView;
    BattleDocumentViewController* battleController;
}

@property (readwrite,retain) BattleDocumentViewController* battleController;


-(IBAction) doneButtonPressed:(id) sender ;

@end
