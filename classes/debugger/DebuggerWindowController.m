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
    int* memory = botContainer.robot.memory;
    NSMutableString* rs = [NSMutableString stringWithString:@""];
    [rs appendFormat:@"AX: %08X\tBX: %08X\n  ",memory[0],memory[1]];
    [rs appendFormat:@"CX: %08X\tDX: %08X\n  ",memory[2],memory[3]];
    [rs appendFormat:@"EX: %08X\tFX: %08X\n  ",memory[4],memory[5]];
    [rs appendFormat:@"IP: %08X\tSP: %08X\n  ",memory[8],memory[7]];
    [rs appendFormat:@"CmpResult: %08X\n  ",memory[6]];
    [rs appendFormat:@"LoopCtr:   %08X\n  ",memory[8]];
    
    [registers setString:rs];
}

-(void) setFonts {
    [registers setFont:[NSFont fontWithName:@"CONSOLAS" size:14.0]];
    [registers setTextColor:[NSColor colorWithDeviceRed:(3.0*16.0+4.0)/255.0 green:(14.0*16.0+15.0)/255.0 blue:(2.0*16.0+8.0)/255.0 alpha:1.0 ]];
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
