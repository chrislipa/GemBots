//
//  BotDescription.h
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//

#import <Foundation/Foundation.h>

@interface BotDescription : NSObject {
    NSURL* urlToBot;
    NSString* name;
    NSString* description;
}

@property (readwrite,retain) NSURL* urlToBot;
@property (readwrite,retain) NSString* name;
@property (readwrite,retain) NSString* description;

-(id) initWithURL:(NSURL*) path;


@end
