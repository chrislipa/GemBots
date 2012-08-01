//
//  GemBot+Interface.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot.h"

@interface GemBot (Interface)

-(int) speed;

-(void) updatePosition;

-(void) dealInternalDamage:(lint) damage ;
@end
