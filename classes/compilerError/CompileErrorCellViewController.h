//
//  CompilerErrorCellViewController.h
//  bot
//
//  Created by Christopher Lipa on 8/4/12.
//
//

#import <Cocoa/Cocoa.h>
#import "CompileErrorProtocol.h"
@interface CompileErrorCellViewController : NSViewController {
    NSObject<CompileErrorProtocol>* compileError;
    IBOutlet NSTextField* textField;
}

@property (readwrite,retain) NSObject<CompileErrorProtocol>* compileError;

-(id) initWithCompileError:( NSObject<CompileErrorProtocol>* )compileError;

@end
