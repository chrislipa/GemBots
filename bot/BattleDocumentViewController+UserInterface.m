//
//  BattleDocumentViewController+UserInterface.m
//  bot
//
//  Created by Christopher Lipa on 8/4/12.
//
//

#import "BattleDocumentViewController+UserInterface.h"

@implementation BattleDocumentViewController (UserInterface)
-(void) setGameCycleTimeout:(int) number {
    
}

-(int) gameCycleTimeout {
    return 0;
}
-(int) numberOfMatches {
    return 0;
}
-(void) setNumberOfMatches:(int) number {
   
}


-(void) refreshView {
    [self refreshWeighClassPicker];
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

@end
