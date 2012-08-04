//
//  RobotCellViewController.m
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//

#import "RobotCellViewController.h"
#import "GemBotEditor.h"
#import "MasterController.h"
@interface RobotCellViewController ()

@end

@implementation RobotCellViewController

@synthesize documentController;
@synthesize botContainer;



- (id)initWithNibName:(NSString *)nibNameOrNil andController:(BattleDocumentViewController*) p_controller  andRobot:(BotContainer*) bc
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        documentController = p_controller;
        botContainer = bc;
        [self view];
        [cell refreshWithBot:bc];
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
    [[MasterController singleton] spawnEditorWindowForBotContainer:botContainer forBattleDocumentController:documentController];
}

-(void) refresh {
    [cell refreshWithBot:botContainer];
}

-(IBAction) closeCallback:(id)sender {
    [documentController removeRobot:botContainer];
}
@end
