//
//  BattleDocumentViewController+UserInterface.h
//  bot
//
//  Created by Christopher Lipa on 8/4/12.
//
//

#import "BattleDocumentViewController.h"

@interface BattleDocumentViewController (UserInterface)
-(void) setGameCycleTimeout:(int) number;
-(int) gameCycleTimeout;
-(int) numberOfMatches;
-(void) setNumberOfMatches:(int) number;
-(void) refreshView;
-(void) refreshViewForStartBattle ;
-(void) refreshViewForEndBattle ;
-(void) refreshForMatch ;
-(void) refreshUIForGameCycle ;
-(void) enableUIButtons;
-(void) disableUIButtons;
-(void) forceUpdateOfUIForGameCycle;
@end

