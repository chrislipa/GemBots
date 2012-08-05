//
//  MasterController.h
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//

#import <Foundation/Foundation.h>
#import "BotContainer.h"
#import "BattleDocumentViewController.h"
#import "CompileErrorWindowController.h"

@interface MasterController : NSObject {
    NSMutableDictionary* editorWindows;
    NSMutableDictionary* errorWindows;
}

+(MasterController*) singleton;
-(void) spawnEditorWindowForBotContainer:(BotContainer*) bc forBattleDocumentController:(BattleDocumentViewController*) controller;

-(void) spawnErrorWindowForBotContainer:(BotContainer*) bc forBattleDocumentController:(BattleDocumentViewController*) controller;

-(void) closeCompileErrorWindow:(CompileErrorWindowController*) controller;
-(void) notifyOfRecompile:(NSURL*) url ;
@end
