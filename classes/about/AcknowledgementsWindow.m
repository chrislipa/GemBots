//
//  AcknowledgementsWindow.m
//  Gem Bots
//
//  Created by Christopher Lipa on 8/18/12.
//
//

#import "AcknowledgementsWindow.h"
#import "MasterController.h"

@implementation AcknowledgementsWindow


-(bool) windowShouldClose:(id) sender {
    [[MasterController singleton] notifyOfAcknoledgementsWindowClose];
    return NO;
}

@end
