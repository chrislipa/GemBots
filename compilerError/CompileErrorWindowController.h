//
//  CompileErrorWindowControllerViewController.h
//  bot
//
//  Created by Christopher Lipa on 8/4/12.
//
//

#import <Cocoa/Cocoa.h>
#import "BotContainer.h"
#import "CompileErrorWindow.h"
@class CompileErrorWindow;
@interface CompileErrorWindowController : NSViewController {
    BattleDocumentViewController* battleController;
    BotContainer* botContainer;
    IBOutlet CompileErrorWindow* errorWindow;
    IBOutlet NSTableView* tableView;
    IBOutlet NSScrollView* scrollView;
    NSMutableDictionary* cellControllers;
}
@property (readwrite,retain)  NSScrollView* scrollView;
@property (readwrite,retain) CompileErrorWindow* errorWindow;
@property (readwrite,retain) NSTableView* tableView;
@property (readwrite,retain) BotContainer* botContainer;
-(id) initWithBotContainer:(BotContainer*)bc andBattleDocumentContriller:(BattleDocumentViewController*) controller ;

-(IBAction)closeWindowCallback:(id)sender;
-(void) refresh;
@end
