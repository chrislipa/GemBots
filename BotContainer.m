//
//  BotDescription.m
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//

#import "BotContainer.h"





@implementation BotContainer
@synthesize color;
@synthesize team;

-(id) initWithEngine:(NSObject<PGBotEngineProtocol>*) p_engine andURL:(NSURL*) url andDocumentController:(BattleDocumentViewController*) pdocumentController {
    if (self = [super init]) {
        self.documentController = pdocumentController;
        self.color = [self.documentController unusedColorForNewRobot];
        engine = p_engine;
        [self setURLToBot:url];
        self.team = [self.documentController unusedTeamForRobot:self];
    }
    return self;
}

-(void) setSourceCode:(NSData*) source {
    if (!robot) {
        robot = [engine newRobot];
    }
    [engine recompileRobot:(NSObject<RobotDescription>*) robot withSource:source];
}

-(void) setURLToBot:(NSURL*) p_url {
    urlToBot = p_url;
    [self recompile];
}
-(void) recompile {
    NSData* source = [NSData dataWithContentsOfURL:urlToBot];
    [self setSourceCode:source];
}

-(NSURL*) urlToBot {
    return urlToBot;
}

-(NSString*) name {
    if (robot.name) {
        return robot.name;
    } else {
        return @"";
    }
    
}
-(NSString*) descript {
    if ( robot.descript) {
        return robot.descript;
    } else {
        return @"";
    }
    
}
-(NSString*) author {
    if (robot.author) {
        return robot.author;
    } else {
        return @"";
    }
    
}
-(int) linesOfCode {
    return robot.linesOfCode;
}

@end
