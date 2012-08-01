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

NSDictionary* constantDictionary();
NSDictionary* defaultVariablesDictionary();
int readInteger(NSString* s);
NSString* uuid();

int getAngleTo(lint x, lint y);
int anglemod(int a);
lint intsqrt(lint x);
lint internal_distance_between(NSObject<TangibleObject>* a, NSObject<TangibleObject>* b);
int distance_between(NSObject<TangibleObject>* a, NSObject<TangibleObject>* b);
int heading(NSObject<TangibleObject>* a, NSObject<TangibleObject>* b);
int relativeHeading(NSObject<OrientedObject>* a, NSObject<TangibleObject>* b);
int turretRelativeHeading(NSObject<TurretedObject>* a, NSObject<TangibleObject>* b);