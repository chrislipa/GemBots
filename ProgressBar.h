//
//  ProgressBar.h
//  Gem Bot
//
//  Created by Christopher Lipa on 8/5/12.
//
//

#import <Cocoa/Cocoa.h>

@interface ProgressBar : NSView {
    float percentageComplete;
}


-(void) setPercentageComplete:(float) percent;
-(float) percentageComplete;
@end
