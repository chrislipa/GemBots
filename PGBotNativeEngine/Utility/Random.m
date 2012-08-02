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
    if (isDeterministic == 0) {
        return arc4random();
    }
    return 0;
}

-(void) setDeterministic:(bool)deterministic {
    isDeterministic = deterministic;
}
-(bool) deterministic {
    return isDeterministic;
}

-(unsigned int) deterministicSeed {
    return seed;
}
-(void) setDeterministicSeed:(unsigned int)p_seed {
    seed = p_seed;
}

-(id) init {
    if (self = [super init]) {
       
    }
    return self;
}
@end
