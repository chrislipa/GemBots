//
//  GemBot+Interface.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot.h"

@interface GemBot (Interface)




-(void) dealInternalDamage:(unit) damage ;

-(void) die;


-(void) setScanTargetData ;

-(void) updateThrottle;

-(void) notifyOfDetectionByOtherRobot;

-(void) dealInternalHeat:(unit) heat ;

-(void) loggingStatement:(int) x;
@end
