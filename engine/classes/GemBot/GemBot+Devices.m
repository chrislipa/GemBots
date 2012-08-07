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
#import "GemBot+Stats.h"
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
    self.desiredHeading = (((op2 % 256)+256) & 255);
}
//2 1 steer w

-(void) steerw {
    self.desiredHeading += op2;
    self.desiredHeading = (((self.desiredHeading % 256)+256) & 255);
    
}


//3 0 scan_arc rw
-(void) scan_arcr {
    [self setMemory:op2 :self.scan_arc_width];
}
-(void) scan_arcw {
    self.scan_arc_width = op2;
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
    turretHeading = 255 & op2;
}

//9 3 fire_missile w
-(void) fire_missilew {
    [engine fireMissileFrom:internal_position inDirection:turretHeading+op2 withOwner:self];
    internal_heat += [self heatFromFiringMissile];
}

//10 0 mine w

-(void) minew {
    if (numberOfMinesLayed < [self numberOfMinesConfig]) {
        [engine layMineAt:internal_position withOwner:self andRadius:distanceToInternalDistance(op2)];
        numberOfMinesLayed++;
    } else {
        [self executionError:@"No mines to lay."];
    }
}
//11 0 mine_info r
-(void) mine_infor {
    [self setMemory:op2 :[engine howManyMinesHaveThisOwner:self]];
}

//12 0 detonate_mines w
-(void) detonate_minesw {
    [engine detonateAllMinesWithOwner:self];
}

//13 0 shield rw
-(void) shieldr {
    [self setMemory:op2 :shieldOn];
}
-(void) shieldw {
    shieldOn = (op2 != 0);
}

//14 0 shutdown_temp rw
-(void) shutdown_tempr {
    [self setMemory:op2 :roundInternalHeatToHeat(internal_shutdown_temp) ];
}
-(void) shutdown_tempw {
    internal_shutdown_temp = heatToInternalHeat(op2);
}


//15 0 thermometer r
-(void) thermometerr {
    [self setMemory:op2 :roundInternalHeatToHeat(internal_heat)];
}

//16 0 armor r
-(void) armorr {
    [self setMemory:op2 :roundInternalArmorToArmor(internal_armor)];
}

//17 0 overdrive rw
-(void) overdriver {
    [self setMemory:op2 :overburnOn];
}
-(void) overdrivew {
    overburnOn = ([self getMemory:op2] != 0);
}


//18 0 transponder rw


//19 0 random r
-(void) randomr {
    [self setMemory:op2 :[engine.random randomInt]];
}

//20 -3 device_nop rw

-(void) device_nopr {
    
}

-(void) device_nopw {
    
}
@end
