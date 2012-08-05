//
//  EditWindow.h
//  bot
//
//  Created by Christopher Lipa on 8/2/12.
//
//

#import <Cocoa/Cocoa.h>
#import "EditWindowController.h"
@class EditWindowController;
@interface EditWindow : NSWindow {
    IBOutlet EditWindowController* controller;
}

-(IBAction) buildCallback:(id) sender ;
-(IBAction) buildAndRunCallback:(id) sender ;

@end
