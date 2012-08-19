//
//  AudioController.h
//  Gem Bots
//
//  Created by Christopher Lipa on 8/11/12.
//
//

#import <Foundation/Foundation.h>

@interface AudioController : NSObject {
    
    NSMutableArray* laserSoundEffects;
    int currentMissileFire;
    
    NSMutableArray* explosionSoundEffects;
    int currentExplosion;
}

-(void) playMissileFireSound:(int) times :(double) timePeriod;
-(void) playMissileExplodeSound:(int) times :(double) timePeriod;
-(void) playBotExploded:(int) times :(double) timePeriod ;
@end
