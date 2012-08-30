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
#import "AboutWindowViewController.h"
#import "AcknoledgementsViewController.h"
#import "LicenseViewController.h"
@interface MasterController : NSObject {
    NSMutableDictionary* editorWindows;
    NSMutableDictionary* errorWindows;
    NSMutableSet* battleDocuments;
    
    BattleDocumentViewController* fullScreenBattleDocumentViewController;
    IBOutlet NSMenuItem* enterFullScreenMenuItem;
    IBOutlet NSMenuItem* exitFullScreenMenuItem;
    
    NSMutableDictionary* referenceCountsToRobotURLs;
    
     NSWindow* aboutWindow;
    IBOutlet NSWindow* acknoledgementWindow;
    IBOutlet NSWindow* licensingWindow;
    
    __strong AboutWindowViewController* aboutWindowViewController;
    AcknoledgementsViewController* acknoledgementsViewController;
    LicenseViewController* licenseViewController;
    
    NSString* pathToSampleBotDirectory;
}
@property (readonly) NSString* pathToSampleBotDirectory;

-(NSURL*) urlToSampleBotDirectory;
+(MasterController*) singleton;
-(void) loadEngine ;
-(void) spawnEditorWindowForBotContainer:(BotContainer*) bc forBattleDocumentController:(BattleDocumentViewController*) controller;

-(void) spawnErrorWindowForBotContainer:(BotContainer*) bc forBattleDocumentController:(BattleDocumentViewController*) controller;


-(void) notifyOfRecompile:(NSURL*) url ;

-(void) registerBattleDocument:(BattleDocumentViewController*) controller;
-(void) registerBattleDocumentClosing:(BattleDocumentViewController*) controller;

-(IBAction) enterFullScreen:(id)sender;
-(IBAction) exitFullScreen:(id)sender;

-(void) battleDocumentControllerExitedFullScreen:(BattleDocumentViewController*) bdvc;
-(void) battleDocumentControllerEnteredFullScreen:(BattleDocumentViewController*) bdvc;


-(bool) canSafelyCompile:(NSURL*) url;
-(void) notifyOfBattleStartingUsingRobotAtURL:(NSURL*) url;
-(void) notifyOfBattleEndingUsingRobotAtURL:(NSURL*) url;

-(IBAction) displayAboutWindow:(id)sender;
-(void) notifyOfAboutWindowClose;
-(IBAction) displayAcknowledgementWindow:(id)sender;
-(IBAction) displayLicensingWindow:(id)sender;
-(void) displayLicenseWindow ;
-(IBAction) displayAcknoledgementsWindow ;
-(void) notifyOfAcknoledgementsWindowClose;
-(void) notifyOfLicenseWindowClose;

-(IBAction)gemBotsHelp:(id)sender;
-(IBAction)gemBotsRules:(id)sender;

@end
