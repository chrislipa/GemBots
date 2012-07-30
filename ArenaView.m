//
//  ArenaView.m
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//
#import <Cocoa/Cocoa.h>

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
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();

//    glTranslatef(0.0f,0.0f,-6);
//    glRotatef(20,0,0,1);
//    glRotatef(20,1,0,0);

    
    
    
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    glFlush();
    
    
}

@end
