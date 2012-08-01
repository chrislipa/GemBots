//
//  GemBot+Devices.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Devices.h"
#import "GemBot+Memory.h"
#import "PGBotNativeEngine+Interface.h"
#import "EngineUtility.h"
@implementation GemBot (Devices)
//
//0 0 throttle rw
-(void) throttler {
    [self setMemory:op2:self.throttle];
}

-(void) throttlew {
    self.throttle = op2;
}


//1 0 headint rw

-(void) headingr {
    [self setMemory:op2 :self.desiredHeading];
}
-(void) headingw {
    self.desiredHeading = op2;
}
//2 1 steer w

-(void) steerw {
    self.desiredHeading += op2;
}


//3 0 scan_arc rw
-(void) scan_arcr {
    [self setMemory:op2 :self.scan_arc_half_width];
}
-(void) scan_arcw {
    self.scan_arc_half_width = op2;
}



//4 1 radar r
-(void) radarr {
    [self setMemory:op2 :[engine computeRadarFromBot:self]];
}

//5 3 wide_radar r
-(void) wide_radarr {
    [self setMemory:op2 :[engine computeWideRadarFromBot:self]];
}

//6 40 sonar r
-(void) sonarr {
    [self setMemory:op2 :[engine computeSonarFromBot:self]];
}

//7 0 turret_offset rw
-(void) turret_offsetr {
    [self setMemory:op2 : anglemod(turretHeading-heading)];
}
-(void) turret_offsetw {
    turretHeading = anglemod(op2+heading);
}

//8 0 turret_heading rw
-(void) turret_headingr {
    [self setMemory:op2 : turretHeading];
}
-(void) turret_headingw {
    turretHeading = op2;
}

//9 3 fire_missile rw
//10 0 mine w
//11 0 mine_info r
//12 0 detonate_mines w
//13 0 shield rw
//14 0 shutdown_temp rw
//15 0 thermometer r
//16 0 armor r
//17 0 overdrive rw
//18 0 transponder rw
//19 0 random r
//20 -3 device_nop rw
@end
