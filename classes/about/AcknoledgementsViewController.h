//
//  AcknoledgementsViewController.h
//  Gem Bots
//
//  Created by Christopher Lipa on 8/18/12.
//
//

#import <Cocoa/Cocoa.h>
#import "AcknowledgementsWindow.h"
@interface AcknoledgementsViewController : NSViewController {
    IBOutlet NSTextView* text;
    IBOutlet AcknowledgementsWindow* acknowledgementsWindow;
}

@property (readonly) AcknowledgementsWindow* acknowledgementsWindow;
@end
