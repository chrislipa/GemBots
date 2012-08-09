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

#import "Utility.h"

@implementation ArenaView
@synthesize gameStateDescriptor;

double convert_angle_to_degrees(int hexangle) {
    return (((float)(128.0+hexangle))/256.0) * 360.0;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


-(void) internalDrawRobot:(NSObject<RobotDescription>*) bot {
    double botscale_scale =  3;
    double turretscale_scale = 3;
    setColorTo(bot.color);
    glBegin(GL_TRIANGLE_FAN);
    glVertex2f(0*botscale_scale, 14*botscale_scale);
    glVertex2f(6*botscale_scale, -10*botscale_scale);
    glVertex2f(-6*botscale_scale, -10*botscale_scale);
    glEnd();
    
    glPushMatrix() ;
    double angle =  (bot.turretHeading - bot.heading) / 256.0 * 360.0;
    glRotatef(angle , 0, 0, 1);
    
    setColorTo([NSColor whiteColor]);
    glBegin(GL_TRIANGLE_FAN);
    glVertex2f(0*turretscale_scale, 6*turretscale_scale);
    glVertex2f(3*turretscale_scale, -3*turretscale_scale);
    glVertex2f(-3*turretscale_scale, -3*turretscale_scale);
    glEnd();
    
    glPopMatrix();
    
    
    
    
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
    float width = 1.5;
    float height = 16.0;
    glVertex2f(width, height);
    glVertex2f(width, -height);
    glVertex2f(-width, -height);
    glVertex2f(-width, height);
    
//    double r = 2.0;
//    for (double angle = 0; angle < M_PI*2; angle += M_2_PI/16) {
//        double x = ((double)(r)) * sin(angle);
//        double y = ((double)(r)) * cos(angle);
//        glVertex2f((float)x,(float)y );
//    }
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
    double r = 30.0;
    for (double angle = 0; angle < M_PI*2; angle += M_2_PI/16) {
        double x = ((double)(r)) * sin(angle);
        double y = ((double)(r)) * cos(angle);
        glVertex2f((float)x,(float)y );
    }
    glEnd();
}

-(void) internalDrawScan:(NSObject<ScanDescription>*) scan {
    setColorTo([NSColor whiteColor]);

    double startAngle = (-scan.startAngle+128) / 256.0 * 2 * M_PI;
    double endAngle = (-scan.endAngle+128) / 256.0 * 2 * M_PI;

    glBegin(GL_LINES);
    glVertex2f(((float)(scan.radius)) * sin(startAngle),((float)(scan.radius))* cos(startAngle));
    glVertex2f(0,0);
    glEnd();
    glBegin(GL_LINES);
    glVertex2f(((float)(scan.radius)) * sin(endAngle),((float)(scan.radius))* cos(endAngle));
    glVertex2f(0,0);
    glEnd();
    
    float widthOfScanArc = endAngle - startAngle;
    if (widthOfScanArc < 0) {
        widthOfScanArc += M_2_PI;
    }
    glBegin(GL_LINES);
    for (float dangle = 0; dangle < widthOfScanArc; dangle += M_2_PI/32.0) {
        glVertex2f(((float)(scan.radius)) * sin(dangle+startAngle),((float)(scan.radius))* cos(dangle+startAngle));
    }
    glVertex2f(((float)(scan.radius)) * sin(endAngle),((float)(scan.radius))* cos(endAngle));
    glEnd();
}


void translateTo(int x, int y) {
    glTranslatef((float)x, (float)y, 0);
}


void rotateTo(int x, int y, int heading) {
    translateTo(x, y);
    float angle = convert_angle_to_degrees(heading);
    
    
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
    
    glLoadIdentity ();
    glOrtho (0, width, height, 0, 0, 1);
    glMatrixMode (GL_MODELVIEW);
    
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    for (NSObject<MineDescription>* mine in gameStateDescriptor.mines) {
        [self drawMine:mine];
    }
    
    for (NSObject<RobotDescription>* bot in gameStateDescriptor.robots) {
        if (bot.isAlive) {
            [self drawRobot:bot];
        }
        
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
