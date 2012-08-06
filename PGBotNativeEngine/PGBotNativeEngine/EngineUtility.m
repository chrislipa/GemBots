//
//  Utility.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "EngineUtility.h"
#import "EngineDefinitions.h"
#import "Opcode.h"
void swap (unit *a, unit *b) {
    unit temp = *a;
    *a = *b;
    *b = temp;
}

NSString* pathToTextFile(NSString* file) {
    NSArray* a = [NSBundle allBundles];
    for (NSBundle* b in a) {
        NSString* p = [b pathForResource:file ofType:@"txt"];
        if (p) {
            return p;
        }
            
    }
    return nil;
}

float convert_angle(int hexangle) {
    return (((float)hexangle)/256.0) * M_PI * 2;
}

unit roundedDivision(unit numerator, unit denominator) {
    return numerator/denominator;
}

unit intsqrt(unit x) {
    return sqrt(x);
}


int readInteger(NSString* valueStr) {
    int value;
    if ([valueStr hasPrefix:@"0X"]) {
        unsigned int uvalue;
        NSScanner *scanner = [NSScanner scannerWithString:valueStr];
        [scanner setScanLocation:2];
        [scanner scanHexInt:&uvalue];
        value = uvalue;
    } else if ([valueStr hasPrefix:@"-0X"]) {
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

bool isDecimalInteger(NSString* s) {
    NSScanner* scan = [NSScanner scannerWithString:s];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
bool isHexInteger(NSString* s) {
    NSScanner* scan = [NSScanner scannerWithString:s];
    unsigned int val;
    return [scan scanHexInt:&val] && [scan isAtEnd];
}
bool isInteger(NSString* s) {
    return (([s hasPrefix:@"0X"] && isHexInteger([s substringFromIndex:2])) ||
            ([s hasPrefix:@"-0X"] && isHexInteger([s substringFromIndex:3])) ||
            (isDecimalInteger(s)));

}

NSDictionary* newDictionaryFromTextFile(NSString* file) {
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    NSString* fileName = pathToTextFile(file);
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
     __strong static NSMutableDictionary* constantDictionary = nil;
    if (constantDictionary == nil) {
        constantDictionary = [NSMutableDictionary dictionaryWithDictionary:newDictionaryFromTextFile(@"Constants")];
        [constantDictionary addEntriesFromDictionary:getConstantsFromOpcodes() ];
        [constantDictionary addEntriesFromDictionary:getConstantsFromDevices() ];
        [constantDictionary addEntriesFromDictionary:getConstantsFromSystemCalls() ];
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



unit getAngleToPosition(position p) {
    unit nx = p.x;
    unit ny = p.y;
    lint x = ABS(nx);
    lint y = ABS(ny);
    bool swapped = NO;
    if (y < x) {
        swap(&y,&x);
        swapped = YES;
    }
    
    unit nangle = atan(x/y);
    if (swapped) {
        nangle = 64.0 - nangle;
    }
    
    
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


unit getAngleTo(unit nx, unit ny) {
    return getAngleToPosition(positionWithUnits(nx, ny));
}

unit getRoundedAngleTo(unit nx, unit ny) {
    return roundUnitToHeading(getAngleToPosition(positionWithUnits(nx, ny)));
}


int anglemod(int a) {
    a %= 256;
    if (a < 0) {
        a+=256;
    }
    return a;
}

unit internal_distance_between(NSObject<TangibleObject>* a, NSObject<TangibleObject>* b) {
    unit deltaX = (a.internal_position.x - b.internal_position.x);
    unit deltaY = (a.internal_position.y - b.internal_position.y);
    return sqrt(deltaX*deltaX+deltaY*deltaY);
}

bool isObjectOutOfBounds(NSObject<TangibleObject>* a) {
    return a.internal_position.x < a.internal_radius ||
            a.internal_position.y < a.internal_radius ||
    a.internal_position.x > distanceToInternalDistance(SIZE_OF_ARENA) - a.internal_radius ||
    a.internal_position.y > distanceToInternalDistance(SIZE_OF_ARENA) - a.internal_radius;
    
}

int distance_between(NSObject<TangibleObject>* a, NSObject<TangibleObject>* b) {
    unit d = internal_distance_between(a, b);
    return roundInternalDistanceToDistance(d);
}

int relativeHeading(NSObject<OrientedObject>* a, NSObject<TangibleObject>* b) {
    int absHeading = heading(a,b);
    return anglemod(absHeading - a.heading);
}

int roundUnitToInt(unit x) {
    return (int)round(x);
}

int roundUnitToHeading(unit heading) {
    return roundUnitToInt(heading)&0xFF;
}

int heading(NSObject<TangibleObject>* a, NSObject<TangibleObject>* b) {
    return roundUnitToHeading(getAngleTo( b.internal_position.x-a.internal_position.x, b.internal_position.y-a.internal_position.y));
}

int turretRelativeHeading(NSObject<TurretedObject>* a, NSObject<TangibleObject>* b) {
    int absHeading = heading(a,b);
    return anglemod(absHeading - a.turretHeading);
}

int roundInternalDistanceToDistance(unit d) {
    return roundUnitToInt(d);
}

lint distanceToInternalDistance(int d) {
    return convertIntToUnit(d);
}

int roundInternalHeatToHeat(lint d) {
    return roundUnitToInt(d);
}

lint heatToInternalHeat(int d) {
    return convertIntToUnit(d);
}


int roundInternalArmorToArmor(unit d) {
    return roundUnitToInt(d);
}

unit armorToInternalArmor(int d) {
    return d;
}





unit convertIntToUnit(int z) {
    return (unit)z;
}

position positionWithInts(int x, int y) {
    position p;
    p.x = convertIntToUnit(x);
    p.y = convertIntToUnit(y);
    return p;
}
position positionWithUnits(unit px, unit py) {
    position p;
    p.x = px;
    p.y = py;
    return p;
}

unit convertGameCycleToUnit(int gameCycle) {
    return convertIntToUnit(gameCycle);
}

int roundUnitToGameCycle(unit x) {
    return roundUnitToInt(x);
}

unit convertHeadingToUnit(int heading) {
    return convertIntToUnit(heading);
}

position addPositions(position a, position b) {
    position r;
    r.x = a.x+b.x;
    r.y = a.y+b.y;
    return r;
}

position internal_velocity(NSObject<MoveableObject>* object) {
    unit speed = [object internal_speed];
    int heading = object.heading;
    unit internal_heading = convertHeadingToUnit(heading);
    position internal_velocity;
    // sin and cos are "backwards" here because Gem Bots uses a non-standard coordinate system;
    internal_velocity.x = speed * sin(convert_angle( internal_heading));
    internal_velocity.y = speed * cos(convert_angle(internal_heading));
    return internal_velocity;
}

position scalarMultiply(position p, unit m) {
    position r;
    r.x = p.x*m;
    r.y = p.y*m;
    return r;
}

void updatePositionForwardInTime(NSObject<MoveableObject>* object, unit dt) {
    position old_position = object.internal_position;
    position velocity = internal_velocity(object);
    position travel = scalarMultiply(velocity,dt);
    position new_position = addPositions(old_position, travel);
    object.internal_position = new_position;
}

unit sq(unit z) {
    return z*z;
}

unit usqrt(unit z) {
    return sqrt(z);
}

NSArray* delimit(NSString* s) {
    NSArray* a = [s componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSMutableArray* lineComps = [NSMutableArray array];
    for (NSString* s in a) {
        if (s.length > 0) {
            [lineComps addObject:s];
        }
    }
    return lineComps;
}

