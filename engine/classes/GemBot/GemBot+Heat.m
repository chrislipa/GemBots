//
//  GemBot+Heat.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/6/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Heat.h"
#import "GemBot+Stats.h"
#import "GemBot+Interface.h"

@implementation GemBot (Heat)
-(void) heatPhase {
    [self dealInternalDamage:[self damagePerGameCycle]];
    [self dealInternalHeat:[self deltaHeatPerGameCycle]];
}
@end
