//
//  RobotCellViewController.m
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//

#import "RobotCellViewController.h"
#import "GemBotEditor.h"
@interface RobotCellViewController ()

@end

@implementation RobotCellViewController

@synthesize documentController;




- (id)initWithNibName:(NSString *)nibNameOrNil andController:(BattleDocumentViewController*) p_controller
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        documentController = p_controller;
        
    }
    
    return self;
}
-(RobotCellView*) cell {
    return cell;
}
-(void) setCell:(RobotCellView *)p_cell {
   cell = p_cell;
}


-(IBAction) editButtonPressed:(id)sender {
    [GemBotEditor spawnEditorWindowForURL:robot.url forBattleDocumentController:documentController];
}


@end
