//
//  ArenaView.h
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//

#import <Cocoa/Cocoa.h>
#import "ArenaViewController.h"
#import "GameStateDescriptor.h"
@class ArenaViewController;
@interface ArenaView : NSOpenGLView {
    IBOutlet ArenaViewController* arenaViewController;
    NSObject<GameStateDescriptor>* gameStateDescriptor;
}

@property (readwrite,retain)  NSObject<GameStateDescriptor>* gameStateDescriptor;

@end
