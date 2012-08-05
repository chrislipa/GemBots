//
//  GemBot+Communication.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBot.h"

@interface GemBot (Communication)


-(void) communicationPhaseSend;
-(void) communicationPhaseSwitchChannels;
-(void) receiveCommunication:(int) message ;


@end
