//
//  GemBot+Communication.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot+Communication.h"

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
    if (comm_write_ptr == comm_read_ptr) {
        return;
    }
    int r = [self getMemory:comm_read_ptr];
    [self setMemory:FX :r];
    comm_read_ptr++;
    if (comm_read_ptr == COMMUNICATION_MEMORY_END) {
        comm_read_ptr = COMMUNICATION_MEMORY_START;
    }
}
//19 1 queued_data_size
-(void) queued_data_size {
    int v;
    v = comm_write_ptr - comm_read_ptr;
    if (v < 0) {
        v += COMMUNICATION_MEMORY_END - COMMUNICATION_MEMORY_START;
    }
    [self setMemory:FX :v];
}


@end
