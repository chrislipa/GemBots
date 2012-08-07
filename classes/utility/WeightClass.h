//
//  WeightClass.h
//  bot
//
//  Created by Christopher Lipa on 8/4/12.
//
//

#import <Foundation/Foundation.h>

@interface WeightClass : NSObject {
    int loc;
    NSString* shortStringDescription;
    NSString* longStringDescription;
    bool isDefault;
}
@property (readwrite) bool isDefault;
@property (readwrite) int loc;
@property (readwrite) NSString* shortStringDescription;
@property (readwrite) NSString* longStringDescription;
+(NSArray*) standardWeightClasses;
+(WeightClass*) defaultWeightClass;
+(WeightClass*) classWithTitle:(NSString*)d;
@end
