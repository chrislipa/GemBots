//
//  Utility.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//


#ifndef UtilityEngineH
#define UtilityEngineH
#import <Foundation/Foundation.h>

#import "EngineDefinitions.h"
#import "TangibleObject.h"
#import "OrientedObject.h"
#import "TurretedObject.h"
#import "MoveableObject.h"

NSString* pathToTextFile(NSString* file) ;

unit roundedDivision(unit numerator, unit denominator);
NSDictionary* constantDictionary();
NSDictionary* defaultVariablesDictionary();
int readInteger(NSString* s);
NSString* uuid();

unit getAngleTo(unit x, unit y);
int turretRelativeInternalHeading(NSObject<TurretedObject>* a, NSObject<TangibleObject>* b) ;
int anglemod(int a);
unit intsqrt(unit x);
unit internal_distance_between(NSObject<TangibleObject>* a, NSObject<TangibleObject>* b);
int distance_between(NSObject<TangibleObject>* a, NSObject<TangibleObject>* b);
int heading(NSObject<TangibleObject>* a, NSObject<TangibleObject>* b);
int relativeHeading(NSObject<OrientedObject>* a, NSObject<TangibleObject>* b);
int turretRelativeHeading(NSObject<TurretedObject>* a, NSObject<TangibleObject>* b);
int roundInternalDistanceToDistance(unit d);
unit distanceToInternalDistance(int d) ;

int roundInternalHeatToHeat(unit d);
const unit heatToInternalHeat(const int d) ;

int roundInternalArmorToArmor(unit d) ;
unit armorToInternalArmor(int d) ;

bool isObjectOutOfBounds(NSObject<TangibleObject>* a);

void separateObjectsBy(NSObject<TangibleObject>* a, NSObject<TangibleObject>* b, unit distance);

position positionWithUnits(unit px, unit py);
position positionWithInts(int x, int y);
int roundUnitToInt(unit x) ;
int roundUnitToHeading(unit heading) ;
unit getRoundedAngleTo(unit nx, unit ny) ;
bool isInteger(NSString* s) ;

unit convertGameCycleToUnit(int gameCycle);
int roundUnitToGameCycle(unit x);
void updatePositionForwardInTime(NSObject<MoveableObject>* object, unit dt);
position internal_speed(NSObject<MoveableObject>* object);
position scalarMultiply(position p, unit m) ;
position internal_velocity(NSObject<MoveableObject>* object);
position addPositions(position a, position b);
unit sq(unit z);
unit usqrt(unit z);
unit convertIntToUnit(int z);
NSArray* delimit(NSString* s);
unit convert_angle(int hexangle);
#define MAX_UNIT DBL_MAX

#endif
