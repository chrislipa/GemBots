//
//  GemBot+Collision.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/5/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Collision.h"
#import "EngineUtility.h"
#import "GemBot+Interface.h"
@implementation GemBot (Collision)

-(void) hadCollision {
    if (speed_in_terms_of_throttle > SPEED_NECCESSARY_TO_DO_DAMAGE_ON_COLLISION ) {
        [self dealInternalDamage:armorToInternalArmor(DAMAGE_DONE_ON_COLLISION) :nil];
    }
    throttle = 0;
    speed_in_terms_of_throttle = 0;
    number_of_collisions++;
    lastCollisionTime = engine.gameCycle;
    internal_position.x = MIN(SIZE_OF_ARENA-ROBOT_RADIUS,MAX(ROBOT_RADIUS, internal_position.x ));
    internal_position.y = MIN(SIZE_OF_ARENA-ROBOT_RADIUS,MAX(ROBOT_RADIUS, internal_position.y ));

}

@end
