//
//  BattleDocumentViewController.h
//  bot
//
//  Created by Christopher Lipa on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RobotListTableView.h"
#import "BattleDocument.h"

@interface BattleDocumentViewController : NSViewController <NSTableViewDataSource,NSTableViewDelegate> {
    IBOutlet BattleDocument* battleDocument;
    IBOutlet RobotListTableView* robotList;
    NSMutableArray* robots;
    
}

- (IBAction) addRobotButtonEvent:(id)sender;

@end
