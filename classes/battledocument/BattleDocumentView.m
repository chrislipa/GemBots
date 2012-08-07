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



-(void) awakeFromNib {
    [controller refreshView];
}
@end
