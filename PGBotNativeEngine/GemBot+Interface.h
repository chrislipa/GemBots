//
//  GemBot+Interface.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot.h"

@interface GemBot (Interface)




-(void) dealInternalDamage:(lint) damage ;

-(void) die;

-(void) hadCollision;
-(void) setScanTargetData ;
@end
