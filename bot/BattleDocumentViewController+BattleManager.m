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
    if (![self readyToStartBattle]) {
        return;
    } else {
        [self startBattle];
    }
}



-(void) startBattle {
    [self setUpTeamsAndColors];
    [self setUpEngine];
    [self startBattleLoop];
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
    battleCurrentlyInProgress = YES;
    [gameTimer invalidate];
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:0
                                                target:self
                                              selector:@selector(battleStep:)
                                              userInfo:nil
                                               repeats:YES];
    
}

-(void) stopBattleLoop {
    [gameTimer invalidate];
    gameTimer = nil;
}

-(void) battleStep:(NSTimer*) timer {
    [engine stepGameCycle];
    currentGameStateDescription = [engine currentGameStateDescription];
    arenaView.gameStateDescriptor = currentGameStateDescription;
    [arenaView setNeedsDisplay:YES];
}





@end
