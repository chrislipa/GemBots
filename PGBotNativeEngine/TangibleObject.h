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
-(lint) internal_x;
-(lint) internal_y;
-(lint) internal_radius;
-(void) setInternal_x:(lint) z;
-(void) setInternal_y:(lint) z;
@end

@protocol QueueableTangibleObject <TangibleObject>
-(lint) queued_dx;
-(lint) queued_dy;
-(void) setQueued_dx:(lint)z;
-(void) setQueued_dy:(lint)z;
@end
