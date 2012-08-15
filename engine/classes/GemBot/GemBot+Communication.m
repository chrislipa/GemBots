//
//  GemBot+Communication.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Communication.h"
#import "GemBot+Memory.h"
#import "PGBotNativeEngine+Interface.h"
@implementation GemBot (Communication)


//16 1 set_comm_channel
-(void) set_comm_channel {
    comm_channel_to_switch_to = [self getMemory:AX];
    swtich_comm_channel_this_turn = YES;
}

//17 1 transmit
-(void) transmit {
    comm_transmits_this_turn[number_of_comm_transmits_this_turn++] = [self getMemory:AX];
}
//18 1 recieve
-(void) recieve {
    int r;
    if (comm_write_ptr == comm_read_ptr) {
        r = 0;
    } else {
        r = comm_queue[comm_read_ptr];
        comm_read_ptr++;
        if (comm_read_ptr == SIZE_OF_COMM_QUEUE) {
            comm_read_ptr = 0;
        }
    }
    [self setMemory:FX :r];
    
}
//19 1 queued_data_size
-(void) queued_data_size {
    int v;
    v = comm_write_ptr - comm_read_ptr;
    if (v < 0) {
        v += SIZE_OF_COMM_QUEUE;
    }
    [self setMemory:FX :v];
}

-(void) communicationPhaseSend {
    for(int i = 0; i< number_of_comm_transmits_this_turn;i++) {
        [engine transmit:comm_transmits_this_turn[i] onChannel:comm_channel];
    }
}
-(void) communicationPhaseSwitchChannels {
    if (swtich_comm_channel_this_turn) {
        comm_channel = comm_channel_to_switch_to;
        for (int i = 0; i < SIZE_OF_COMM_QUEUE; i++) {
            memory[i] = 0;
        }
        swtich_comm_channel_this_turn = NO;
        comm_read_ptr = comm_write_ptr = 0;
    }
}

-(void) receiveCommunication:(int) message {
    comm_queue[comm_write_ptr++] = message;
    if (comm_write_ptr == SIZE_OF_COMM_QUEUE) {
        comm_write_ptr = 0;
    }
    if (comm_write_ptr == comm_read_ptr) {
        comm_read_ptr++;
        if (comm_read_ptr == SIZE_OF_COMM_QUEUE) {
            comm_read_ptr = 0;
        }
    }
}
@end
