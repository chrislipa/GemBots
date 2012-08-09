//
//  BattleDocumentView.m
//  bot
//
//  Created by Christopher Lipa on 8/4/12.
//
//

#import "BattleDocumentView.h"
#import "BattleDocumentViewController+UserInterface.h"

@implementation BattleDocumentView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

-(void) autolayout {
    ArenaView* arenaView = controller.arenaView;
    RobotListTableView* robotList = controller.robotList;
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:robotList
                         attribute:NSLayoutAttributeLeft
                         relatedBy:NSLayoutRelationEqual
                         toItem:arenaView
                         attribute:NSLayoutAttributeRight
                         multiplier:1.0f constant:10.0f]];
    /*[robotList addConstraint:[NSLayoutConstraint
                         constraintWithItem:robotList
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:nil
                         attribute:0
                         multiplier:0.0f constant:246.0f]];*/
}



-(void) awakeFromNib {
    [controller refreshView];
    [self autolayout];
}
@end
