//
//  RobotListTableView.h
//  bot
//
//  Created by Christopher Lipa on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BattleDocumentViewController.h"

@class BattleDocumentViewController;
@interface RobotListTableView : NSTableView {
    IBOutlet BattleDocumentViewController* controller;
}

@end
