//
//  Document.m
//  bot
//
//  Created by Christopher Lipa on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BattleDocument.h"
#import "WeightClass.h"
@implementation BattleDocument




- (id)init
{
    self = [super init];
    if (self) {
       
        
        
        // Add your subclass-specific initialization here.
    }
    return self;
}



- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"BattleDocument";
}




- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
    
    

}

+ (BOOL)autosavesInPlace
{
    return YES;
}

@end
