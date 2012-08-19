//
//  LicenseViewController.h
//  Gem Bots
//
//  Created by Christopher Lipa on 8/18/12.
//
//

#import <Cocoa/Cocoa.h>
#import "LicenseWIndow.h"
@interface LicenseViewController : NSViewController {
    IBOutlet NSTextView* text;
    IBOutlet LicenseWindow* licenseWindow;

}
@property (readonly) LicenseWindow* licenseWindow;
@end
