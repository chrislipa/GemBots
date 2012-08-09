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
#import "BattleDocumentViewController+UserInterface.h"
#import "MasterController.h"
#import "BattleDocumentViewController+BattleManager.h"
@interface BattleDocumentViewController ()

@end

@implementation BattleDocumentViewController
@synthesize weightClass;


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
        weightClass = [WeightClass defaultWeightClass];
        timeLimit = [TimeLimit defaultTimeLimit];
        numberOfMatches = 10;
        [[MasterController singleton] registerBattleDocument:self];

        
    }
    
    
    return self;
}

-(void) awakeFromNib {


    
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
    [p setAllowsMultipleSelection:YES];
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
    [self notifyOfTeamsChange];
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
    return 100;
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
    [(RobotCellViewController*)controller notifyOfBattleEnding];
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

-(int) unusedTeamForRobot:(BotContainer*) bot {
    for (int team = 1; ; team++) {
        bool match = NO;
        for (BotContainer* r in robots) {
            if (bot != r) {
                if (r.team == team) {
                    match = YES;
                    break;
                }
            }
        }
        if (!match) {
            return team;
        }
    }
}

-(int) numberOfTeams {
    return (int)[robots count];
}

-(void) notifyOfTeamsChange {
    NSMutableDictionary* teams = [NSMutableDictionary dictionary];
    for (BotContainer* bot in robots) {
        NSNumber* k = [NSNumber numberWithInt:bot.team];
        NSNumber* x = [teams objectForKey:k];
        if (x == nil) {
            x = [NSNumber numberWithInt:0];
        }
        x = [NSNumber numberWithInt:[x intValue]+1];
        [teams setObject:x forKey:k];
    }
    NSMutableArray* a = [NSMutableArray array];
    for (id k in teams) {
        [a addObject:[teams objectForKey:k]];
    }
    [a sortUsingSelector:@selector(compare:)];
    NSString* teamText;
    bool all1 = YES;
    for (NSNumber* x in a) {
        if ([x intValue] != 1) {
            all1 = NO;
            break;
        }
    }
    if ([a count] < 2) {
        teamText = @"";
    } else if ([a count] == 2 && all1) {
        teamText = @"1v1";
    } else if (all1) {
        teamText = [NSString stringWithFormat:@"%ld Bot FFA", [a count]];
    } else {
        teamText = [NSMutableString stringWithString:@""];
        for (long i = [a count]-1; i >=0;i--) {
            [(NSMutableString*)teamText appendFormat:@"%dv",[[a objectAtIndex:i] intValue]];
        }
        teamText = [teamText substringToIndex:[teamText length]-1];
    }
    [teamTextCell setStringValue:teamText];
    
    
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
    [[MasterController singleton] notifyOfRecompile:bot.urlToBot];
}

-(NSArray*) teamTitles {
    NSUInteger t = [robots count];
    for (BotContainer* bot in robots) {
        t = MAX(t, bot.team);
    }
    
    while ([teamTitles count] < t) {
        [teamTitles addObject:[NSString stringWithFormat:@"%ld",[teamTitles count]+1]];
    }
    while ([teamTitles count] > [robots count]) {
        [teamTitles removeLastObject];
    }
    return teamTitles;
}

-(void) removeRobot:(BotContainer*) bot {
    NSUInteger row = [robots indexOfObject:bot];
    id key = [NSNumber numberWithLong:row];
    if (bot.robot) {
        [engine removeRobot:bot.robot];
    }
    
    [robots removeObject:bot];
    [robotCellViewControllers removeObjectForKey:key];
    [robotList reloadData];
}

-(IBAction)locPickerChanged:(id)sender {
    weightClass = [WeightClass classWithTitle: [weightClassPicker selectedItem].title];
}
-(IBAction)timeLimitPickerChaged:(id)sender {
    timeLimit = [TimeLimit timeLimitWithTitle:[gameCycleTimeOutPicker selectedItem].title];
}
-(IBAction)numberOfMatchesChanged:(id)sender {
    numberOfMatches = [[numberOfMatchesField stringValue] intValue];
}

-(void) dealloc {
    [[MasterController singleton] registerBattleDocumentClosing:self];
}

-(void) notifyOfRecompile:(NSURL*) url {
    for (int i = 0; i<[robots count]; i++ ){
        BotContainer* b = [robots objectAtIndex:i];
        if ([b.urlToBot isEqualTo:url]) {
            RobotCellViewController* c = [robotCellViewControllers objectForKey:[NSNumber numberWithInt:i]];
            [c refresh];
        }
    }
}

-(IBAction) gamespeedSliderCallback:(id)sender {
    [self computeGameSpeedBasedOnSlider];
}
-(void) computeGameSpeedBasedOnSlider {
    float x =[gamespeedSlider floatValue];
    float n = (x) /100.0;
    delayBetweenGameCycles = 1/(sqrt(n))-1.0;
    delayBetweenGameCycles /= 3;
    [self notifyOfGameSpeedChange];
}

@end
