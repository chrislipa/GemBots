//
//  GemBot+Interface.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Interface.h"
#import "EngineDefinitions.h"
#import "EngineUtility.h"

@implementation GemBot (Interface)

-(int) speed {
    return roundInternalDistanceToDistance(internal_speed);
}

-(void) updatePosition {
    
}

-(void) dealInternalDamage:(lint) damage  {
    internal_armor -= damage;
}
@end
