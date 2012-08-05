//
//  Random.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RandomProtocol.h"


@interface Random : NSObject <RandomProtocol> {
    bool isDeterministic;
    int seed;
}



-(int) randomInt;
-(int) randomIntInInclusiveRange:(int) lowerBound: (int) upperBound;

-(void) setDeterministic:(bool) deterministic;
-(bool) deterministic;
-(void) setDeterministicSeed:(unsigned int) seed;
-(unsigned int) deterministicSeed;
@end
