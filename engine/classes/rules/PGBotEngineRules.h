//
//  PGBotEngineRules.h
//  Gem Bots
//
//  Created by Christopher Lipa on 10/3/12.
//
//

#import <Foundation/Foundation.h>
#import "PGBotEngineProtocol.h"

@interface PGBotEngineRules : NSObject <PGBotEngineRulesProtocol>  {
    double robotRadius;
    
}

@property (readwrite) double robotRadius;

-(id) initWithStandardRules;
 
@end
