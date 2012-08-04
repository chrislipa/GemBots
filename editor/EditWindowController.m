
//
//  EditWindowController.m
//  GemBotEditor
//
//  Created by Christopher Lipa on 8/2/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "EditWindowController.h"
#import "BotContainer.h"
#import "BattleDocumentViewController.h"
@implementation EditWindowController
@synthesize battleController;
@synthesize editWindow;


-(IBAction) doneButtonPressed:(id) sender {
    NSString* str = textView.stringValue;
    [str writeToURL:botContainer.urlToBot atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [battleController reccompileRobot:botContainer];
}




-(id) initWithBotContainer:(BotContainer*)bc andBattleDocumentContriller:(BattleDocumentViewController*) controller {
    if (self = [super initWithNibName:@"EditWindowController" bundle:nil]) {
        battleController = controller;
        botContainer = bc;
        [self view];
        [self refreshTextFromDisk];
        [textView setEditable:YES];
        [textView setSelectable:YES];
    }
    return self;
}

-(void) refreshTextFromDisk {
    NSString* str,*name;
    if  (botContainer.urlToBot != nil) {
        str = [NSString stringWithContentsOfURL:botContainer.urlToBot encoding:NSUTF8StringEncoding error:nil];
        name = [botContainer.urlToBot lastPathComponent];
    } else {
        str = nil;
        name = @"Robot Editor";
    }
    [textView setStringValue:str];
    [editWindow setTitle:name];
}

- (BOOL)control:(NSControl*)control textView:(NSTextView*)ptextView doCommandBySelector:(SEL)commandSelector
{
    BOOL result = NO;
    
    if (commandSelector == @selector(insertNewline:))
    {
        // new line action:
        // always insert a line-break character and don’t cause the receiver to end editing
        [ptextView insertNewlineIgnoringFieldEditor:self];
        result = YES;
    }
    else if (commandSelector == @selector(insertTab:))
    {
        // tab action:
        // always insert a tab character and don’t cause the receiver to end editing
        [ptextView insertTabIgnoringFieldEditor:self];
        result = YES;
    }
    
    return result;
}

@end
