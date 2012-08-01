//
//  GemBot+Interface.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Interface.h"

@implementation GemBot (Interface)

-(int) speed {
    return (int)(internal_speed / (DISTANCE_MULTIPLIER / 100));
}
@end
