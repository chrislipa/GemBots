//
//  GemBot+Movement.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/1/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot.h"

@interface GemBot (Movement)

-(lint) internal_speed;
-(int) speedInCM;
-(void) move;
-(void) updatePosition;
@end
