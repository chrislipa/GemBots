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
#import "BattleDocumentViewController.h"

@class BattleDocumentViewController;
@interface BotContainer : NSObject {
    NSURL* urlToBot;
    NSObject<RobotDescription>* robot;
    NSObject<PGBotEngineProtocol>* engine;
    BattleDocumentViewController* documentController;
    NSColor* color;
    int team;
}
@property (readwrite,assign) int team;
@property (readwrite,retain) BattleDocumentViewController* documentController;
@property (readwrite,retain) NSObject<RobotDescription>* robot;
@property (readwrite,retain,nonatomic) NSColor* color;

-(id) initWithEngine:(NSObject<PGBotEngineProtocol>*) engine andURL:(NSURL*) url andDocumentController:(BattleDocumentViewController*) documentController;

-(NSString*) name;
-(NSString*) descript;
-(NSString*) author;
-(int) linesOfCode;

-(void) setURLToBot:(NSURL*) url;
-(NSURL*) urlToBot;
-(void) recompile;
@end
