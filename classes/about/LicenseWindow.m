//
//  LicenseWIndow.m
//  Gem Bots
//
//  Created by Christopher Lipa on 8/18/12.
//
//

#import "LicenseWindow.h"
#import "MasterController.h"
@implementation LicenseWindow

-(bool) windowShouldClose:(id) sender {
    [[MasterController singleton] notifyOfLicenseWindowClose];
    return NO;
}


@end
