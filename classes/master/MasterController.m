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
#import "CompileErrorWindow.h"
#import "CompileErrorWindowController.h"

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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(editorWindowClosing:)
                                                 name:NSWindowWillCloseNotification
                                               object:editor.editWindow];
}


-(void) spawnErrorWindowForBotContainer:(BotContainer*) bc forBattleDocumentController:(BattleDocumentViewController*) controller {
    CompileErrorWindowController* errors = [errorWindows objectForKey:bc.urlToBot];
    if (!errors) {
        errors = [[CompileErrorWindowController alloc] initWithBotContainer:bc andBattleDocumentContriller:controller];
        [errors view];
        [controller addEditor:errors];
        [errorWindows setObject:errors forKey:bc.urlToBot];
    }
    [[errors errorWindow] makeKeyAndOrderFront:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(errorWindowClosing:)
                                                 name:NSWindowWillCloseNotification
                                               object:errors.errorWindow];
}

-(void) errorWindowClosing:(NSNotification*) not {
    CompileErrorWindow* window = not.object;
    id key = window.controller.botContainer.urlToBot;
    [errorWindows removeObjectForKey:key];
}


-(void) editorWindowClosing:(NSNotification*) not {
    EditWindow* window = not.object;
    id key = window.controller.botContainer.urlToBot;
    [editorWindows removeObjectForKey:key];
}


-(void) notifyOfRecompile:(NSURL*) url {
    CompileErrorWindowController* errors = [errorWindows objectForKey:url];
    if (errors) {
        [errors refresh];
    }
    for (BattleDocumentViewController* c in battleDocuments) {
        [c notifyOfRecompile:url];
    }
}



-(void) closeEditorWindow:(EditWindowController*) controller {
    [errorWindows removeObjectForKey:controller.botContainer.urlToBot];
    
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
        if ([[path lastPathComponent] isEqualTo:@"GemBotEngine.bundle"]) {
            NSBundle* bundle = [NSBundle bundleWithPath:path];
            [bundle load];
            return;
        }
    }
    
}


- (void)awakeFromNib {
    staticMasterController = self;
    editorWindows = [[NSMutableDictionary alloc] init];
    errorWindows = [[NSMutableDictionary alloc] init];
    battleDocuments = [[NSMutableSet alloc] init];
    [self loadEngine];
    NSError* error;
    [[NSDocumentController sharedDocumentController] openUntitledDocumentAndDisplay: YES error: &error];
}

-(void) registerBattleDocument:(BattleDocumentViewController*) controller {
    [battleDocuments addObject:controller];
}
-(void) registerBattleDocumentClosing:(BattleDocumentViewController*) controller {
    [battleDocuments removeObject:controller];
}


-(void) fullScreenHasBeenEntered {
    [enterFullScreenMenuItem setHidden:YES];
    [enterFullScreenMenuItem setKeyEquivalent:@""];
    
    
    [exitFullScreenMenuItem setHidden:NO];
    [exitFullScreenMenuItem setKeyEquivalent:@"f"];
    [exitFullScreenMenuItem setKeyEquivalentModifierMask: NSControlKeyMask   |  NSCommandKeyMask ];
    
    
}

-(void) fullScreenHasBeenExited {
    fullScreenBattleDocumentViewController = nil;
    [exitFullScreenMenuItem setHidden:YES];
    [exitFullScreenMenuItem setKeyEquivalent:@""];
    
    [enterFullScreenMenuItem setHidden:NO];
    [enterFullScreenMenuItem setKeyEquivalent:@"f"];
    [enterFullScreenMenuItem setKeyEquivalentModifierMask: NSControlKeyMask   |  NSCommandKeyMask ];
}



-(void) battleDocumentControllerEnteredFullScreen:(BattleDocumentViewController*) bdvc {
    [self fullScreenHasBeenEntered];
    
}

-(void) battleDocumentControllerExitedFullScreen:(BattleDocumentViewController*) bdvc {
    [self fullScreenHasBeenExited];
}

-(IBAction) enterFullScreen:(id)sender {
    [[[battleDocuments anyObject] battleDocumentWindow] toggleFullScreen:nil];
    [self fullScreenHasBeenEntered];
   
}
-(IBAction) exitFullScreen:(id)sender {
    [[[battleDocuments anyObject] battleDocumentWindow] toggleFullScreen:nil];
    [self fullScreenHasBeenExited];
}

@end
