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

@class DebuggerWindow;
@interface DebuggerWindowController : NSWindowController {
    BattleDocumentViewController* battleController;
    BotContainer* botContainer;
    IBOutlet DebuggerWindow* debugerWindow;
}


@end
