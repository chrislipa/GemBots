//
//  MasterController.m
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//

#import "MasterController.h"
#import "BattleDocument.h"
#import "BattleDocumentViewController.h"
@implementation MasterController


- (void)awakeFromNib {
    NSError* error;
    
    [[NSDocumentController sharedDocumentController] openUntitledDocumentAndDisplay: YES error: &error];
        
}

@end
