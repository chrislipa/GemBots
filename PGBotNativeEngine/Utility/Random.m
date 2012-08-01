//
//  Random.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "Random.h"



@implementation Random

-(int) random {
    if (DETEMINISTIC == 0) {
        return arc4random();
    }
}

-(void) reset {
    seed = DETEMINISTIC_SEED;
}

-(id) init {
    if (self = [super init]) {
        [self reset];
    }
    return self;
}
@end
