//
//  RobotCellViewController.m
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//

#import "RobotCellViewController.h"

@interface RobotCellViewController ()

@end

@implementation RobotCellViewController

- (id)initWithNibName:(NSString *)nibNameOrNil andController:(BattleDocumentViewController*) p_controller
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        controller = p_controller;
    }
    
    return self;
}

@end
