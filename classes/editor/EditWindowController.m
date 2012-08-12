
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
#import "BattleDocumentViewController+BattleManager.h"
@implementation EditWindowController
@synthesize battleController;
@synthesize editWindow;
@synthesize botContainer;

-(void) buildRequested {
    NSString* str = [NSString stringWithString: textView.textStorage.string ];
    [str writeToURL:botContainer.urlToBot atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [battleController reccompileRobot:botContainer];
}


-(void) buildCallback {
    [self buildRequested];
}
-(void) buildAndRunCallback {
     [self buildRequested];
    [battleController runRequestedFromEditor];
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
    [textView setGrammarCheckingEnabled:NO];
    //[textView setIncrementalSearchingEnabled:YES];
    //[textView setRulerVisible:YES];
    [textView setUsesFindBar:YES];
    
    
    NSString* str,*name;
    if  (botContainer.urlToBot != nil) {
        str = [NSString stringWithContentsOfURL:botContainer.urlToBot encoding:NSUTF8StringEncoding error:nil];
        name = [botContainer.urlToBot lastPathComponent];
    } else {
        str = nil;
        name = @"Robot Editor";
        
    }
    [textView setString:str];
    NSFont* f = [NSFont fontWithName:@"MONACO" size:14];
    [textView.textStorage setFont:f];
    [editWindow setTitle:name];
    [textCell setHighlighted:NO];

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
