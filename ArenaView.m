//
//  ArenaView.m
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//

#import "ArenaView.h"
#include <OpenGL/OpenGL.h>
#include <OpenGL/gl.h>



@implementation ArenaView

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
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    glFlush();
}

@end
