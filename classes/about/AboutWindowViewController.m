//
//  AboutWindowViewController.m
//  Gem Bots
//
//  Created by Christopher Lipa on 8/18/12.
//
//

#import "AboutWindowViewController.h"
#import "NSAttributedString+Link.h"
#import "MasterController.h"

@interface AboutWindowViewController ()

@end

@implementation AboutWindowViewController
@synthesize aboutWindow;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    
    return self;
}


-(void) awakeFromNib {
    CGColorRef colorRef = CGColorCreateGenericRGB(1.0, 1.0, 1.0, 1.0);
    CALayer *viewLayer = [CALayer layer];
    [viewLayer setBackgroundColor:colorRef];
    [view2 setWantsLayer:YES];
    [view2 setLayer:viewLayer];
    
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString* v = [infoDict objectForKey:@"CFBundleShortVersionString"];
    
    [version setStringValue:[NSString stringWithFormat:@"Version %@",v]];
    
    NSString *resourcesPath = [[NSBundle mainBundle] resourcePath];
    NSString* pathToGitCommit = [resourcesPath stringByAppendingPathComponent:@"gitcommit.txt"];
    NSString* gitCommitSha = [NSString stringWithContentsOfFile:pathToGitCommit encoding:NSUTF8StringEncoding error:nil];
    
    [gitcommit setStringValue:[NSString stringWithFormat:@"Build %@",[gitCommitSha substringToIndex:6]]];
    
    
    //[link setAllowsEditingTextAttributes: YES];
    [link setSelectable: YES];
    
    NSString* li = @"https://github.com/chrislipa/GemBots";
    NSAttributedString* l = [NSAttributedString hyperlinkFromString:li withURL:[[NSURL alloc] initWithString:li] ];

    [[link textStorage] setAttributedString:l];
    
}

-(IBAction) acknowledgementsCallback:(id)sender {
    [[MasterController singleton] displayAcknoledgementsWindow];
}
-(IBAction) licenseCallback:(id)sender {
     [[MasterController singleton] displayLicenseWindow];
}

-(IBAction) helpCallback:(id)sender {
    [[MasterController singleton] gemBotsHelp:sender];
}
@end
