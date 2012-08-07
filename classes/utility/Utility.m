//
//  Utility.m
//  bot
//
//  Created by Christopher Lipa on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Utility.h"

@implementation Utility
void setColorTo(NSColor* pcolor) {
    
    GLfloat colorf[3];
    NSColor* color = [pcolor colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
    colorf[0] = [color redComponent];
    colorf[1] = [color greenComponent];
    colorf[2] = [color blueComponent];
    
    glColor3f(colorf[0],colorf[1],colorf[2]);
}
NSString* formatInt(int x) {
    return [[[NSNumberFormatter alloc] init] stringFromNumber:[NSNumber numberWithInt:x]];
}
@end
