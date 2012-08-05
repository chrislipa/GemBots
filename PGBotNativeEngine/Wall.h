//
//  Wall.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/5/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollideableObject.h"
@interface Wall : NSObject <CollideableObject>
+( Wall* __strong ) newWall;
@end
