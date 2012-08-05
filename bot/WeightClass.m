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
@synthesize isDefault;

-(id) initWithArray:(NSArray*) array {
    if (self = [super init]) {
        loc = [[array objectAtIndex:0] intValue];
        shortStringDescription = [array objectAtIndex:1];
        longStringDescription = [array objectAtIndex:2];
        isDefault = [[array objectAtIndex:3] boolValue];
    }
    return self;
}



+(NSArray*) standardWeightClassesGeneration {
    NSArray* a = @[ @[ @16, @"Flyweight", @"Flyweight (16 LOC)" ,@0],
                    @[ @32, @"Lightweight", @"Welterweight (32 LOC)",@0 ],
                    @[ @64, @"Middleweight", @"Middleweight (64 LOC)",@0 ],
                    @[ @-1, @"Heavyweight", [NSString stringWithUTF8String:"Heavyweight (No Limit)"], @1]
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

+(WeightClass*) defaultWeightClass {
    for (WeightClass* t in [self standardWeightClasses]) {
        if (t.isDefault) {
            return t;
        }
    }
    return nil;
}

+(WeightClass*) classWithTitle:(NSString*)d {
    for (WeightClass* t in [self standardWeightClasses]) {
        if ([t.longStringDescription isEqualToString:d]) {
            return t;
        }
    }
    return nil;
}
@end
