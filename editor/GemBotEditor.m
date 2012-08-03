//
//  GemBotEditor.m
//  GemBotEditor
//
//  Created by Christopher Lipa on 8/2/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "GemBotEditor.h"
#import "EditWindowController.h"
#import "EditWindow.h"

#import <Cocoa/Cocoa.h>

@implementation GemBotEditor

+(void) spawnEditorWindowForURL:(NSURL*) url forBattleDocumentController:(BattleDocumentViewController*) controller {
    
    EditWindowController* editor = [[EditWindowController alloc] initWithNibName:@"EditWindow" bundle:nil];
    //[[NSBundle mainBundle] loadNibNamed:@"EditWindow" owner:nil topLevelObjects:nil];
    
    [controller addEditor:editor];
    
}

@end
