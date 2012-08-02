//
//  RandomProtocol.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/2/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RandomProtocol <NSObject>
-(int) random;
-(void) setDeterministic:(bool) deterministic;
-(bool) deterministic;
-(void) setDeterministicSeed:(unsigned int) seed;
-(unsigned int) deterministicSeed;
@end
