//
//  PGBotNativeEngine+Interface.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine.h"
#import "GemBot.h"
#import "Mine.h"
#import "Missile.h"
@interface PGBotNativeEngine (Interface)
-(int) numberOfRobotsAlive;


-(int) computeRadarFromBot:(GemBot*)bot;
-(int) computeWideRadarFromBot:(GemBot*)bot;
-(int) computeSonarFromBot:(GemBot*)bot;
-(void) transmit:(int)x onChannel:(int) comm_channel;

-(void) createExplosionAt:(NSObject<TangibleObject>*) a ofRadius:(unit)r andDamageMultiplier:(unit)multiplier andOwner:(GemBot*) owner;

-(void) removeMine:(Mine*) mine;
-(void) removeMissile:(Missile*) missile ;
-(void) fireMissileFrom:(position)internal_position inDirection:(int)heading withOwner:(GemBot*) bot ;
-(void) layMineAt: (position)internal_position withOwner:(GemBot*) bot andRadius:(unit) internal_radius;
-(int) howManyMinesHaveThisOwner:(GemBot*) owner ;
-(void) detonateAllMinesWithOwner:(GemBot*) owner ;
-(void) addSoundEffect:(NSString*)s ;

@end
