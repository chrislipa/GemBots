//
//  Scan.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameStateDescriptor.h"
#import "GemBot.h"
@class GemBot;
@interface Scan : NSObject <ScanDescription> {
    int x, y;
    int radius;
    int startAngle, endAngle;
    GemBot* owner;
}
@property (readwrite,retain) GemBot* owner;
@property (readwrite,assign) int x;
@property (readwrite,assign) int y;
@property (readwrite,assign) int radius;
@property (readwrite,assign) int startAngle;
@property (readwrite,assign) int endAngle;

@end
