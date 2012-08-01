//
//  Random.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DETEMINISTIC 0
#define DETEMINISTIC_SEED 0

@interface Random : NSObject



-(int) random;
-(void) reset;

@end
