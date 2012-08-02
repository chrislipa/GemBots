//
//  RobotCellViewController.h
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//

#import <Cocoa/Cocoa.h>
#import "BattleDocumentViewController.h"

@interface RobotCellViewController : NSViewController {
    BattleDocumentViewController* documentController;
}

@property (readonly) BattleDocumentViewController* documentController;
- (id)initWithNibName:(NSString *)nibNameOrNil andController:(BattleDocumentViewController*) p_controller;

@end
