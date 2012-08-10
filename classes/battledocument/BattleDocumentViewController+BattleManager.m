//
//  BattleDocumentViewController+BattleManager.m
//  bot
//
//  Created by Christopher Lipa on 8/4/12.
//
//

#import "BattleDocumentViewController+BattleManager.h"
#import "BotContainer.h"
#import "GameStateDescriptor.h"
#import "BattleDocumentViewController+UserInterface.h"
#import "BattleDocumentViewController+Draw.h"
#import "RobotCellViewController.h"
#import "BattleDocumentViewController+UserInterface.h"
#import "ArenaView.h"
@implementation BattleDocumentViewController (BattleManager)






-(bool) readyToStartBattle {
    if (battleCurrentlyInProgress) {
        return NO;
    }
    int foundTeam = -1;
    bool foundTwoTeams = NO;
    for(BotContainer* bot in robots) {
        if  (!bot.robot.compiledCorrectly) {
            
            return NO;
        }
        if  (weightClass.loc > 0 && bot.linesOfCode > weightClass.loc) {
            return NO;
        }
        if (foundTeam == -1) {
            foundTeam = bot.team;
        } else if (bot.team != foundTeam) {
            foundTwoTeams = YES;
        }
    }
    if (!foundTwoTeams) {
        return NO;
    }
    return YES;
}


-(IBAction) startBattleCallback:(id)sender {
    if (battleCurrentlyInProgress) {
        [self stopBattleLoop];
    } else {
        if (![self readyToStartBattle]) {
            return;
        } else {
            [self startBattle];
        }
    }
}



-(void) startBattle {
    [self setUpTeamsAndColors];
    [self refreshViewForStartBattle];
    
    
    [self setUpEngine];
    [matchesNumeratorCell setStringValue:[NSString stringWithFormat:@"%d",engine.currentMatch]];
    [self startBattleLoop];
}


-(void) endBattle {
    for (RobotCellViewController* c in robotCellViewControllers) {
        [c notifyOfBattleEnding];
    }
}


-(void) setUpTeamsAndColors {
    for (BotContainer* bot in robots) {
        bot.robot.team = bot.team;
        bot.robot.color = bot.color;
    }
}

-(void) setUpEngine {
    [engine setGameCycleTimeout:[self gameCycleTimeout]];
    [engine setNumberOfMatches:[self numberOfMatches]];
    [engine startNewSetOfMatches];
    
}

-(void) startBattleLoop {
    [self computeGameSpeedBasedOnSlider];
    flagToCreateNewTimer = NO;
    battleCurrentlyInProgress = YES;
    [gameTimer invalidate];
    
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:delayBetweenGameCycles
                                                target:self
                                              selector:@selector(battleStep:)
                                              userInfo:nil
                                               repeats:YES];
    
}


-(void) createNewTimer {
    flagToCreateNewTimer = NO;
    
    [gameTimer invalidate];
    
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:delayBetweenGameCycles
                                                 target:self
                                               selector:@selector(battleStep:)
                                               userInfo:nil
                                                repeats:YES];
}

-(void) notifyOfGameSpeedChange {
    [gameTimer invalidate];
    
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:delayBetweenGameCycles
                                                 target:self
                                               selector:@selector(battleStep:)
                                               userInfo:nil
                                                repeats:YES];
}

-(void) stopBattleLoop {
    battleCurrentlyInProgress = NO;
    [self refreshViewForEndBattle];
    [gameTimer invalidate];
    gameTimer = nil;
}

-(void) refreshUI {
    for (NSNumber* n in robotCellViewControllers) {
        RobotCellViewController* c = [robotCellViewControllers objectForKey:n];
        if (![engine isMatchCurrentlyActive]) {
            [c refreshForMatch];
        }
        [c refreshForGameCycle];
    }
    [self refreshUIForGameCycle];
    
    if (![engine isMatchCurrentlyActive]) {
        [self refreshForMatch];
    }
    
}

-(void) battleStep:(NSTimer*) timer {
   
    
    [engine stepGameCycle];
    
    if (graphicsEnabled) {
        currentGameStateDescription = [engine currentGameStateDescription];
        arenaView.gameStateDescriptor = currentGameStateDescription;
        [arenaView setNeedsDisplay:YES];
    }
    
    
    
    [self refreshUI];
    
    if (arenaView.gameStateDescriptor.isSetOfMatchesCompleted) {
        [self stopBattleLoop];
    }
    
    if  (flagToCreateNewTimer) {
        [self createNewTimer];
    }
}





@end
