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
    [self createInternalOrderingOfRobots];
    currentMatch++;
    gameCycle = 0;
    missiles = [NSMutableArray array];
    mines = [NSMutableArray array];
    [self resetAllRobotsForNextRound];
    [self giveRandomIDsToRobots];
    [self placeRobotsInRandomPositionsAndHeadings];
    isMatchCurrentlyActive = YES;
    isThisSetInitiated = YES;
}

-(void) createInternalOrderingOfRobots {
    NSArray* tmprobots = [externalOrderingOfRobots sortedArrayUsingSelector:@selector(source)];
    for (int i = 0; i < tmprobots.count; i++) {
        GemBot* a = [tmprobots objectAtIndex:i];
        bool match;
        do {
            match = NO;
            a.orderingInt = [random randomInt];
            for (int j = 0; j <i; j++) {
                if (a.orderingInt == ((GemBot*)[tmprobots objectAtIndex:j]).orderingInt) {
                    match = YES;
                }
            }
        } while(match);
    }
    robots = [NSMutableArray arrayWithArray:[tmprobots sortedArrayUsingSelector:@selector(orderingInt)]];
    for (int i =0; i < robots.count; i++) {
        ((GemBot*)[robots objectAtIndex:i]).order = i;
    }
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
            b.internal_position = positionWithInts(distanceToInternalDistance([random randomIntInInclusiveRange:0+ROBOT_RADIUS : SIZE_OF_ARENA-ROBOT_RADIUS]),
                                                   distanceToInternalDistance([random randomIntInInclusiveRange:0+ROBOT_RADIUS : SIZE_OF_ARENA-ROBOT_RADIUS]));
            
            for (int j = 0; j<i; j++) {
                if (internal_distance_between(b, [robots objectAtIndex:j]) < 2 * distanceToInternalDistance(ROBOT_RADIUS)) {
                    match = YES;
                }
            }
        } while (match);
        b.heading = [random randomIntInInclusiveRange:0 :255];
    }
}

-(void) giveCreditForWinsAndLosses {
    winnersOfLastMatch = [NSMutableArray array];
    for (GemBot* b in robots) {
        if (b.isAlive) {
            b.wins++;
            [winnersOfLastMatch addObject:b];
        } else {
            b.losses++;
        }
    }
}

@end
