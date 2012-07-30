//
//  ArenaView.h
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//

#import <Cocoa/Cocoa.h>
#import "ArenaViewController.h"

@class ArenaViewController;
@interface ArenaView : NSOpenGLView {
    IBOutlet ArenaViewController* arenaViewController;
}

@end
