//
//  BattleDocumentViewController.m
//  bot
//
//  Created by Christopher Lipa on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BattleDocumentViewController.h"

@interface BattleDocumentViewController ()

@end

@implementation BattleDocumentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (IBAction) addRobotButtonEvent:(id)sender {
    [self promptUserToAddRobots];
   
}

-(void) promptUserToAddRobots {
    NSOpenPanel* p = [NSOpenPanel openPanel];
    [p setCanChooseFiles:YES];
    [p setAllowedFileTypes:[NSArray arrayWithObjects:@"at2", nil]];
    [p setCanChooseDirectories:NO];
    [p setResolvesAliases:YES];
    [p runModal];
    NSArray* paths = [p URLs];
    
    for (NSURL* url in paths) {
        [self loadRobotFromURL:url];
    }
}

-(void) loadRobotFromURL:(NSURL*) url {
    NSString* codeString = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:nil];
    
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return 1;//[robots count];
}

- (NSArray *)tableView:(NSTableView *)tableView namesOfPromisedFilesDroppedAtDestination:(NSURL *)dropDestination forDraggedRowsWithIndexes:(NSIndexSet *)indexSet {
    return nil;
}



- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSNib* cell = [[NSNib alloc] initWithNibNamed:@"RobotCell" bundle:nil];
    return cell;
}
@end
