//
//  Utility.h
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EngineUtility : NSObject

@end


NSDictionary* constantDictionary();
NSDictionary* defaultVariablesDictionary();
int readInteger(NSString* s);