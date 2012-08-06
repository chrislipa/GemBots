//
//  ProgressBar.m
//  Gem Bot
//
//  Created by Christopher Lipa on 8/5/12.
//
//

#import "ProgressBar.h"

@implementation ProgressBar

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


-(void) setPercentageComplete:(float) percent {
    percentageComplete = percent;
}

-(float) percentageComplete {
    return percentageComplete;
}
@end
