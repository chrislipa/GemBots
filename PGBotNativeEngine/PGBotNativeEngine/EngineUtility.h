//
//  Utility.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EngineDefinitions.h"
#import "TangibleObject.h"
#import "OrientedObject.h"
#import "TurretedObject.h"

NSString* pathToTextFile(NSString* file) ;

lint roundedDivision(lint numerator, lint denominator);
NSDictionary* constantDictionary();
NSDictionary* defaultVariablesDictionary();
int readInteger(NSString* s);
NSString* uuid();

unit getAngleTo(lint x, lint y);
int anglemod(int a);
lint intsqrt(lint x);
lint internal_distance_between(NSObject<TangibleObject>* a, NSObject<TangibleObject>* b);
int distance_between(NSObject<TangibleObject>* a, NSObject<TangibleObject>* b);
int heading(NSObject<TangibleObject>* a, NSObject<TangibleObject>* b);
int relativeHeading(NSObject<OrientedObject>* a, NSObject<TangibleObject>* b);
int turretRelativeHeading(NSObject<TurretedObject>* a, NSObject<TangibleObject>* b);
int roundInternalDistanceToDistance(lint d);
lint distanceToInternalDistance(int d) ;

int roundInternalHeatToHeat(lint d);
lint heatToInternalHeat(int d) ;

int roundInternalArmorToArmor(lint d) ;
lint armorToInternalArmor(int d) ;

bool isObjectOutOfBounds(NSObject<TangibleObject>* a);

void separateObjectsBy(NSObject<TangibleObject>* a, NSObject<TangibleObject>* b, lint distance);

position positionWithUnits(unit px, unit py);
position positionWithInts(int x, int y);
int roundUnitToInt(unit x) ;
int roundUnitToHeading(unit heading) ;
unit getRoundedAngleTo(unit nx, unit ny) ;