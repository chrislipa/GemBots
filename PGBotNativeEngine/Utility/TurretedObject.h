//
//  TurretedObject.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrientedObject.h"

@protocol TurretedObject <OrientedObject>
-(int) turretHeading;
@end
