//
//  BotDescription.m
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//

#import "BotDescription.h"





@implementation BotDescription

-(id) initWithEngine:(NSObject<PGBotEngineProtocol>*) p_engine andURL:(NSURL*) url {
    if (self = [super init]) {
        engine = p_engine;
        [self setURLToBot:url];
    }
    return self;
}

-(void) setSourceCode:(NSData*) source {
    robot = [engine addRobotFromSource:source];
}

-(void) setURLToBot:(NSURL*) p_url {
    urlToBot = p_url;
    NSData* source = [NSData dataWithContentsOfURL:urlToBot];
    [self setSourceCode:source];
}

-(NSURL*) urlToBot {
    return urlToBot;
}

-(NSString*) name {
    return robot.name;
}
-(NSString*) descript {
    return robot.descript;
}
-(NSString*) author {
    return robot.author;
}
-(int) linesOfCode {
    return robot.linesOfCode;
}
@end
