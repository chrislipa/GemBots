//
//  PGBotNativeEngine+Explosions.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/5/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine.h"

@interface PGBotNativeEngine (Explosions)
-(bool) dealWithExplosions;
-(bool) checkForAndDealWithSelfDestructingRobots;
@end
