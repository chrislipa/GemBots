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
    } else {
        return [self deterministicRandomInt];
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

-(id) init {
    if (self = [super init]) {
        seed = 1;
        isDeterministic = 1;
    }
    return self;
}

// http://closure-library.googlecode.com/svn/docs/closure_goog_testing_pseudorandom.js.source.html
//
// Copyright 2011 The Closure Library Authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS-IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/**
 * @fileoverview PseudoRandom provides a mechanism for generating deterministic
 * psuedo random numbers based on a seed. Based on the Park-Miller algorithm.
 * See http://dx.doi.org/10.1145%2F63039.63042 for details.
 *
 */


const int seedUniquifier_ = 0;

const int A = 48271;


const int M = 2147483647;

const int Q = 44488;

const int R = 3399;

const double ONE_OVER_M_MINUS_ONE = 1.0 / (M - 1);






-(void) setDeterministicSeed:(unsigned int) pseed {
    seed = pseed % (M - 1);
    if (seed<=0) {
        seed += M - 1;
    }
}

-(int) deterministicRandomInt {
    int hi = seed / Q;
    int lo = seed % Q;
    int test = A * lo - R * hi;
    if (test > 0) {
        seed = test;
    } else {
        seed = test + M;
    }
    return (seed-1);
}

@end
