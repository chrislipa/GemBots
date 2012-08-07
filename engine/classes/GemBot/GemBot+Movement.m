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
@implementation GemBot (Movement)



-(int) speedInCM {
    return roundInternalDistanceToDistance(distanceToInternalDistance(speed_in_terms_of_throttle)*[self maxSpeedNumerator]/([self maxSpeedDenomenator]));
}



-(void) updateSpeedAndHeading {
    
}



@end
