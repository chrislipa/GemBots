//
//  AboutWindowViewController.h
//  Gem Bots
//
//  Created by Christopher Lipa on 8/18/12.
//
//

#import <Cocoa/Cocoa.h>

@interface AboutWindowViewController : NSViewController {
    IBOutlet NSWindow* aboutWindow;
    IBOutlet NSView* view2;
    IBOutlet NSTextFieldCell* version;
    IBOutlet NSTextFieldCell* gitcommit;
    IBOutlet NSTextView* link;
}
@property (readonly) NSWindow* aboutWindow;


-(IBAction) acknowledgementsCallback:(id)sender;
-(IBAction) licenseCallback:(id)sender;
-(IBAction) helpCallback:(id)sender;
@end
