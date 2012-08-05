//
//  RandomProtocol.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/2/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RandomProtocol <NSObject>
-(int) randomInt;
-(int) randomIntInInclusiveRange:(int) lowerBound: (int) upperBound;
-(void) setDeterministic:(bool) deterministic;
-(bool) deterministic;
-(void) setDeterministicSeed:(unsigned int) seed;
-(unsigned int) deterministicSeed;
@end
