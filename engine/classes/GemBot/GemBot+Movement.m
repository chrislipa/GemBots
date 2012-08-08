//
//  GemBot+Movement.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/1/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Movement.h"
#import "GemBot+Stats.h"
#import "EngineDefinitions.h"
#import "EngineUtility.h"
#import "GemBot+Stats.h"

@implementation GemBot (Movement)



-(int) speedInCM {
    return [self internalMaxSpeed] * speed_in_terms_of_throttle / MAX_THROTTLE * NUMBER_OF_CM_IN_M;
}



-(void) updateSpeedAndHeading {
    
}



@end
