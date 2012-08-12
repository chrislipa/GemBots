//
//  Random.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "Random.h"



@implementation Random

-(int) randomInt {
    if (isDeterministic == 0) {
        int rv = (int)arc4random();
        return rv;
    }
    return 0;
}


-(int) randomIntInInclusiveRange:(int) lowerBound: (int) upperBound {
    int size = (upperBound + 1 -lowerBound);
    int modulo = [self randomInt] % size;
    if (modulo < 0) {
        modulo += size;
    }
    return lowerBound + modulo;
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
