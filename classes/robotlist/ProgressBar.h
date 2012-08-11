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
    float r,g,b;
}


-(void) setPercentageComplete:(float) percent;
-(float) percentageComplete;
-(void) refreshForGameCycle ;
-(void) setColorR:(float) pr G:(float) pg B:(float) pb;
@end
