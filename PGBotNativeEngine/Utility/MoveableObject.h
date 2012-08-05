//
//  MoveableObject.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/5/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MoveableObject <TangibleObject>
-(unit) internal_speed;
-(int) heading;
@end
