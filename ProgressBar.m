//
//  ProgressBar.m
//  Gem Bot
//
//  Created by Christopher Lipa on 8/5/12.
//
//

#import "ProgressBar.h"
#import "Utility.h"
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
    [super drawRect:dirtyRect];
    

    CGRect frame = self.frame;
    
    float width = frame.size.width * percentageComplete ;
    float height = frame.size.height;
    
    
    
    
    
    glLoadIdentity ();
    glOrtho (0, frame.size.width, frame.size.height, 0, 0, 1);
    glMatrixMode (GL_MODELVIEW);
    
    
    
    
    
    
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    setColorTo(controller.botContainer.color);  
    glBegin(GL_TRIANGLE_FAN);
    glVertex2f(0, 0);
    glVertex2f(0, height );
    glVertex2f(width,height);
    glVertex2f(width,0);
    glEnd();
    
    
    
    glFlush();
    
    
}


-(void) setPercentageComplete:(float) percent {
    percentageComplete = percent;
    
}

-(float) percentageComplete {
    return percentageComplete;
     
}

-(void) refreshForGameCycle {
    
}
@end
