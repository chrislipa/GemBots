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
#import "BotContainer.h"

@interface BattleDocumentViewController ()

@end

@implementation BattleDocumentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        robots = [NSMutableArray array];
        Class c = NSClassFromString(@"PGBotNativeEngine");
        engine = [[c alloc] init];
        editors = [[NSMutableArray alloc] init];
        robotCellViewControllers = [[NSMutableDictionary alloc] init];
        teamTitles = [NSMutableArray array];
    }
    
    
    return self;
}


- (IBAction) addRobotButtonEvent:(id)sender {
    [self promptUserToAddRobots];
   
}

-(void) promptUserToAddRobots {
    NSOpenPanel* p = [NSOpenPanel openPanel];
    [p setCanChooseFiles:YES];
    [p setAllowedFileTypes:[NSArray arrayWithObjects:@"gembot", nil]];
    [p setCanChooseDirectories:NO];
    [p setResolvesAliases:YES];
    [p runModal];
    NSArray* paths = [p URLs];
    
    [self loadRobotsFromURLs:paths];
}

-(void) loadRobotsFromURLs:(NSArray*) urls {
    [self performSelector:@selector(loadRobotsFromURLs_internal:) withObject:urls afterDelay:0.1];
}

-(void) setRobotToNewTeam:(BotContainer*) robot {
    int team = 0;
    bool match;
    do {
        team++;
        match = NO;
        for (BotContainer* bot in robots) {
            if (bot.robot.team == team && bot != robot) {
                match = YES;
                break;
            }
        }
    } while (match);
    robot.robot.team = team;
    
}

-(void) addRobot:(BotContainer*) robot {
    [robots addObject:robot];
    [self setRobotToNewTeam:robot];
    [robotList reloadData];
    for (id key in robotCellViewControllers) {
        RobotCellViewController* rcvc = [robotCellViewControllers objectForKey:key];
        [rcvc.cell refreshTeams];
    }
    
}

-(void) loadRobotsFromURLs_internal:(NSArray*) urls {
    for (NSURL* url in urls) {
        BotContainer* d = [[BotContainer alloc] initWithEngine:engine andURL:url andDocumentController:self];
        [self addRobot:d];
    }
    
    
}

-(void) loadRobotFromURL:(NSURL*) url {
    [self loadRobotsFromURLs:[NSArray arrayWithObject:url]];
}
- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 125;
}
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [robots count];
}
-(void) addEditor:(id) editor {
    [editors addObject:editor];
}


- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    id key = [NSNumber numberWithLong:row];
    RobotCellViewController *controller = [robotCellViewControllers objectForKey:key];
    if (!controller) {
        BotContainer* robot = [robots objectAtIndex:row];
        controller = [[RobotCellViewController alloc] initWithNibName:@"RobotCellViewController" andController:self andRobot:robot];
        [robotCellViewControllers setObject:controller forKey:key];
    }
    
    return controller.view;
}

-(NSColor*) unusedColorForNewRobot {
    NSArray* colors = [NSArray arrayWithObjects:
                       [NSColor blueColor],
                       [NSColor redColor],
                       [NSColor greenColor],
                       [NSColor cyanColor],
                       [NSColor magentaColor],
                       [NSColor orangeColor],
                       [NSColor purpleColor],
                       [NSColor whiteColor],
                       [NSColor yellowColor],
                       nil];
    NSMutableDictionary* d = [NSMutableDictionary dictionary];
    for (NSColor* c in colors) {
        [d setObject:[NSNumber numberWithInt:0] forKey:c];
    }
    for (BotContainer* bot in robots) {
        if (bot.color) {
            [d setObject:[NSNumber numberWithInt:1+[[d objectForKey:bot.color] intValue]] forKey:bot.color];
        }
    }
    int smallest = (int)[robots count]+1;
    NSColor* lowestColor = nil;
    for (NSColor* c in colors) {
        if ([[d objectForKey:c] intValue] < smallest) {
            lowestColor = c;
            smallest = [[d objectForKey:c] intValue];
        }
    }
    return lowestColor;
}

-(int) numberOfTeams {
    return (int)[robots count];
}
-(int) emptyTeamForRobot:(NSObject<RobotDescription>*) bot; {
    for (int i = 0; ; i++) {
        bool match = NO;
        for (NSObject<RobotDescription>* r in robots) {
            if (r != bot) {
                if (r.team == i) {
                    match = YES;
                    break;
                }
            }
        }
        if (!match) {
            return i;
        }
    }
}

-(void) reccompileRobot:(BotContainer*) bot {
    for(int i = 0; i < [robots count]; i++) {
        id key = [NSNumber numberWithLong:i];
        RobotCellViewController* cellController = [robotCellViewControllers objectForKey:key];
        if ([bot.urlToBot isEqualTo:cellController.botContainer.urlToBot] || bot == cellController.botContainer) {
            [cellController.botContainer recompile];
            [cellController refresh];
        }
    }
}

-(NSArray*) teamTitles {
    while ([teamTitles count] < [robots count]) {
        [teamTitles addObject:[NSString stringWithFormat:@"%ld",[teamTitles count]+1]];
    }
    while ([teamTitles count] > [robots count]) {
        [teamTitles removeLastObject];
    }
    return teamTitles;
}

@end
