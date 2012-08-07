//
//  Scan.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "Scan.h"
#import "EngineUtility.h"

@implementation Scan
@synthesize x;
@synthesize y;
@synthesize radius;
@synthesize startAngle;
@synthesize endAngle;
@synthesize owner;

-(int) heading {
    return 0;
    int half_heading = (startAngle + endAngle) / 2;
    if (endAngle < startAngle) {
        half_heading += 256 / 2;
    }
    return half_heading;
}
@end
