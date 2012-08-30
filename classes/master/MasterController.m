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
#import "AboutWindowViewController.h"

@implementation MasterController
@synthesize pathToSampleBotDirectory;

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
    if (!staticMasterController) {
        staticMasterController = [[MasterController alloc] init];
    }
    return staticMasterController;
}
-(NSURL*) urlToSampleBotDirectory {
    return [NSURL fileURLWithPath:pathToSampleBotDirectory];
}
-(void) loadSampleBots {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *applicationSupportDirectory = [paths objectAtIndex:0];
    NSString *programName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleExecutable"];
    pathToSampleBotDirectory = [[applicationSupportDirectory stringByAppendingPathComponent:programName] stringByAppendingPathComponent:@"samplebots"];
    NSFileManager* fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:pathToSampleBotDirectory]) {
        [fm createDirectoryAtPath:pathToSampleBotDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSString *resourcesPath = [[NSBundle mainBundle] resourcePath];
        NSString* pathToSampleBotsBundle = [resourcesPath stringByAppendingPathComponent:@"samplebots"];
        for (NSString* filename in [fm contentsOfDirectoryAtPath:pathToSampleBotsBundle error:nil]) {
            NSString* src = [pathToSampleBotsBundle stringByAppendingPathComponent:filename];
            NSString* dst = [pathToSampleBotDirectory stringByAppendingPathComponent:filename];
            [fm copyItemAtPath:src toPath:dst error:nil];
        }
    }
    
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
    [self loadSampleBots];
    staticMasterController = self;
    editorWindows = [[NSMutableDictionary alloc] init];
    errorWindows = [[NSMutableDictionary alloc] init];
    battleDocuments = [[NSMutableSet alloc] init];
    referenceCountsToRobotURLs = [NSMutableDictionary dictionary];
    //[self loadEngine];
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

-(IBAction)spawnNewBattleDocument:(id)sender {
    NSError* error = nil;
    [[NSDocumentController sharedDocumentController] openUntitledDocumentAndDisplay: YES error: &error];
}

-(bool) canSafelyCompile:(NSURL*) url {
    return [[referenceCountsToRobotURLs objectForKey:url] intValue] == 0;
}
-(void) notifyOfBattleStartingUsingRobotAtURL:(NSURL*) url {
    NSNumber* count = [referenceCountsToRobotURLs objectForKey:url] ;
    [referenceCountsToRobotURLs setObject:[NSNumber numberWithInt:[count intValue]+1] forKey:url];
    [[editorWindows objectForKey:url] disableBuilding];
}
-(void) notifyOfBattleEndingUsingRobotAtURL:(NSURL*) url {
    NSNumber* count = [referenceCountsToRobotURLs objectForKey:url] ;
    if ([count intValue] > 1) {
        [referenceCountsToRobotURLs setObject:[NSNumber numberWithInt:[count intValue]-1] forKey:url];
    } else {
        [referenceCountsToRobotURLs removeObjectForKey:url];
        [[editorWindows objectForKey:url] enableBuilding];
    }
}



-(IBAction) displayAboutWindow:(id)sender{
    
    
    if (!aboutWindowViewController) {
        aboutWindowViewController = [[AboutWindowViewController alloc] initWithNibName:@"AboutWindowViewController" bundle:nil];
    }
    [aboutWindowViewController view];
    [[aboutWindowViewController aboutWindow] makeKeyAndOrderFront:nil];
    
    

}

-(void) notifyOfAboutWindowClose {
    [[aboutWindowViewController aboutWindow] orderOut:self];
}

-(IBAction) displayAcknoledgementsWindow {
    
    
    if (!acknoledgementsViewController) {
        acknoledgementsViewController = [[AcknoledgementsViewController alloc] initWithNibName:@"AcknoledgementsViewController" bundle:nil];
    }
    [acknoledgementsViewController view];
    [[acknoledgementsViewController acknowledgementsWindow] makeKeyAndOrderFront:nil];
    
}

-(void) displayLicenseWindow {
    
    if (!licenseViewController) {
        licenseViewController = [[LicenseViewController alloc] initWithNibName:@"LicenseViewController" bundle:nil];
    }
    [licenseViewController view];
    [[licenseViewController licenseWindow] makeKeyAndOrderFront:nil];
    
}
-(void) notifyOfLicenseWindowClose {
    [[licenseViewController licenseWindow] orderOut:self];
}

-(void) notifyOfAcknoledgementsWindowClose {
    [[acknoledgementsViewController acknowledgementsWindow] orderOut:self];
}
-(IBAction) displayAcknowledgementWindow:(id)sender{
    
}
-(IBAction) displayLicensingWindow:(id)sender{
    
}

-(IBAction)gemBotsHelp:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://gemrobotgame.appspot.com/"]];
}

-(IBAction)gemBotsRules:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://gemrobotgame.appspot.com/rules.html"]];
}

@end
