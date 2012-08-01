//
//  PGBotNativeEngine+CheckForStartNextMatch.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 8/1/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "PGBotNativeEngine+CheckForStartNextMatch.h"
#import "GemBot.h"
#import "GemBot+Interface.h"
#import "GemBot+Runtime.h"
@implementation PGBotNativeEngine (CheckForStartNextMatch)

-(void) checkForStartNextMatchPhase {
    if (isMatchCurrentlyActive) {
        return;
    }
    if (currentMatch >= totalNumberOfMatches) {
        return;
    }
    [self startNextMatch];
}


-(void) startNextMatch {
    isMatchCurrentlyActive = YES;
    currentMatch++;
    for (GemBot* bot in robots) {
        []
    }
    
    
}
@end
