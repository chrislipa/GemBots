//
//  Utility.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "EngineUtility.h"
#import "EngineDefinitions.h"


lint intsqrt(lint x) {
    lint rv = 0;
    lint b = 1uL << 64-2;
    while (b > x) {
        b >>= 2;
    }
    while (b != 0) {
        if (x >= rv + b) {
            x = x - (rv + b);
            rv = rv + b<<1;
        }
        rv >>= 1;
        b >>= 2;
    }
    
    
    if (x > rv) {
        return rv+1;
    } else {
        return rv;
    }
}


int readInteger(NSString* valueStr) {
    int value;
    if ([valueStr hasPrefix:@"0x"]) {
        unsigned int uvalue;
        NSScanner *scanner = [NSScanner scannerWithString:valueStr];
        [scanner setScanLocation:2];
        [scanner scanHexInt:&uvalue];
        value = uvalue;
    } else if ([valueStr hasPrefix:@"-0x"]) {
        unsigned int uvalue;
        NSScanner *scanner = [NSScanner scannerWithString:valueStr];
        [scanner setScanLocation:3];
        [scanner scanHexInt:&uvalue];
        value = -uvalue;
    } else {
        value = [valueStr intValue];
    }
    return value;
}

NSDictionary* newDictionaryFromTextFile(NSString* file) {
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    
    NSString* fileName = [[NSBundle mainBundle] pathForResource:file ofType:@"txt"];
    NSString* contents =  [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    
    NSArray* lines = [contents componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    
    for (NSString* line in lines) {
        NSArray* lineComps = [line componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([lineComps count] == 2) {
            NSString* key = [lineComps objectAtIndex:0];
            NSString* valueStr = [lineComps objectAtIndex:1];
            int value = readInteger(valueStr);
            NSNumber* numberValue = [NSNumber numberWithInt:value];
            [dictionary setObject:numberValue forKey:key];
        }
    }
    return dictionary;
}

NSDictionary* constantDictionary() {
     __strong static NSDictionary* constantDictionary = nil;
    if (constantDictionary == nil) {
        constantDictionary = newDictionaryFromTextFile(@"Constants");
    }
    return constantDictionary;
}


NSDictionary* defaultVariablesDictionary() {
    static NSDictionary* constantDictionary = nil;
    if (constantDictionary == nil) {
        constantDictionary = newDictionaryFromTextFile(@"DefaultVariables");
    }
    return constantDictionary;
}

NSString* uuid() {
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString	*uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString;
}

int getAngleTo(lint nx, lint ny) {
    lint x = ABS(nx)>>10;
    lint y = ABS(ny)>>10;
    if (x+y == 0) {
        return 0;
    }
    lint norm = intsqrt(x*x+y*y);
    
    int nangle = (int)lround((256.0/(M_2_PI)) *(asin(((double)y)/norm)));
    nangle = 64 - nangle;
    if (nx < 0 && ny >= 0) {
        nangle = 256 - nangle;
    } else if (nx < 0 && ny < 0) {
        nangle = 128 + nangle;
    } else if (nx >= 0 && ny < 0) {
        nangle = 64 + (64-nangle);
    }
    return nangle;
}
int anglemod(int a) {
    a %= 256;
    if (a < 0) {
        a+=256;
    }
    return a;
}

lint internal_distance_between(NSObject<TangibleObject>* a, NSObject<TangibleObject>* b) {
    lint deltaX = (a.internal_x - b.internal_x) >> 10;
    lint deltaY = (a.internal_y - b.internal_y) >> 10;
    return sqrt(deltaX*deltaX+deltaY*deltaY);
}

int distance_between(NSObject<TangibleObject>* a, NSObject<TangibleObject>* b) {
    lint d = internal_distance_between(a, b);
    return roundInternalDistanceToDistance(d);
}

int relativeHeading(NSObject<OrientedObject>* a, NSObject<TangibleObject>* b) {
    int absHeading = heading(a,b);
    return anglemod(absHeading - a.heading);
}

int heading(NSObject<TangibleObject>* a, NSObject<TangibleObject>* b) {
    return getAngleTo(b.internal_x-a.internal_x, b.internal_y-a.internal_y);
}

int turretRelativeHeading(NSObject<TurretedObject>* a, NSObject<TangibleObject>* b) {
    int absHeading = heading(a,b);
    return anglemod(absHeading - a.turretHeading);
}

int roundInternalDistanceToDistance(lint d) {
    return (int)(d + (DISTANCE_MULTIPLIER/2))/DISTANCE_MULTIPLIER;
}

lint distanceToInternalDistance(int d) {
    return (((lint)d) *((lint) DISTANCE_MULTIPLIER));
}

int roundInternalHeatToHeat(lint d) {
    return (int)(d + (HEAT_MULTIPLIER/2))/HEAT_MULTIPLIER;
}

lint heatToInternalHeat(int d) {
    return (((lint)d) *((lint) HEAT_MULTIPLIER));
}


int roundInternalArmorToArmor(lint d) {
    return (int)(d + (ARMOR_MULTIPLIER/2))/ARMOR_MULTIPLIER;
}

lint armorToInternalArmor(int d) {
    return (((lint)d) *((lint) ARMOR_MULTIPLIER));
}

