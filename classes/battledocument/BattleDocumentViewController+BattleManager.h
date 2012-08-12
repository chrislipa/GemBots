//
//  BattleDocumentViewController+BattleManager.h
//  bot
//
//  Created by Christopher Lipa on 8/4/12.
//
//

#import "BattleDocumentViewController.h"

@interface BattleDocumentViewController (BattleManager)

-(IBAction) startBattleCallback:(id)sender;
-(void) notifyOfGameSpeedChange ;
-(void) setStartRunError:(NSString*) s;
-(void)  stopButtonCallbackInternal ;
-(void) stepButtonCallbackInternal;
-(void) playPauseButtonCallbackInternal ;
-(void) setBattleState:(BattleState) newBattleState;
-(void) runRequestedFromEditor;
@end
