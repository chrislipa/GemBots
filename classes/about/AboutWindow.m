//
//  AboutWindow.m
//  Gem Bots
//
//  Created by Christopher Lipa on 8/18/12.
//
//

#import "AboutWindow.h"
#import "MasterController.h"
@implementation AboutWindow

-(bool) windowShouldClose:(id) sender {
    [[MasterController singleton] performSelector:@selector(notifyOfAboutWindowClose) withObject: nil afterDelay:0];
    return NO;
}

@end
