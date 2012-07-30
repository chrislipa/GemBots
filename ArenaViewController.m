//
//  ArenaViewController.m
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//

#import "ArenaViewController.h"



@implementation ArenaViewController

@synthesize robotPositions;
@synthesize misslePositions;
@synthesize scannerPositions;
@synthesize sonarPositions;
@synthesize explosionPositions;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        robotPositions = [NSMutableArray array];
        misslePositions  = [NSMutableArray array];
        scannerPositions = [NSMutableArray array];
        sonarPositions  = [NSMutableArray array];
        explosionPositions = [NSMutableArray array];
    }
    
    return self;
}

@end
