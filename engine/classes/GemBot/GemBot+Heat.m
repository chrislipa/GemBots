//
//  GemBot+Heat.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/6/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Heat.h"
#import "GemBot+Stats.h"
@implementation GemBot (Heat)
-(void) heatPhase {
    internal_armor += [self damageFromHeatPerGameCycle];
    internal_heat -= [self heatReductionPerGameCycle];
}
@end
