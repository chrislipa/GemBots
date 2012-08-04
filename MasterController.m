//
//  MasterController.m
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//

#import "MasterController.h"
#import "BattleDocument.h"
#import "BattleDocumentViewController.h"
#import "EditWindowController.h"
@implementation MasterController

MasterController* staticMasterController = nil;


-(void) spawnEditorWindowForBotContainer:(BotContainer*) bc forBattleDocumentController:(BattleDocumentViewController*) controller {
    EditWindowController* editor = [editorWindows objectForKey:bc.urlToBot];
    if (!editor) {
        editor = [[EditWindowController alloc] initWithBotContainer:bc andBattleDocumentContriller:controller];
        [editor view];
        [controller addEditor:editor];
        [editorWindows setObject:editor forKey:bc.urlToBot];
    }
    [[editor editWindow] makeKeyAndOrderFront:nil];
}


+(MasterController*) singleton {
    return staticMasterController;
}

-(void) loadEngine {
    NSBundle *appBundle;
    NSArray *bundlePaths;
    
    appBundle = [NSBundle mainBundle];
    bundlePaths = [appBundle pathsForResourcesOfType:@"bundle" inDirectory:nil];
    for (NSString* path in bundlePaths) {
        if ([[path lastPathComponent] isEqualTo:@"NativeEngine.bundle"]) {
            NSBundle* bundle = [NSBundle bundleWithPath:path];
            [bundle load];
            return;
        }
    }
    //?
}


- (void)awakeFromNib {
    staticMasterController = self;
    editorWindows = [[NSMutableDictionary alloc] init];
    [self loadEngine];
    NSError* error;
    [[NSDocumentController sharedDocumentController] openUntitledDocumentAndDisplay: YES error: &error];
}

@end
