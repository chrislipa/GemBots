//
//  TangibleObject.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/31/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EngineDefinitions.h"

@protocol TangibleObject <NSObject>
-(position) internal_position;
-(unit) internal_radius;
-(void) setInternal_position:(position) position;
@end


