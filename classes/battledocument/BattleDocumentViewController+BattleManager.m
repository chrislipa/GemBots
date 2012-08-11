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
#import <AVFoundation/AVFoundation.h>
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
    battleOngoing = YES;
    [self setUpTeamsAndColors];
    [self refreshViewForStartBattle];
    
    
    [self setUpEngine];
    [matchesNumeratorCell setStringValue:[NSString stringWithFormat:@"%d",engine.currentMatch]];
    [self startBattleLoop];
}


-(void) endBattle {
    battleOngoing = NO;
    battleCurrentlyInProgress = NO;
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
    [self disableUIButtons];
    [self computeGameSpeedBasedOnSlider];
    flagToCreateNewTimer = NO;
    battleCurrentlyInProgress = YES;
    [gameTimer invalidate];
    [self refreshUI];
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
    [self enableUIButtons];
    battleOngoing = NO;
    battleCurrentlyInProgress = NO;
    [self refreshViewForEndBattle];
    [gameTimer invalidate];
    gameTimer = nil;
}

-(void) refreshUI {
    if (![engine isMatchCurrentlyActive]) {
        [self refreshForMatch];
    }
    CFTimeInterval currentTime = CACurrentMediaTime();
    if (currentTime - lastTimeABufferSwapWasPerformed < 1.0/60.0) {
        return;
    }
    lastTimeABufferSwapWasPerformed = currentTime;
    for (NSNumber* n in robotCellViewControllers) {
        RobotCellViewController* c = [robotCellViewControllers objectForKey:n];
        if (![engine isMatchCurrentlyActive]) {
            [c refreshForMatch];
        }
        [c refreshForGameCycle];
    }
    [self refreshUIForGameCycle];
    
    
    
}

-(void) battleStep:(NSTimer*) timer {
   
    
    [engine stepGameCycle];
    currentGameStateDescription = [engine currentGameStateDescription];
    if (graphicsEnabled) {
        
        arenaView.gameStateDescriptor = currentGameStateDescription;
        [arenaView setNeedsDisplay:YES];
    }
    if  (soundEnabled) {
        int missiles_fired = 0;
        int missile_explosions = 0;
        for (NSString* se in currentGameStateDescription.soundEffectsInitiatedThisCycle) {
            if ([se isEqualTo:@"missile_fired"]) {
                missiles_fired++;
            } else if ([se isEqualTo:@"missile_exploded"]) {
                missile_explosions++;
            }
        }
        for (int i = 0; i < missiles_fired; i++) {
            AVAudioPlayer* a = [laserSoundEffects objectAtIndex:currentMissileFire];
            if ([a isPlaying]) {
                break;
            }
            currentMissileFire = (currentMissileFire + 1) % [laserSoundEffects count];
            double delay;
            delay = 0+ i * delayBetweenGameCycles / missiles_fired;
            //delay = .10*i;
            [a playAtTime:a.deviceCurrentTime+delay];
        }
        for (int i = 0; i < missile_explosions; i++) {
            AVAudioPlayer* a = [explosionSoundEffects objectAtIndex:currentExplosion];
            if ([a isPlaying]) {
                break;
            }
            currentExplosion = (currentExplosion + 1) % [explosionSoundEffects count];
            double delay;
            delay = 0+ i * delayBetweenGameCycles / missile_explosions;
            //delay = .10*i;
            [a playAtTime:a.deviceCurrentTime+delay];
        }
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
