//
//  BattleDocumentViewController.m
//  bot
//
//  Created by Christopher Lipa on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BattleDocumentViewController.h"
#import "RobotCellView.h"
#import "RobotCellViewController.h"
#import "BotDescription.h"

@interface BattleDocumentViewController ()

@end

@implementation BattleDocumentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        robots = [NSMutableArray array];
    
    }
    
    return self;
}


- (IBAction) addRobotButtonEvent:(id)sender {
    [self promptUserToAddRobots];
   
}

-(void) promptUserToAddRobots {
    NSOpenPanel* p = [NSOpenPanel openPanel];
    [p setCanChooseFiles:YES];
    [p setAllowedFileTypes:[NSArray arrayWithObjects:@"pgb", @"pgbbin", nil]];
    [p setCanChooseDirectories:NO];
    [p setResolvesAliases:YES];
    [p runModal];
    NSArray* paths = [p URLs];
    
    [self loadRobotsFromURLs:paths];
}

-(void) loadRobotsFromURLs:(NSArray*) urls {
    for (NSURL* url in urls) {
        BotDescription* d = [[BotDescription alloc] initWithURL:url];
        [robots addObject:d];
    }
    
    [robotList reloadData];
}

-(void) loadRobotFromURL:(NSURL*) url {
    [self loadRobotsFromURLs:[NSArray arrayWithObject:url]];
}
- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 100;
}
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [robots count];
}



- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    
    RobotCellViewController *myViewController = [[RobotCellViewController alloc] initWithNibName:@"RobotCellViewController" bundle:nil];
    RobotCellView* v = (RobotCellView*) myViewController.view;
    BotDescription* bd = [robots objectAtIndex:row];
    [v refreshWithBot:bd];
    return v;

    
    
}

@end
