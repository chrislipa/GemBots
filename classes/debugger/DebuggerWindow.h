//
//  DebuggerWindow.h
//  Gem Bots
//
//  Created by Christopher Lipa on 8/11/12.
//
//

#import <Cocoa/Cocoa.h>
#import "DebuggerWindowController.h"

@class DebuggerWindowController;

@interface DebuggerWindow : NSWindow {
    IBOutlet DebuggerWindowController* debuggerWindowController;
}

@property (readonly) DebuggerWindowController* debuggerWindowController;

@end
