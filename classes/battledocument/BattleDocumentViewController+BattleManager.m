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
#import "DebuggerWindowController.h"
#import "DebuggerWindow.h"
@implementation BattleDocumentViewController (BattleManager)


-(void) runRequestedFromEditor {
    if (battleState != nobattle) {
        [self stopBattleLoop];
    }
    if (![self readyToStartBattle]) {
        return;
    } else {
        [self startBattle];
        [self startBattleLoop];
        [self setBattleState:runningbattle];
    }
    
}
-(void)  stopButtonCallbackInternal {
    switch (battleState) {
        case nobattle:
            
            break;
        case runningbattle:
            [self stopBattleLoop];
            [self setBattleState:nobattle];
            break;
        case pausedbattle:
            [self stopBattleLoop];
            [self setBattleState:nobattle];
            break;
        default:
            break;
    }
}
-(void) stepButtonCallbackInternal {
    switch (battleState) {
        case nobattle:
            if (![self readyToStartBattle]) {
                return;
            } else {
                [self setBattleState:pausedbattle];
                [self startBattle];
                [self battleStepManual];
                [self forceUpdateOfUIForGameCycle];
            }
            break;
        case runningbattle:
            [self pauseBattle];
            [self setBattleState:pausedbattle];
            [self battleStepManual];
            [self forceUpdateOfUIForGameCycle];
            break;
        case pausedbattle:
            [self battleStepManual];
            [self forceUpdateOfUIForGameCycle];
            break;
        default:
            break;
    }

}
-(void) playPauseButtonCallbackInternal {
    switch (battleState) {
        case nobattle:
            if (![self readyToStartBattle]) {
                return;
            } else {
                [self startBattle];
                [self startBattleLoop];
                [self setBattleState:runningbattle];
            }
            break;
        case runningbattle:
            [self pauseBattle];
            [self setBattleState:pausedbattle];
            break;
        case pausedbattle:
            [self startBattleLoop];
            [self setBattleState:runningbattle];
            break;
        default:
            break;
    }
}

-(void) setBattleState:(BattleState) newBattleState {
    battleState = newBattleState;
    [stopButton setEnabled:(battleState == runningbattle) || (battleState == pausedbattle) ];
    [stepButton setEnabled:YES];
    [playPauseButton setEnabled:YES];
    if (battleState == runningbattle) {
        [playPauseButton setImage:pauseButtonImage];
        [playPauseButton setToolTip:@"Pause (P)"];
    } else {
        [playPauseButton setImage:playButtonImage];
        [playPauseButton setToolTip:@"Play (P)"];
    }
}



-(void) setStartRunError:(NSString*) s {
    [startError setStringValue:s];
    CALayer *layer = [startErrorField layer];
    if (s.length == 0) {
        [layer setBackgroundColor:(__bridge CGColorRef)([NSColor clearColor])];
    } else {
        CABasicAnimation *anime = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        anime.fromValue = (__bridge id)(CGColorCreateGenericRGB(1.0, 1.0, 0.0, 1.0));
        anime.toValue = (__bridge id)(CGColorCreateGenericRGB(1.0, 1.0, 0.0, 0.0));
        anime.duration = 0.5f;
        anime.autoreverses = NO;
        [layer addAnimation:anime forKey:@"backgroundColor"];
    }
}


-(bool) readyToStartBattle {
    if (battleCurrentlyInProgress) {
        return NO;
    }
    int foundTeam = -1;
    bool foundTwoTeams = NO;
    
    
    
    
    for(BotContainer* bot in robots) {
        if  (!bot.robot.compiledCorrectly) {
            
            [self setStartRunError:[NSString stringWithFormat:@"%@ did not compile.", (bot.name.length>0?bot.name:bot.urlToBot.lastPathComponent) ]];
            return NO;
        }
        if  (weightClass.loc > 0 && bot.linesOfCode > weightClass.loc) {
            [self setStartRunError:[NSString stringWithFormat:@"%@ has too many LOC.", (bot.name.length>0?bot.name:bot.urlToBot.lastPathComponent) ]];
            return NO;
        }
        if (foundTeam == -1) {
            foundTeam = bot.team;
        } else if (bot.team != foundTeam) {
            foundTwoTeams = YES;
        }
    }
    if (robots.count <= 1) {
        [self setStartRunError:@"At least two robots required to play."];
        return NO;
    }
    if (!foundTwoTeams) {
        [self setStartRunError:@"At least two teams required to play."];
        return NO;
    }
    [self setStartRunError:@""];
    return YES;
}


-(IBAction) startBattleCallback:(id)sender {
    
}



-(void) startBattle {
    battleOngoing = YES;
    [self setUpTeamsAndColors];
    
    
    
    [self setUpEngine];
    [self refreshViewForStartBattle];
    [matchesNumeratorCell setStringValue:[NSString stringWithFormat:@"%d",engine.currentMatch]];
    [self forceUpdateOfUIForGameCycle];
}


-(void) endBattle {
    battleOngoing = NO;
    battleCurrentlyInProgress = NO;
    for (RobotCellViewController* c in robotCellViewControllers) {
        [c notifyOfBattleEnding];
    }
    [self forceUpdateOfUIForGameCycle];
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
    [self forceUpdateOfUIForGameCycle];
    
    if (battleState == runningbattle) {
        [gameTimer invalidate];
        
        gameTimer = [NSTimer scheduledTimerWithTimeInterval:delayBetweenGameCycles
                                                     target:self
                                                   selector:@selector(battleStep:)
                                                   userInfo:nil
                                                    repeats:YES];
    }
    }
    

-(void) pauseBattle {
    [self forceUpdateOfUIForGameCycle];
    [gameTimer invalidate];
    gameTimer = nil;
}

-(void) resumeBattle {
    [self forceUpdateOfUIForGameCycle];
    [self createNewTimer];
}

-(void) stopBattleLoop {
    [self forceUpdateOfUIForGameCycle];
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
    for (id key in debuggerWindows) {
        DebuggerWindowController* debuggerWindow = [debuggerWindows objectForKey:key];
        [debuggerWindow refreshUI];
    }
    
    [self refreshUIForGameCycle];
}

-(void) battleStepManual {
    NSArray* debuggedBots = [debuggerWindows allKeys];
    if ([debuggedBots count]==0) {
        debuggedBots = nil;
    }
    [self battleStepRobots:debuggedBots];
}


-(void) battleStep:(NSTimer*) timer {
    [self battleStepRobots:nil];
}

-(void) battleStepRobots:(NSArray*) robotsToStep {
    [engine stepGameCycle:robotsToStep];
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
        [audio playMissileFireSound: missiles_fired : delayBetweenGameCycles ];
        [audio playMissileExplodeSound: missile_explosions : delayBetweenGameCycles ];
        
        
    }
    
    
    [self refreshUI];
    
    if (arenaView.gameStateDescriptor.isSetOfMatchesCompleted) {
        [self setBattleState:nobattle];
        [self stopBattleLoop];
    }
    
    if  (flagToCreateNewTimer) {
        [self createNewTimer];
    }
    if (currentGameStateDescription.gameCycle == 0) {
        
        
        for (NSNumber* n in robotCellViewControllers) {
            RobotCellViewController* c = [robotCellViewControllers objectForKey:n];
            [c.cell refreshColor];
        }
    }
}





@end
