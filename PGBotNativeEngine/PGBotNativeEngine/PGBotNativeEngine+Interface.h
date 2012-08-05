//
//  PGBotNativeEngine+Interface.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine.h"
#import "GemBot.h"
@interface PGBotNativeEngine (Interface)
-(int) numberOfRobotsAlive;


-(int) computeRadarFromBot:(GemBot*)bot;
-(int) computeWideRadarFromBot:(GemBot*)bot;
-(int) computeSonarFromBot:(GemBot*)bot;
-(void) transmit:(int)x onChannel:(int) comm_channel;

-(void) createExplosionAt:(NSObject<TangibleObject>*) a ofRadius:(lint)r;

@end
