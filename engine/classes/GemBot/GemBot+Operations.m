//
//  GemBot+Operations.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Operations.h"
#import "GemBot+Memory.h"
#import "EngineDefinitions.h"

#import <objc/message.h>

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
-(void) mov {
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
-(void) test {
    [self setMemory:CMP_RESULT :op1 & op2];
}

//26 1 jump R {
-(void) jump {
    [self setMemory:IP :op1];
}

//27 -2 jle R

-(void) jle {
    int c = [self getMemory:CMP_RESULT];
    if (c == 1 || c == 2) {
        [self jump];
    }
}
//28 -2 jlt R
-(void) jlt {
    int c = [self getMemory:CMP_RESULT];
    if (c == 2) {
        [self jump];
    }
}
//29 -2 jeq R
-(void) jeq {
    int c = [self getMemory:CMP_RESULT];
    if (c == 1) {
        [self jump];
    }
}
//30 -2 jne R
-(void) jne {
    int c = [self getMemory:CMP_RESULT];
    if (c != 1 ) {
        [self jump];
    }
}
//31 -2 jgt R
-(void) jgt {
    int c = [self getMemory:CMP_RESULT];
    if (c == 4) {
        [self jump];
    }
}
//32 -2 jge R
-(void) jge {
    int c = [self getMemory:CMP_RESULT];
    if (c == 1 || c == 4) {
        [self jump];
    }
}
//33 -2 jz R
-(void) jz {
    int c = [self getMemory:CMP_RESULT];
    if (c == 0) {
        [self jump];
    }
}
//34 -2 jnz R
-(void) jnz {
    int c = [self getMemory:CMP_RESULT];
    if (c != 0) {
        [self jump];
    }
}
//35 1 push R
-(void) push {
    [self setMemory:[self getMemory:SP] :op1];
    [self setMemory:SP :[self getMemory:SP]+1];
}
//36 1 pop L
-(void) pop {
    [self setMemory:SP :[self getMemory:SP]-1];
    [self setMemory:op1:[self getMemory:SP]];
}
//37 -3 syscall R
-(void) syscall {
    objc_msgSend(self, systemCall.selector);
}
//38 -4 rd R L
-(void) rd {
    objc_msgSend(self, device.selector);
}

//39 -5 wr R R
-(void) wr {
    objc_msgSend(self, device.selector);
}
//40 1 call R
-(void) call {
    [self setMemory:[self getMemory:SP] :[self getMemory:IP]];
    [self setMemory:SP :[self getMemory:SP]+1];
    [self setMemory:IP :op1];
}

//41 1 returnI
-(void) returnI {
    [self setMemory:SP :[self getMemory:SP]-1];
    [self setMemory:[self getMemory:IP]:[self getMemory:SP]];
}

//42 1 doI R

-(void) doI {
    [self setMemory:LOOP_CTR :op1];
}
//43 1 loopI R
-(void) loopI {
    [self setMemory:LOOP_CTR :[self getMemory:LOOP_CTR]-1];
    if ([self getMemory:LOOP_CTR] > 0) {
        [self setMemory:IP :op1];
    }
}

//44 -6 setb0 L R
-(void) setb0 {
    int z = ([self getMemory:op1]& NOTB0) | ((op2 & B0)<<0);
    [self setMemory:op1 :z];
}
//45 -6 setb1 L R
-(void) setb1 {
    int z = ([self getMemory:op1]& NOTB1) | ((op2 & B0)<<8);
    [self setMemory:op1 :z];
}
//46 -6 setb2 L R
-(void) setb2 {
    int z = ([self getMemory:op1]& NOTB2) | ((op2 & B0)<<16);
    [self setMemory:op1 :z];
}
//47 -6 setb3 L R
-(void) setb3 {
    int z = ([self getMemory:op1]& NOTB3) | ((op2 & B0)<<24);
    [self setMemory:op1 :z];
}
//48 -6 sets0 L R
-(void) sets0 {
    int z = ([self getMemory:op1]& NOTS0) | ((op2 & S0)<<0);
    [self setMemory:op1 :z];
}
//49 -6 sets1 L R
-(void) sets1 {
    int z = ([self getMemory:op1]& NOTS1) | ((op2 & S0)<<16);
    [self setMemory:op1 :z];
}
-(void) log {
    [self executionLog:[NSString stringWithFormat:@"%d",op1]];
}

-(void) logvalue {
    [self executionLog:[NSString stringWithFormat:@"%@",[self loggingStatement:op2]]];
}



@end
