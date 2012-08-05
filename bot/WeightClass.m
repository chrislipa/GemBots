//
//  WeightClass.m
//  bot
//
//  Created by Christopher Lipa on 8/4/12.
//
//

#import "WeightClass.h"

@implementation WeightClass
@synthesize loc;
@synthesize shortStringDescription;
@synthesize longStringDescription;

-(id) initWithArray:(NSArray*) array {
    if (self = [super init]) {
        loc = [[array objectAtIndex:0] intValue];
        shortStringDescription = [array objectAtIndex:1];
        longStringDescription = [array objectAtIndex:2];
    }
    return self;
}



+(NSArray*) standardWeightClassesGeneration {
    NSArray* a = @[ @[ @16, @"Flyweight", @"Flyweight (16 LOC)" ],
                    @[ @32, @"Lightweight", @"Welterweight (32 LOC)" ],
                    @[ @64, @"Middleweight", @"Middleweight (64 LOC)" ],
                    @[ @-1, @"Heavyweight", @"Heavyweight (Unlimited LOC)"]
    ];
    NSMutableArray* c = [NSMutableArray array];
    for (NSArray* b in a) {
        [c addObject:[[self alloc] initWithArray:b]];
    }
    return c;
}

+(NSArray*) standardWeightClasses {
    __strong static NSArray* standardWeightClassesStatic = nil;
    if (standardWeightClassesStatic == nil) {
        standardWeightClassesStatic = [self standardWeightClassesGeneration];
    }
    return standardWeightClassesStatic;
}

@end
