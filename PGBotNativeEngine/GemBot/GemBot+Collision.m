//
//  GemBot+Collision.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/5/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Collision.h"
#import "EngineUtility.h"

@implementation GemBot (Collision)

-(void) hadCollision {
    if (speed_in_terms_of_throttle > SPEED_NECCESSARY_TO_DO_DAMAGE_ON_COLLISION ) {
        internal_armor -= armorToInternalArmor(DAMAGE_DONE_ON_COLLISION);
    }
    throttle = 0;
    speed_in_terms_of_throttle = 0;
    number_of_collisions++;
    lastCollisionTime = engine.gameCycle;
}

@end
