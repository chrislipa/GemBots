//
//  DebuggerWindowController.m
//  Gem Bots
//
//  Created by Christopher Lipa on 8/11/12.
//
//

#import "DebuggerWindowController.h"



@implementation DebuggerWindowController

@synthesize botContainer;
@synthesize battleController;
@synthesize debuggerWindow;

-(void) refreshFromBot {
    
}

-(id) initWithBotContainer:(BotContainer*)bc andBattleDocumentContriller:(BattleDocumentViewController*) controller {
    if (self = [super initWithNibName:@"DebuggerWindowController" bundle:nil]) {
        battleController = controller;
        botContainer = bc;
        [self view];
        [self refreshFromBot];
       
    }
    return self;
}




@end
