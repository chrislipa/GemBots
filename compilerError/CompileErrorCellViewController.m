//
//  CompilerErrorCellViewController.m
//  bot
//
//  Created by Christopher Lipa on 8/4/12.
//
//

#import "CompileErrorCellViewController.h"


@implementation CompileErrorCellViewController
@synthesize compileError;
-(id) initWithCompileError:( NSObject<CompileErrorProtocol>* )pcompilerError
{
    self = [super initWithNibName:@"CompileErrorCellViewController" bundle:nil];
    if (self) {
        compileError = pcompilerError;
        [self view];
        [self refresh];
    }
    
    return self;
}
-(void) viewDidLoad {
    [self refresh];
}
-(void) refresh {
    [textField setStringValue:[compileError text]];
}

@end
