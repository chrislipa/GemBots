//
//  GemBotEditor.h
//  GemBotEditor
//
//  Created by Christopher Lipa on 8/2/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BattleDocumentViewController.h"

@interface GemBotEditor : NSObject

+(void) spawnEditorWindowForURL:(NSURL*) url forBattleDocumentController:(BattleDocumentViewController*) controller;

@end
