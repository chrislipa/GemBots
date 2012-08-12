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

-(void) refreshUI {
    [self refreshRegisters];
    [self refreshNamedMemory];
}

-(void) refreshRegisters {
    int* memory = botContainer.robot.memory;
    NSMutableString* rs = [NSMutableString stringWithString:@""];
    [rs appendFormat:@"AX: %08X  BX: %08X\n",memory[0],memory[1]];
    [rs appendFormat:@"CX: %08X  DX: %08X\n",memory[2],memory[3]];
    [rs appendFormat:@"EX: %08X  FX: %08X\n",memory[4],memory[5]];
    [rs appendFormat:@"IP: %08X  SP: %08X\n",memory[8],memory[7]];
    [rs appendFormat:@"       CmpResult: %08X\n",memory[6]];
    [rs appendFormat:@"         LoopCtr: %08X\n",memory[9]];
    [registers setString:rs];
}

-(void) refreshNamedMemory {
    int* memory = botContainer.robot.memory;
    NSObject<RobotDescription>* b = botContainer.robot;
    NSMutableString* rs = [NSMutableString stringWithString:@""];
    [rs appendFormat:@"Armor     : %3d    Temp: %3d\n",[b armor],[b heat]];
    [rs appendFormat:@"ScanArc   : %3d    \n",[b scan_arc_width]];
    [rs appendFormat:@"Throttle  : %3d   Speed: %1.2f (%d%%)\n",[b throttle],((float)[b speedInCM])/100.0,[b speed_in_terms_of_throttle]];
    [rs appendFormat:@"DesireHead: %3d    Head: %3d\n",[b desiredHeading],[b heading]];
    [rs appendFormat:@"TurretHead: %3d\n" ,[b turretHeading]];
    [rs appendFormat:@"Shield    : %@      OD: %@\n",([b shieldOn]?@"ON ":@"OFF"),([b overburnOn]?@"ON ":@"OFF")];
    [rs appendFormat:@"Collisions:%4d     Odo: %d",[b number_of_collisions],[b odometer]];
    
    [namedMemoryLocations setString:rs];
    
}


-(void) setFonts {
    NSFont* font = [NSFont fontWithName:@"CONSOLAS" size:14.0];
    NSColor* color = [NSColor colorWithDeviceRed:(3.0*16.0+4.0)/255.0 green:(14.0*16.0+15.0)/255.0 blue:(2.0*16.0+8.0)/255.0 alpha:1.0 ];
    [registers setFont:font];
    [registers setTextColor:color];
    [namedMemoryLocations setFont:font];
    [namedMemoryLocations setTextColor:color];
}

-(id) initWithBotContainer:(BotContainer*)bc andBattleDocumentContriller:(BattleDocumentViewController*) controller {
    if (self = [super initWithNibName:@"DebuggerWindowController" bundle:nil]) {
        [[self debuggerWindow] setTitle:bc.name];
        battleController = controller;
        botContainer = bc;
        [self view];
        [self setFonts];
        [self refreshUI];
        
    }
    return self;
}




@end
