//
//  GemBot+Devices.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Devices.h"
#import "GemBot+Memory.h"

@implementation GemBot (Devices)
//
//0 0 throttle rw
-(void) throttler {
    [self setMemory:op1:self.throttle];
}

-(void) throttlew {
    self.throttle = op1;
}


//1 0 headint rw

-(void) headingr {
    [self setMemory:op1 :self.desiredHeading];
}
-(void) headingw {
    self.desiredHeading = op1;
}
//2 1 steer w

-(void) steerw {
    self.desiredHeading += op1;
}


//3 0 scan_arc rw
-(void) scan_arcr {
    [self setMemory:op1 :self.scan_arc_half_width];
}
-(void) scan_arcw {
    self.scan_arc_half_width = op1;
}



//4 1 radar r
-(void) radarr {
    
}

//5 3 wide_radar r
//6 40 sonar r
//7 0 turret_offset rw
//8 0 turret_heading rw
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
