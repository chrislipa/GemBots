//
//  CompileErrorWindow.h
//  bot
//
//  Created by Christopher Lipa on 8/4/12.
//
//

#import <Cocoa/Cocoa.h>
#import "CompileErrorWindowController.h"
@class CompileErrorWindowController;
@interface CompileErrorWindow : NSPanel {
    IBOutlet CompileErrorWindowController* controller;
}

@property (readwrite,retain) CompileErrorWindowController* controller;
@end
