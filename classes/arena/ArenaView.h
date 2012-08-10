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
#import "BattleDocumentViewController.h"
@class ArenaViewController;
@interface ArenaView : NSOpenGLView {
    IBOutlet BattleDocumentViewController* battleDocumentViewController;
    IBOutlet ArenaViewController* arenaViewController;
    NSObject<GameStateDescriptor>* gameStateDescriptor;
    double lastTimeABufferSwapWasPerformed;
}

@property (readwrite,retain)  NSObject<GameStateDescriptor>* gameStateDescriptor;
-(void) autolayout ;
@end
