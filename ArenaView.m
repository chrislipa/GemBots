//
//  ArenaView.m
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//
#import <Cocoa/Cocoa.h>
#import "GameStateDescriptor.h"
#import "ArenaView.h"
#include <OpenGL/OpenGL.h>
#include <OpenGL/gl.h>
#import "GameStateDescriptor.h"



@implementation ArenaView
@synthesize gameStateDescriptor;

float convert_angle(int hexangle) {
    return (((float)hexangle)/256.0) * M_2_PI;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
void setColorTo(NSColor* pcolor) {
    
    GLfloat colorf[3];
    NSColor* color = [pcolor colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
    colorf[0] = [color redComponent];
    colorf[1] = [color blueComponent];
    colorf[2] = [color greenComponent];
    
    glColor3fv(colorf);
}

-(void) internalDrawRobot:(NSObject<RobotDescription>*) bot {
    setColorTo(bot.color);
    glBegin(GL_TRIANGLE_FAN);
    glVertex2f(0, 0);
    for (float angle = 0; angle < M_2_PI; angle += M_2_PI/16) {
        glVertex2f(((float)(5.0)) * sinf(angle),((float)(5.0))* cosf(angle));
    }
    glEnd();
}
-(void) internalDrawMine:(NSObject<MineDescription>*) mine {
    setColorTo(mine.owner.color);
    glBegin(GL_POINTS);
    glVertex3f(0,0,0);
    glEnd();
}

-(void) internalDrawMissile:(NSObject<MissileDescription>*) missile {
    setColorTo(missile.owner.color);
    glBegin(GL_TRIANGLE_FAN);
    glVertex2f(0, 0);
    for (float angle = 0; angle < M_2_PI; angle += M_2_PI/16) {
        glVertex2f(((float)(15.0)) * sinf(angle),((float)(15.0))* cosf(angle));
    }
    glEnd();
    /*
    setColorTo([NSColor whiteColor]);
    glBegin(GL_LINES);
    glVertex3f(0,0,0);
    glVertex3f(0,-5,0);
    glEnd();*/
}

-(void) internalDrawExplosion:(NSObject<ExplosionDescription>*) explosion {
    setColorTo([NSColor whiteColor]);
    glBegin(GL_TRIANGLE_FAN);
    glVertex2f(0, 0);
    for (float angle = 0; angle < M_2_PI; angle += M_2_PI/16.0) {
        glVertex2f(((float)(explosion.radius)) * sinf(angle),((float)(explosion.radius))* cosf(angle));
    }
    glEnd();
}

-(void) internalDrawScan:(NSObject<ScanDescription>*) scan {
    setColorTo([NSColor whiteColor]);
    float startAngle = convert_angle(scan.startAngle);
    float endAngle = convert_angle(scan.endAngle);
    glBegin(GL_LINES);
    glVertex2f(((float)(scan.radius)) * sinf(startAngle),((float)(scan.radius))* cosf(startAngle));
    glVertex2f(0,0);
    glVertex2f(((float)(scan.radius)) * sinf(endAngle),((float)(scan.radius))* cosf(endAngle));
    glEnd();
    
    float widthOfScanArc = endAngle - startAngle;
    if (widthOfScanArc < 0) {
        widthOfScanArc += M_2_PI;
    }
    glBegin(GL_LINES);
    for (float dangle = 0; dangle < widthOfScanArc; dangle += M_2_PI/32.0) {
        glVertex2f(((float)(scan.radius)) * sinf(dangle+startAngle),((float)(scan.radius))* cosf(dangle+startAngle));
    }
    glVertex2f(((float)(scan.radius)) * sinf(endAngle),((float)(scan.radius))* cosf(endAngle));
    glEnd();
}


void translateTo(int x, int y) {
    glTranslatef((float)x, (float)y, 0);
}


void rotateTo(int x, int y, int heading) {
    translateTo(x, y);
    float angle = convert_angle(heading);
    glRotatef(angle, 0.0, 0.0, 1.0);
}

-(void) drawRobot:(NSObject<RobotDescription>*) bot {
    glPushMatrix();
    rotateTo(bot.x, bot.y, bot.heading);
    [self internalDrawRobot:bot];
    glPopMatrix();
}
-(void) drawMine:(NSObject<MineDescription>*) mine {
    glPushMatrix();
    rotateTo(mine.x, mine.y, 0);
    [self internalDrawMine:mine];
    glPopMatrix();
}

-(void) drawMissile:(NSObject<MissileDescription>*) missile {
    glPushMatrix();
    rotateTo(missile.x, missile.y, missile.heading);
    [self internalDrawMissile:missile];
    glPopMatrix();
}

-(void) drawExplosion:(NSObject<ExplosionDescription>*) explosion {
    glPushMatrix();
    rotateTo(explosion.x, explosion.y, explosion.heading);
    [self internalDrawExplosion:explosion];
    glPopMatrix();
}


-(void) drawScan:(NSObject<ScanDescription>*) scan {
    glPushMatrix();
    translateTo(scan.x, scan.y);
    [self internalDrawScan:scan];
    glPopMatrix();
}



- (void)drawRect:(NSRect)dirtyRect
{
    const int width = 1024, height = 1024;
    glMatrixMode (GL_PROJECTION);
    glLoadIdentity ();
    glOrtho (0, width, height, 0, 0, 1);
    glMatrixMode (GL_MODELVIEW);
    
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    for (NSObject<MineDescription>* mine in gameStateDescriptor.mines) {
        [self drawMine:mine];
    }
    
    for (NSObject<RobotDescription>* bot in gameStateDescriptor.robots) {
        [self drawRobot:bot];
    }
    
    for (NSObject<MissileDescription>* miss in gameStateDescriptor.missiles) {
        [self drawMissile:miss];
    }
    for (NSObject<ScanDescription>*scan in gameStateDescriptor.scans) {
        [self drawScan:scan];
    }
    
    for (NSObject<ExplosionDescription>* exp in gameStateDescriptor.explosions) {
        [self drawExplosion:exp];
    }
    
    
    
    glFlush();
    
    
}

@end
