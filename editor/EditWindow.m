//
//  EditWindow.m
//  bot
//
//  Created by Christopher Lipa on 8/2/12.
//
//

#import "EditWindow.h"

@implementation EditWindow
@synthesize controller;

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

-(IBAction) buildCallback:(id) sender {
    [controller buildCallback];
}
-(IBAction) buildAndRunCallback:(id) sender {
    [controller buildAndRunCallback];
}
@end
