//
//  PGBotNativeEngine+CollisionDetection.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/5/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine+CollisionDetection.h"
#import "EngineUtility.h"
#import "Wall.h"
#import "MoveableObject.h"

@implementation PGBotNativeEngine (CollisionDetection)

typedef enum {
    IS_X,
    IS_Y
} coordinate;


unit timeToHitWall(NSObject<CollideableObject>* a, coordinate coord, unit wallPosition) {
    unit speed_in_coordinate;
    unit position_in_coordinate;
    if (coord == IS_X) {
        speed_in_coordinate = internal_velocity(a).x;
        position_in_coordinate = a.internal_position.x;
    } else {
        speed_in_coordinate = internal_velocity(a).y;
        position_in_coordinate = a.internal_position.y;
    }
    unit distance_to_go = wallPosition - position_in_coordinate;
    if ((speed_in_coordinate <= 0 && distance_to_go >= 0) ||
        (speed_in_coordinate >= 0 && distance_to_go <= 0)) {
        return MAX_UNIT;
    }
    unit timeToCollision = distance_to_go / speed_in_coordinate;
    return timeToCollision;
}


void computeWallCollision(NSObject<CollideableObject>* a, unit* maximumCollisionTimeFound, NSObject<CollideableObject>** objectInCollisionA,  NSObject<CollideableObject>** objectInCollisionB) {
    
    unit min_time_to_hit_wall = MAX_UNIT;
    
    min_time_to_hit_wall = MIN(min_time_to_hit_wall, timeToHitWall(a, IS_X, distanceToInternalDistance(0) + a.internal_radius));
    min_time_to_hit_wall = MIN(min_time_to_hit_wall, timeToHitWall(a, IS_Y, distanceToInternalDistance(0) + a.internal_radius));
    min_time_to_hit_wall = MIN(min_time_to_hit_wall, timeToHitWall(a, IS_X, distanceToInternalDistance(SIZE_OF_ARENA) - a.internal_radius));
    min_time_to_hit_wall = MIN(min_time_to_hit_wall, timeToHitWall(a, IS_Y, distanceToInternalDistance(SIZE_OF_ARENA) - a.internal_radius));
    
    if (min_time_to_hit_wall < *maximumCollisionTimeFound) {
        *maximumCollisionTimeFound = min_time_to_hit_wall;
        *objectInCollisionA = a;
        (*objectInCollisionB) =  [Wall newWall];
    }
}


bool quickNearnessCheck(unit b1x, unit b1y, unit b1vx, unit b1vy, unit b1r,
                        unit b2x, unit b2y, unit b2vx, unit b2vy, unit b2r) {
    unit linfnorm = MAX(ABS(b1x-b2x),ABS(b1y-b2y));
    
    return linfnorm < b1r + b2r;
    
    
}

// Circle collision detection code taken from:
// http://compsci.ca/v3/viewtopic.php?t=14897
// See LICENSE.md file for details.


bool areMovingTowardsEachOther(unit b1x, unit b1y, unit b1vx, unit b1vy,
                               unit b2x, unit b2y, unit b2vx, unit b2vy) {

    //result (b2.x - b1.x) * (b1.vx - b2.vx) + (b2.y - b1.y) * (b1.vy - b2.vy) > 0
    return   (b2x  - b1x ) * (b1vx  - b2vx ) + (b2y  - b1y ) * (b1vy  - b2vy ) > 0;
}

void computeCircleCollision(NSObject<CollideableObject>* i, NSObject<CollideableObject>* j, unit* maximumCollisionTimeFound, NSObject<CollideableObject>*  * objectInCollisionA, NSObject<CollideableObject>*  * objectInCollisionB) {
    
    position iv = internal_velocity(i);
    unit ivx = iv.x;
    unit ivy = iv.y;
    position jv = internal_velocity(j);
    unit jvx = jv.x;
    unit jvy = jv.y;
    unit ix = i.internal_position.x;
    unit iy = i.internal_position.y;
    unit jx = j.internal_position.x;
    unit jy = j.internal_position.y;
    unit ir = i.internal_radius;
    unit jr = j.internal_radius;
    
    if (!quickNearnessCheck(ix,iy,ivx,ivy,ir,jx,jy,jvx,jvy,jr)) {
        return;
    }
    
    if (!areMovingTowardsEachOther(ix,iy,ivx,ivy,jx,jy,jvx,jvy)) {
        return;
    }
    
    /* Breaking down the formula for t */
    //A := balls (i).vx ** 2 + balls (i).vy ** 2 - 2 * balls (i).vx * balls (j).vx + balls (j).vx ** 2 - 2 * balls (i).vy * balls (j).vy + balls (j).vy ** 2
    unit a =     sq(ivx)     +      sq(ivy)      - 2 *         ivx  *       jvx    +        sq(jvx)    - 2 *       ivy   *  jvy         +       sq(jvy);
    
    
    //B := -balls (i).x * balls (i).vx - balls (i).y * balls (i).vy + balls (i).vx * balls (j).x + balls (i).vy * balls (j).y + balls (i).x * balls (j).vx -
    unit b = -ix      *        ivx   -        iy   *        ivy   +        ivx   *        jx   +        ivy   *        jy   +        ix   *         jvx  -
    
    //balls (j).x * balls (j).vx + balls (i).y * balls (j).vy - balls (j).y * balls (j).vy
               jx  *        jvx   +         iy  *        jvy   -       jy    *        jvy;
    
//    C := balls (i).vx ** 2 + balls (i).vy ** 2 - 2 * balls (i).vx * balls (j).vx + balls (j).vx ** 2 - 2 * balls (i).vy * balls (j).vy + balls (j).vy ** 2
    unit c  =      sq(ivx)   +         sq(ivy)   - 2 *        ivx   *        jvx   +        sq(jvx)    - 2 *        ivy   *        jvy   +        sq(jvy);
//    D := balls (i).x ** 2 + balls (i).y ** 2 - balls (i).r ** 2 - 2 * balls (i).x * balls (j).x + balls (j).x ** 2 - 2 * balls (i).y * balls (j).y +
    unit d =      sq(ix)    +      sq(iy)      -     sq(ir)       - 2 *        ix   *        jx   +     sq(jx)       - 2 *        iy   *        jy   +
//    balls (j).y ** 2 - 2 * balls (i).r * balls (j).r - balls (j).r ** 2
          sq(jy)       - 2 *        ir   *        jr   -     sq(jr);
//      DISC :=  (-2 * B) ** 2 - 4 * C * D
    unit disc =sq(-2 * b)      - 4 * c * d;
//
    
    
    /* If the discriminent if non negative, a collision will occur and *
     * we must compare the time to our current time of collision. We   *
     * udate the time if we find a collision that has occurd earlier   *
     * than the previous one.                                          */
//    if DISC >= 0 then
    if (disc >= 0) {
        
        
    
    /* We want the smallest time */
//        t :=    min (min (t, 0.5 * (2 * B - sqrt (DISC)) / A), 0.5 * (2 * B + sqrt (DISC)) / A)
        unit t =  MIN (        0.5 * (2 * b -usqrt (disc)) / a , 0.5 * (2 * b + usqrt(disc)) / a);
        
        if (t < *maximumCollisionTimeFound) {
            *maximumCollisionTimeFound = t;
            *objectInCollisionA = i;
            *objectInCollisionB = j;
        }
        
    }
}

@end