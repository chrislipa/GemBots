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


@class RobotCellView;
@interface RobotCellViewController : NSViewController {
    BattleDocumentViewController* documentController;
    IBOutlet RobotCellView* cell;
    NSObject<RobotDescription>* robot;
}
@property (readwrite,retain) IBOutlet RobotCellView* cell;
@property (readonly) BattleDocumentViewController* documentController;
- (id)initWithNibName:(NSString *)nibNameOrNil andController:(BattleDocumentViewController*) p_controller;
-(IBAction) editButtonPressed:(id)sender;


@end
