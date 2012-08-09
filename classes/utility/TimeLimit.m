//
//  TimeLimit.m
//  bot
//
//  Created by Christopher Lipa on 8/4/12.
//
//

#import "TimeLimit.h"

@implementation TimeLimit

@synthesize cycles;
@synthesize shortStringDescription;
@synthesize longStringDescription;
@synthesize isDefault;

-(id) initWithArray:(NSArray*) array {
    if (self = [super init]) {
        cycles = [[array objectAtIndex:0] intValue];
        shortStringDescription = [array objectAtIndex:1];
        longStringDescription = [array objectAtIndex:2];
        isDefault =[[array objectAtIndex:3] boolValue];
    }
    return self;
}



+(NSArray*) standardTimeLimitGeneration {
    NSArray* a = @[ @[ @1000, @"1,000", @"1,000 Cycles",@0 ],
                    @[ @10000, @"10,000", @"10,000 Cycles",@0 ],
                    @[ @100000, @"100,000", @"100,000 Cycles",@1 ],
                    @[ @1000000, @"1,000,000", @"1,000,000 Cycles",@0 ],
                    @[ @0, @"No Limit", @"No Limit",@0]
    ];
    NSMutableArray* c = [NSMutableArray array];
    for (NSArray* b in a) {
        [c addObject:[[self alloc] initWithArray:b]];
    }
    return c;
}

+(TimeLimit*) defaultTimeLimit {
    for (TimeLimit* t in [self standardTimeLimits]) {
        if (t.isDefault) {
            return t;
        }
    }
    return nil;
}

+(NSArray*) standardTimeLimits {
    __strong static NSArray* standardTimeLimitsStatic = nil;
    if (standardTimeLimitsStatic == nil) {
        standardTimeLimitsStatic = [self standardTimeLimitGeneration];
    }
    return standardTimeLimitsStatic;
}

+(TimeLimit*) timeLimitWithTitle:(NSString*)d {
    for (TimeLimit* t in [self standardTimeLimits]) {
        if ([t.longStringDescription isEqualToString:d]) {
            return t;
        }
    }
    return nil;
}


@end
