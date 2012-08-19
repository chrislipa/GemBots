//
//  LicenseViewController.m
//  Gem Bots
//
//  Created by Christopher Lipa on 8/18/12.
//
//

#import "LicenseViewController.h"

@interface LicenseViewController ()

@end

@implementation LicenseViewController
@synthesize licenseWindow;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


-(void) awakeFromNib {

    NSURL* url = [[NSBundle mainBundle] URLForResource:@"LICENSE" withExtension:@"md"];
    
    NSString* string = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    [text setString:string];
}

@end
