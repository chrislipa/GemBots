//
//  CompileErrorWindowControllerViewController.m
//  bot
//
//  Created by Christopher Lipa on 8/4/12.
//
//

#import "CompileErrorWindowController.h"
#import "CompileErrorCellViewController.h"
#import "MasterController.h"

@implementation CompileErrorWindowController
@synthesize errorWindow;
@synthesize botContainer;
@synthesize scrollView;
@synthesize tableView;
-(id) initWithBotContainer:(BotContainer*)bc andBattleDocumentContriller:(BattleDocumentViewController*) controller 
{
    self = [super initWithNibName:@"CompilerErrorController" bundle:nil];
    if (self) {
        cellControllers  = [NSMutableDictionary dictionary];
        battleController = controller;
        botContainer = bc;
        [self view];
        [self refresh];
        
    }
    
    return self;
}

-(void) refresh {
    [cellControllers removeAllObjects];
    NSString* title;
    title = [NSString stringWithFormat:@"%@ Errors",botContainer.urlToBot.lastPathComponent];
    [errorWindow setTitle:title];
    [tableView reloadData];
    [tableView setNeedsDisplay];
    [tableView setNeedsLayout:YES];
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 35;
}
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [botContainer.robot.compileErrors count];
}


- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    id key = [NSNumber numberWithLong:row];
    CompileErrorCellViewController *controller = [cellControllers objectForKey:key];
    if (!controller) {
        NSObject<CompileErrorProtocol>* compileError = [botContainer.robot.compileErrors objectAtIndex:row];
        controller = [[CompileErrorCellViewController alloc] initWithCompileError:compileError];
        [cellControllers setObject:controller forKey:key];
    }
    return controller.view;
}




@end
