//
//  GemBot+SystemCalls.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+SystemCalls.h"
#import "GemBot+Memory.h"
#import "EngineUtility.h"
#import "GemBot+Interface.h"
#import "PGBotNativeEngine+Interface.h"
@implementation GemBot (SystemCalls)



//0 0 self_destruct
-(void) self_destruct {
    markForSelfDestruction = YES;
}



//1 2 tank_id
-(void) tank_id {
    [self setMemory:FX :unique_tank_id];
}
//2 1 collisions
-(void) collisions {
    [self setMemory:FX :collisions];
}

//3 1 reset_collisions
-(void) reset_collisions {
    collisions = 0;
}
//4 1 reset_odometer
-(void) reset_odometer {
    odometer = 0;
}

//5 10 reboot <-- implemented in compiler

//6 5 locate

-(void) locate {
    [self setMemory:EX :[self x]];
    [self setMemory:FX :[self y]];
}

//7 32 find_angle
-(void) find_angle {
    lint targetX = distanceToInternalDistance([self getMemory:EX]);
    lint targetY = distanceToInternalDistance([self getMemory:FX]);
    lint deltaX = targetX - internal_x;
    lint deltaY = targetY - internal_y;
    int angle = getAngleTo(deltaX,deltaY);
    [self setMemory:AX :angle];
}

//8 1 get_target_id
-(void) get_target_id {
    [self setMemory:FX :mostRecentlyScannedTank.unique_tank_id];
}
//9 2 get_target_info
-(void) get_target_info {
    [self setMemory:EX :mostRecentlyScannedTank.speed];
    
    [self setMemory:FX :anglemod(mostRecentlyScannedTank.heading - self.heading)];
}

    
    
  
//10 2 set_keepshift
-(void) set_keepshift {
    keepshiftOn = ([self getMemory:AX] != 0);
}

//11 1 set_overdrive
-(void) set_overdrive {
    overburnOn = ([self getMemory:AX] != 0);
}
//12 2 get_timer
-(void) get_timer {
    [self setMemory:CX :engine.gameCycle];
}

//13 4 get_game_info
-(void) get_game_info {
    [self setMemory:DX :engine.numberOfRobotsAlive];
    [self setMemory:EX :engine.currentMatch];
    [self setMemory:FX :engine.totalNumberOfMatches];
}
//14 5 get_tank_info
-(void) get_tank_info {
    [self setMemory:DX :self.speed];
    [self setMemory:EX :engine.gameCycle - gameCycleOfLastDamage];
    [self setMemory:FX :engine.gameCycle - lastTimeFiredShotHitATank];
}
//15 3 get_kd_info
-(void) get_kd_info {
    [self setMemory:DX :kills];
    [self setMemory:EX :killsThisMatch];
    [self setMemory:FX :deaths];
}

//implemented in +communications
//16 1 set_comm_channel
//17 1 transmit
//18 1 recieve
//19 1 queued_data_size

//21 1 sys_call_nop
-(void) sys_call_nop {
    
}

@end
