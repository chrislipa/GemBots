//
//  RobotCellViewController.h
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//

#import <Cocoa/Cocoa.h>
#import "BattleDocumentViewController.h"
#import "RobotCellView.h"
#import "GameStateDescriptor.h"
#import "BotContainer.h"
@class RobotCellView;
@interface RobotCellViewController : NSViewController {
    BattleDocumentViewController* documentController;
    IBOutlet RobotCellView* cell;
    BotContainer* botContainer;
}
@property (readwrite,retain) IBOutlet RobotCellView* cell;
@property (readonly) BattleDocumentViewController* documentController;
@property (readonly) BotContainer* botContainer;
- (id)initWithNibName:(NSString *)nibNameOrNil andController:(BattleDocumentViewController*) p_controller  andRobot:(BotContainer*) bc;
-(IBAction) editButtonPressed:(id)sender;
-(void) refresh ;

@end
