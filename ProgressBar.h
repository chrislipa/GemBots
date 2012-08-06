//
//  ProgressBar.h
//  Gem Bot
//
//  Created by Christopher Lipa on 8/5/12.
//
//

#import <Cocoa/Cocoa.h>
#import "RobotCellViewController.h"
@class RobotCellViewController;
@interface ProgressBar : NSOpenGLView {
    IBOutlet RobotCellViewController* controller;
    float percentageComplete;
}


-(void) setPercentageComplete:(float) percent;
-(float) percentageComplete;
-(void) refreshForGameCycle ;
@end
