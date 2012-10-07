//
//  PGBotEngineRules.m
//  Gem Bots
//
//  Created by Christopher Lipa on 10/3/12.
//
//

#import "PGBotEngineRules.h"

@implementation PGBotEngineRules

@synthesize robotRadius;

-(id) initWithStandardRules {
    if (self = [super init]) {
        self.robotRadius = 3.0;
    }
    return self;
}

@end
