//
//  BotDescription.m
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//

#import "BotDescription.h"





@implementation BotDescription

@synthesize urlToBot;
@synthesize name;
@synthesize description;


-(id) initWithURL:(NSURL*) url {
    if (self = [super init]) {
        self.urlToBot = url;
    }
    return self;
}
@end
