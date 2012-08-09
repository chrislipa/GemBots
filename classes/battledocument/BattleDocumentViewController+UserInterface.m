//
//  BattleDocumentViewController+UserInterface.m
//  bot
//
//  Created by Christopher Lipa on 8/4/12.
//
//

#import "BattleDocumentViewController+UserInterface.h"
#import "TimeLimit.h"
#import "RobotCellViewController.h"
@implementation BattleDocumentViewController (UserInterface)
-(void) setGameCycleTimeout:(int) number {
    
}

-(int) gameCycleTimeout {
    return timeLimit.cycles;
}
-(int) numberOfMatches {
    return numberOfMatches;
}
-(void) setNumberOfMatches:(int) number {
   
}


-(void) refreshView {
    [self refreshWeighClassPicker];
    [self refreshTimeLimitPicker];
    [self refreshNumberOfMatches];
}

-(void) refreshNumberOfMatches {
    [numberOfMatchesField setStringValue:[NSString stringWithFormat:@"%d",numberOfMatches]];
}

-(void) refreshWeighClassPicker {
    [weightClassPicker removeAllItems];
    
    for (WeightClass* w in [WeightClass standardWeightClasses]){
        [weightClassPicker addItemWithTitle:w.longStringDescription];
    }
    if (weightClass) {
        [weightClassPicker selectItemWithTitle:weightClass.longStringDescription];
    }
}
-(void) refreshTimeLimitPicker {
    [gameCycleTimeOutPicker removeAllItems];
    for (TimeLimit* t in [TimeLimit standardTimeLimits]) {
        [gameCycleTimeOutPicker addItemWithTitle:t.longStringDescription];
    }
    if (timeLimit) {
        [gameCycleTimeOutPicker selectItemWithTitle:timeLimit.longStringDescription];
    }
}

-(void) refreshViewForStartBattle {
    for (NSNumber* n in robotCellViewControllers) {
        RobotCellViewController* c = [robotCellViewControllers objectForKey:n];
        [c notifyOfBattleStarting];
    }
    [startStopButtonCell setTitle:@"Stop!"];
    

    [matchesDenominatorCell setStringValue:(numberOfMatches>0?[NSString stringWithFormat:@"%d", numberOfMatches]:@"")];
    [gameCycleDenominatorCell setStringValue:(timeLimit.cycles>0?[NSString stringWithFormat:@"%d", timeLimit.cycles]:@"")];
    
    
}


-(void) refreshViewForEndBattle {
    for (NSNumber* n in robotCellViewControllers) {
        RobotCellViewController* c = [robotCellViewControllers objectForKey:n];
        [c notifyOfBattleEnding];
    }
    [startStopButtonCell setTitle:@"Start!"];
}

-(void) refreshUIForGameCycle {
    
    if (engine.gameCycle % 10 == 0 || gameCycleShown == 0 || gameCycleShown > engine.gameCycle) {
        gameCycleShown = engine.gameCycle;
        [gameCycleNumeratorCell setStringValue:[NSString stringWithFormat:@"%d",engine.gameCycle]];
    }
}
-(void) refreshForMatch {
    if (matchShown == 0 || matchShown != engine.currentMatch) {
            [matchesNumeratorCell setStringValue:[NSString stringWithFormat:@"%d",engine.currentMatch]];
        matchShown = engine.currentMatch;
    }

    
}


@end
