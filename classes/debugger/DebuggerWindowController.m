//
//  DebuggerWindowController.m
//  Gem Bots
//
//  Created by Christopher Lipa on 8/11/12.
//
//

#import "DebuggerWindowController.h"



@implementation DebuggerWindowController

@synthesize botContainer;
@synthesize battleController;
@synthesize debuggerWindow;

-(void) makeViewBlack:(NSView*) v  {
    CALayer *layer = [v layer];
    if (!layer) {
        layer= [CALayer layer];
        [v setLayer:layer];
    }
    [layer setBackgroundColor:CGColorCreateGenericRGB(0.0, 0.0, 0.0, 1.0)];
    [v setWantsLayer:YES];
    
}

-(void) refreshForRecompile {
    NSFont* font = [NSFont fontWithName:@"CONSOLAS" size:14.0];
    NSColor* color = [NSColor colorWithDeviceRed:(3.0*16.0+4.0)/255.0 green:(14.0*16.0+15.0)/255.0 blue:(2.0*16.0+8.0)/255.0 alpha:1.0 ];
    
    
    NSString* n = (botContainer.name.length > 0? botContainer.name:botContainer.urlToBot.lastPathComponent);
    [name setStringValue: n];
    
    [team setStringValue: [NSString stringWithFormat:@"Team %d",botContainer.team]];
    [colorPicker setColor: botContainer.color];
    
    [team setFont:font];
    [team setTextColor:color];
    [name setFont:font];
    [name setTextColor:color];
    
    
    variableAddresses = [NSMutableArray array];
    variableNames = [NSMutableArray array];
    NSMutableArray* vars = [NSMutableArray arrayWithArray:[botContainer.robot.userVariables allValues]];
    NSArray* sortedVars = [vars sortedArrayUsingComparator:^NSComparisonResult(NSObject<UserVariableProtocol>* ob1, NSObject<UserVariableProtocol>* ob2){
        return [[NSNumber numberWithInt:ob1.location] compare:[NSNumber numberWithInt:ob2.location]];
    }];
        
    
    for (NSObject<UserVariableProtocol>* var in sortedVars) {
        
        NSString* vname = var.name;
        for (int i = 0; i < var.size; i++) {
            [variableAddresses addObject:[NSNumber numberWithInt:var.location+i]];
            [variableNames addObject:vname];
            vname = @"";
        }
        
    }
    variableCells = [NSMutableDictionary dictionary];
    
    [variables reloadData];
    [debuggerWindow setTitle:[NSString stringWithFormat:@"%@ Debugger",n]];
}

-(void) refreshUI {
    if (botContainer.robot.isAlive || markedAsDead != !botContainer.robot.isAlive) {
        markedAsDead = !botContainer.robot.isAlive;
        [self refreshRegisters];
        [self refreshNamedMemory];
        [self refreshSourceCode];
        [self refreshVariables];
    }
    
}

-(void) refreshVariables {
    /*NSFont* font = [NSFont fontWithName:@"CONSOLAS" size:14.0];
    NSColor* color = [NSColor colorWithDeviceRed:(3.0*16.0+4.0)/255.0 green:(14.0*16.0+15.0)/255.0 blue:(2.0*16.0+8.0)/255.0 alpha:1.0 ];

    for (int i = 0; i < [variableAddresses count]; i++) {
        NSTextField* v =  [variableCells objectForKey:[NSNumber numberWithInt:i]];
        int addr = [[variableAddresses objectAtIndex:i] intValue];
        NSString* n = [variableNames objectAtIndex:i];
        int value = [botContainer.robot getMemory:addr];
        
        NSString* text = [NSString stringWithFormat:@"%08X %@ %08X",addr, sizeTo10(n), value];
        
        [v setStringValue:text];
        [v setFont:font];
        [v setTextColor: color];
        [v setNeedsDisplay:YES];
    }*/
    [variables setNeedsDisplay:YES];
    [variables reloadData];
}

-(void) refreshRegisters {
    NSObject<RobotDescription>* b = botContainer.robot;
    int* memory = botContainer.robot.memory;
    NSMutableString* rs = [NSMutableString stringWithString:@""];
    [rs appendFormat:@"AX: %08X  BX: %08X\n",memory[0],memory[1]];
    [rs appendFormat:@"CX: %08X  DX: %08X\n",memory[2],memory[3]];
    [rs appendFormat:@"EX: %08X  FX: %08X\n",memory[4],memory[5]];
    [rs appendFormat:@"IP: %08X  SP: %08X\n",memory[8],memory[7]];
    [rs appendFormat:@"       CmpResult: %08X\n",memory[6]];
    [rs appendFormat:@"         LoopCtr: %08X\n",memory[9]];
    [rs appendFormat:@"\n"];
    [rs appendFormat:@"\n"];
    
    [rs appendFormat:@"WEAP:%d SCAN:%d ARMR:%d ENG:%d\n",b.config_weapon,b.config_scanner,b.config_armor,b.config_engine];
    [rs appendFormat:@"HEAT:%d MINE:%d SHLD:%d",b.config_heatsinks,b.config_mines,b.config_shield];
    




    
    [registers setString:rs];
}

-(void) refreshNamedMemory {
    NSObject<RobotDescription>* b = botContainer.robot;
    NSMutableString* rs = [NSMutableString stringWithString:@""];
    [rs appendFormat:@"Armor     : %3d    Temperature: %3d\n",[b armor],[b heat]];
    [rs appendFormat:@"ScanArc   : %3d    \n",[b scan_arc_width]];
    [rs appendFormat:@"X         : %-4d             Y: %-4d\n",[b x],[b y]];
    [rs appendFormat:@"Throttle  : %3d          Speed: %1.2f (%d%%)\n",[b throttle],((float)[b speedInCM])/100.0,[b speed_in_terms_of_throttle]];
    [rs appendFormat:@"DesirdHead: %3d        Heading: %3d\n",[b desiredHeading],[b heading]];
    [rs appendFormat:@"TurretHead: %3d\n" ,[b turretHeading]];
    [rs appendFormat:@"Shield    : %@      OverDrive: %@\n",([b shieldOn]?@"ON ":@"OFF"),([b overburnOn]?@"ON ":@"OFF")];
    [rs appendFormat:@"Mines Left: %3d\n",[b numberOfMinesRemaining]];
    [rs appendFormat:@"Collisions:%4d       Odometer: %d\n",[b number_of_collisions],[b odometer]];
    [rs appendFormat:@"Time Since Detection: %@",(b.hasEverBeenDetected?[NSString stringWithFormat:@"%d",[b timeSinceDetection]]:@"Never")];

    [namedMemoryLocations setString:rs];
    
}

-(void) refreshSourceCode {
    
    int prefixLines = 5;
    int postfixLines = 5;
    NSObject<RobotDescription>* b = botContainer.robot;
    int* memory = b.memory;
    NSMutableArray* source = [NSMutableArray array];
    for (int prelines = 0, ip = memory[8]; prelines < prefixLines; ip-=3) {
        NSArray* lines = [b disassembledSourceAtAddress:ip];
        for (int i =(int) lines.count-1;prelines < prefixLines && i >=0  ; i--,prelines++) {
            [source insertObject:[lines objectAtIndex:i] atIndex:0];
        }
    }
    for (int postlines = 0, ip = memory[8]+3; postlines < postfixLines; ip+=3) {
        NSArray* lines = [b disassembledSourceAtAddress:ip];
        for (int i =0;postlines < postfixLines && i < lines.count  ; i++,postlines++) {
            [source addObject:[lines objectAtIndex:i]];
        }
    }
    NSString* str = [source componentsJoinedByString:@"\n"];
    [sourceCode setString:str];
}
-(void) setFonts {
    NSFont* font = [NSFont fontWithName:@"CONSOLAS" size:14.0];
    NSColor* color = [NSColor colorWithDeviceRed:(3.0*16.0+4.0)/255.0 green:(14.0*16.0+15.0)/255.0 blue:(2.0*16.0+8.0)/255.0 alpha:1.0 ];
    [registers setFont:font];
    [registers setTextColor:color];
    [namedMemoryLocations setFont:font];
    [namedMemoryLocations setTextColor:color];
    [sourceCode setFont:font];
    [sourceCode setTextColor:color];
}

-(id) initWithBotContainer:(BotContainer*)bc andBattleDocumentContriller:(BattleDocumentViewController*) controller {
    if (self = [super initWithNibName:@"DebuggerWindowController" bundle:nil]) {
        [[self debuggerWindow] setTitle:bc.name];
        battleController = controller;
        botContainer = bc;
        [self view];
        [self setFonts];
        [self refreshUI];
        [debuggerWindow setLevel:2];
        [self makeViewBlack:titleView];
        [self makeViewBlack:view1];
        [self makeViewBlack:view2];
        [self makeViewBlack:view3];
        [self refreshForRecompile];
        [variables setBackgroundColor:[NSColor blackColor]];
    }
    return self;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 14;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [variableAddresses count];
}

NSString* sizeTo10(NSString* s) {
    if (s.length >= 10) {
        return [s substringToIndex:10];
    } else {
        NSMutableString* t = [NSMutableString stringWithString:@""];
        while (t.length+s.length < 10 ) {
            [t appendString:@" "];
        }
        return [t stringByAppendingString:s];
    }
}

-(NSTextField*) variableCell:(NSInteger) row {
    
    
    NSFont* font = [NSFont fontWithName:@"CONSOLAS" size:14.0];
    NSColor* color = [NSColor colorWithDeviceRed:(3.0*16.0+4.0)/255.0 green:(14.0*16.0+15.0)/255.0 blue:(2.0*16.0+8.0)/255.0 alpha:1.0 ];

    NSTextField* v = [[NSTextField alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    [v setEditable:NO];
    
    [v setBordered:NO];

    [v setFont:font];
    [v setTextColor:color];
    [v setBackgroundColor:[NSColor blackColor]];
    
    return v;
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    id key = [NSString stringWithFormat:@"%ld",row];
    NSTextField* cell = [variableCells objectForKey:key];
    if (!cell) {
        cell = [self variableCell:row];
        [variableCells setObject:cell forKey:key];
    }
    
    int addr = [[variableAddresses objectAtIndex:row] intValue];
    NSString* n = [variableNames objectAtIndex:row];
    int value = [botContainer.robot getMemory:addr];
    
    NSString* text = [NSString stringWithFormat:@"%08X %@ %08X",addr, sizeTo10(n), value];
    [cell setStringValue:text];

    
    return cell;
}

@end
