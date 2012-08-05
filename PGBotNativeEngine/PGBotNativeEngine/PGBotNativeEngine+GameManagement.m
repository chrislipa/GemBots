//

//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/5/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine+GameManagement.h"
#import "GemBot.h"
#import "GemBot+Reset.h"
#import "EngineUtility.h"
@implementation PGBotNativeEngine (GameManagement)


-(void) startNewMatchInternal {
    currentMatch++;
    gameCycle = 0;
    missiles = [NSMutableArray array];
    [self resetAllRobotsForNextRound];
    [self giveRandomIDsToRobots];
    [self placeRobotsInRandomPositionsAndHeadings];
    isMatchCurrentlyActive = YES;
    isThisSetInitiated = YES;
    
    
}


-(void) resetAllRobotsForNextRound {
    for (GemBot* b in robots) {
        [b cleanBetweenRounds];
    }
}

-(void) giveRandomIDsToRobots {
    for (int i = 0; i < [robots count]; i ++ ) {
        int candidateID;
        bool match = NO;
        do {
            candidateID = [random randomInt];
            for (int j = 0; j<i; j++) {
                if ([[robots objectAtIndex:j] unique_tank_id] == candidateID) {
                    match = YES;
                }
            }
        } while (match);
        GemBot* b = [robots objectAtIndex:i];
        b.unique_tank_id = candidateID;
    }
}

-(void) placeRobotsInRandomPositionsAndHeadings {
    for (int i = 0; i < [robots count]; i ++ ) {
        bool match = NO;
        GemBot* b = [robots objectAtIndex:i];
        do {
            b.internal_position = positionWithInts([random randomIntInInclusiveRange:0+ROBOT_RADIUS : SIZE_OF_ARENA-ROBOT_RADIUS] ,
                                                   [random randomIntInInclusiveRange:0+ROBOT_RADIUS : SIZE_OF_ARENA-ROBOT_RADIUS] );
            
            for (int j = 0; j<i; j++) {
                if (distance_between(b, [robots objectAtIndex:j]) < 2 * ROBOT_RADIUS) {
                    match = YES;
                }
            }
        } while (match);
        b.heading = [random randomIntInInclusiveRange:0 :255];
    }
}

-(void) giveCreditForWinsAndLoses {
    winnersOfLastMatch = [NSMutableArray array];
    for (GemBot* b in robots) {
        if (b.isAlive) {
            b.wins++;
            [winnersOfLastMatch addObject:b];
        } else {
            b.loses++;
        }
    }
}

@end
