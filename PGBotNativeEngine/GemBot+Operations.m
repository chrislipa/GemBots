//
//  GemBot+Operations.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Operations.h"
#import "GemBot+Memory.h"

const int left_filled_mask[33] = {
    0b00000000000000000000000000000000,
    0b10000000000000000000000000000000,
    0b11000000000000000000000000000000,
    0b11100000000000000000000000000000,
    0b11110000000000000000000000000000,
    0b11111000000000000000000000000000,
    0b11111100000000000000000000000000,
    0b11111110000000000000000000000000,
    0b11111111000000000000000000000000,
    0b11111111100000000000000000000000,
    0b11111111110000000000000000000000,
    0b11111111111000000000000000000000,
    0b11111111111100000000000000000000,
    0b11111111111110000000000000000000,
    0b11111111111111000000000000000000,
    0b11111111111111100000000000000000,
    0b11111111111111110000000000000000,
    0b11111111111111111000000000000000,
    0b11111111111111111100000000000000,
    0b11111111111111111110000000000000,
    0b11111111111111111111000000000000,
    0b11111111111111111111100000000000,
    0b11111111111111111111110000000000,
    0b11111111111111111111111000000000,
    0b11111111111111111111111100000000,
    0b11111111111111111111111110000000,
    0b11111111111111111111111111000000,
    0b11111111111111111111111111100000,
    0b11111111111111111111111111110000,
    0b11111111111111111111111111111000,
    0b11111111111111111111111111111100,
    0b11111111111111111111111111111110,
    0b11111111111111111111111111111111
};

const int right_filled_mask[33] = {
    0x00000000,
    0x00000001,
    0x00000003,
    0x00000007,
    0x0000000F,
    0x0000001F,
    0x0000003F,
    0x0000007F,
    0x000000FF,
    0x000001FF,
    0x000003FF,
    0x000007FF,
    0x00000FFF,
    0x00001FFF,
    0x00003FFF,
    0x00007FFF,
    0x0000FFFF,
    0x0001FFFF,
    0x0003FFFF,
    0x0007FFFF,
    0x000FFFFF,
    0x001FFFFF,
    0x003FFFFF,
    0x007FFFFF,
    0x00FFFFFF,
    0x01FFFFFF,
    0x03FFFFFF,
    0x0FFFFFFF,
    0x0FFFFFFF,
    0x1FFFFFFF,
    0x3FFFFFFF,
    0x7FFFFFFF,
    0xFFFFFFFF
};


@implementation GemBot (Operations)

//
//0 1  nop
-(void) nop {
    
}

//1 -1 delay R
-(void) delay {
    
}
//2 1 add L R
-(void) add {
    [self setMemory:op1 :[self getMemory:op1]+op2];
}

//3 1 sub L R
-(void) sub {
    [self setMemory:op1 :[self getMemory:op1]-op2];
}
//4 1 inc L
-(void) inc {
    [self setMemory:op1 :[self getMemory:op1]+1];
}
//5 1 dec L
-(void) dec {
    [self setMemory:op1 :[self getMemory:op1]-1];
}
//6 10 mpy L R
-(void) mpy {
    [self setMemory:op1 :[self getMemory:op1]*op2];
}
//7 10 div L R
-(void) div {
    if (op2 == 0) {
        [self setMemory:op1 :MAXINT];
    } else {
        [self setMemory:op1 :[self getMemory:op1]/op2];
    }
}
//8 10 mod L R
-(void) mod {
    if (op2 == 0) {
        [self setMemory:op1 :0];
    } else {
        [self setMemory:op1 :[self getMemory:op1]%op2];
    }
}

//9 1 sll L R
-(void) sll {
    [self setMemory:op1 :[self getMemory:op1] << op2];
}
//10 1 slr L R

-(void) slr {
    int z = [self getMemory:op1] >> op2;
    if (op2 >= 0 && op2 < 32) {
        z = z & (~left_filled_mask[op2]);
    } else {
        z = 0;
    }
    [self setMemory:op1 : z];
}
//11 1 sar L R
-(void) sar {
    int o = [self getMemory:op1];
    int shift = (op2 < 32 && op2 >= 0? op2 : 32);
    int highBit = (o < 0);
    int z = o >> shift;
    if (highBit) {
        z |= left_filled_mask[shift];
    } else {
        z &= ~left_filled_mask[shift];
    }
    
    [self setMemory:op1 : z];
}

int rotateLeft(int x, int d) {
    d = d % 32;
    if (d < 0) d += 32;
    return (x << d) | ((x >> (32 - d)) & right_filled_mask[d]);
}
//12 1 rl L R
-(void) rl {
    [self setMemory:op1 :rotateLeft([self getMemory:op1],op2)];
}
//13 1 rr L R
-(void) rr {
    [self setMemory:op1 :rotateLeft([self getMemory:op1],-op2)];
}
//14 2 swap L L
-(void) swap {
    int tmp = [self getMemory:op1];
    [self setMemory:op1 :[self getMemory:op2]];
    [self setMemory:op2 :tmp];
}
//15 1 set L R
-(void) set {
    [self setMemory:op1 :op2];
}
//16 2 addr L L
-(void) addr {
    [self setMemory:op1 :op2];
}
//17 2 get L R
-(void) get {
    [self setMemory:op1 :[self getMemory: op2]];
}
//18 2 put L R
-(void) put {
    //tbd
}
//19 1 or L R
-(void) or {
    [self setMemory:op1 :[self getMemory:op1 ] | op2];
}
//20 1 and L R
-(void) and {
    [self setMemory:op1 :[self getMemory:op1 ] & op2];
}
//21 1 xor L R
-(void) xor {
    [self setMemory:op1 :[self getMemory:op1 ] ^ op2];
}
//22 1 not L
-(void) not {
    [self setMemory:op1 :~[self getMemory:op1 ]];
}
//23 1 neg L
-(void) neg {
    [self setMemory:op1 :-[self getMemory:op1]];
}
//24 1 cmp R R
-(void) cmp {
    if (op1 < op2) {
        [self setMemory:CMP_RESULT :2];
    } else if (op1 == op2) {
        [self setMemory:CMP_RESULT :1];
    } else {
        [self setMemory:CMP_RESULT :4];
    }
}

//25 2 test R R
//26 1 jump R
//27 -2 jle R
//28 -2 jlt R
//29 -2 jeq R
//30 -2 jne R
//31 -2 jgt R
//32 -2 jge R
//33 -2 jz R
//34 -2 jnz R
//35 1 push R
//36 1 pop L
//37 -3 syscall R
//38 -4 rd R L
//39 -5 wr R R
//40 1 call R
//41 1 return
//42 1 do R
//43 1 loop R
//44 -6 setb0 L R
//45 -6 setb1 L R
//46 -6 setb2 L R
//47 -6 setb3 L R
//48 -6 sets0 L R
//49 -6 sets1 L R
@end
