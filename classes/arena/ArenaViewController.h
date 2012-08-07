//
//  ArenaViewController.h
//  bot
//
//  Created by Christopher Lipa on 7/29/12.
//
//

#import <Cocoa/Cocoa.h>

@interface ArenaViewController : NSViewController {
    
    NSMutableArray* robotPositions;
    NSMutableArray* misslePositions;
    NSMutableArray* scannerPositions;
    NSMutableArray* sonarPositions;
    NSMutableArray* explosionPositions;
}


@property (readonly) NSMutableArray* robotPositions;
@property (readonly) NSMutableArray* misslePositions;
@property (readonly) NSMutableArray* scannerPositions;
@property (readonly) NSMutableArray* sonarPositions;
@property (readonly) NSMutableArray* explosionPositions;


@end
