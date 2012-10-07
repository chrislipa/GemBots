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

-(void) autolayout {
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:1.0f constant:0.0f]];
}

-(void) awakeFromNib {
    [(ArenaView*)self autolayout];
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
    double ROBOT_RADIUS = battleDocumentViewController.engine.rules.robotRadius;
    //double botscale_scale =  ROBOT_RADIUS/2.0;
    double turret = ROBOT_RADIUS * 0.4;
    //double turretscale_scale = 1;
    
    NSColor* c = bot.color;
    float r = c.redComponent;
    float g = c.greenComponent;
    float b = c.blueComponent;

    NSColor* bgcolor = [NSColor colorWithDeviceRed:r/3.0 green:g/3.0 blue:b/3.0 alpha:1.0];
    setColorTo(bgcolor);
    glBegin(GL_TRIANGLE_FAN);
    double delta =  M_2_PI/8;
    
    glVertex2f(0, 0);
    for (float dangle = 0; dangle < 2*M_PI+delta; dangle += delta) {
        glVertex2f(((float)(ROBOT_RADIUS)) * sin(dangle+0),((float)(ROBOT_RADIUS))* cos(dangle+0));
    }
    
    glEnd();
    
    
    
    
    setColorTo(bot.color);
    glBegin(GL_TRIANGLE_FAN);
    glVertex2f(sin(0)*ROBOT_RADIUS, cos(0)*ROBOT_RADIUS);
    glVertex2f(sin(3.0/4.0*M_PI)* ROBOT_RADIUS, cos(3.0/4.0*M_PI)*ROBOT_RADIUS);
    glVertex2f(sin(5.0/4.0*M_PI)* ROBOT_RADIUS, cos(5.0/4.0*M_PI)*ROBOT_RADIUS);
    glEnd();
    
    glPushMatrix() ;
    double angle =  (bot.turretHeading - bot.heading) / 256.0 * 360.0;
    glRotatef(angle , 0, 0, 1);
    
    
    setColorTo([NSColor whiteColor]);
    glBegin(GL_TRIANGLE_FAN);
    glVertex2f(sin(0)*turret, cos(0)*turret);
    glVertex2f(sin(3.0/4.0*M_PI)* turret, cos(3.0/4.0*M_PI)*turret);
    glVertex2f(sin(5.0/4.0*M_PI)* turret, cos(5.0/4.0*M_PI)*turret);
    glEnd();
    
    if (bot.shieldOn) {
        setColorTo([NSColor whiteColor]);
        glBegin(GL_LINE_STRIP);
        
        
        
        
        double delta =  M_2_PI/8;
        
        
        for (float dangle = 0; dangle < 2*M_PI+delta; dangle += delta) {
            glVertex2f(((float)(ROBOT_RADIUS)) * sin(dangle+0),((float)(ROBOT_RADIUS))* cos(dangle+0));
        }
        
        glEnd();
        
    }
    glPopMatrix();
    
    
    
    
}
-(void) internalDrawMine:(NSObject<MineDescription>*) mine {
    setColorTo(mine.owner.color);
    glBegin(GL_POINTS);
    glVertex3f(0,0,0);
    glEnd();
}

-(void) internalDrawMissile:(NSObject<MissileDescription>*) missile {
    //double ROBOT_RADIUS = battleDocumentViewController.engine.rules.robotRadius;
    double scale = 1;
    setColorTo(missile.owner.color);
    glBegin(GL_TRIANGLE_FAN);
    float width = 0.6 * scale;
    float height = [missile internal_speed]/1.0 * scale ;
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
    double r = 14.0;
    double delta =  M_2_PI/8;
    for (double angle = 0; angle < M_PI*2+delta; angle +=delta) {
        double x = ((double)(r)) * sin(angle);
        double y = ((double)(r)) * cos(angle);
        glVertex2f((float)x,(float)y );
    }
    glEnd();
}

-(void) internalDrawScan:(NSObject<ScanDescription>*) scan {;

    float g = 0.3;
    setColorTo([NSColor colorWithDeviceRed:g green:g blue:g alpha:g] );

    double startAngle = (-scan.startAngle+128) / 256.0 * 2 * M_PI;
    double endAngle = (-scan.endAngle+128) / 256.0 * 2 * M_PI;

    float widthOfScanArc = endAngle - startAngle;
    if (widthOfScanArc < 0 || scan.isWholeCircle) {
        widthOfScanArc += 2*M_PI;
    }
    float delta = M_2_PI/32.0;
    
    glBegin(GL_LINE_STRIP);
    
    glVertex2f(0,0);
    
    

    for (float dangle = 0; dangle < widthOfScanArc-delta; dangle += delta) {
        glVertex2f(((float)(scan.radius)) * sin(dangle+startAngle),((float)(scan.radius))* cos(dangle+startAngle));
    }
    glVertex2f(((float)(scan.radius)) * sin(endAngle),((float)(scan.radius))* cos(endAngle));
    glVertex2f(0,0);
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

- (void) reshape
{
    [[self openGLContext] update];

    
}

- (void)drawRect:(NSRect)dirtyRect
{
    
    
    const float width = 1024, height = 1024;
    
    glLoadIdentity ();
    
    glOrtho (0, width   , height, 0, 0, 1);
    glMatrixMode (GL_MODELVIEW);
    
    NSRect rect = [self bounds];
    rect.size = [self convertSize:rect.size toView:nil];
    glViewport(0.0, 0.0, NSWidth(rect), NSHeight(rect));

    
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
    if (battleDocumentViewController.scanEnabled) {
        for (NSObject<ScanDescription>*scan in gameStateDescriptor.scans) {
            [self drawScan:scan];
        }
    }
    
    for (NSObject<ExplosionDescription>* exp in gameStateDescriptor.explosions) {
        [self drawExplosion:exp];
    }
    
    
    
    //glFlush();
    
    
    glSwapAPPLE();
    
    
}

@end
