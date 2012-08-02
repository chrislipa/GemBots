//
//  BotDescription.h
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//

#import <Foundation/Foundation.h>
#import "GameStateDescriptor.h"
#import "PGBotEngineProtocol.h"

@interface BotDescription : NSObject {
    NSURL* urlToBot;
    NSString* name;
    NSString* description;
    NSObject<RobotDescription>* robot;
    NSObject<PGBotEngineProtocol>* engine;
}


@property (readwrite,retain) NSObject<RobotDescription>* robot;
-(id) initWithEngine:(NSObject<PGBotEngineProtocol>*) engine andURL:(NSURL*) url;

-(NSString*) name;
-(NSString*) descript;
-(NSString*) author;
-(int) linesOfCode;

-(void) setURLToBot:(NSURL*) url;
-(NSURL*) urlToBot;

@end
