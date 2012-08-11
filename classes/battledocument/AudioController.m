//
//  AudioController.m
//  Gem Bots
//
//  Created by Christopher Lipa on 8/11/12.
//
//

#import "AudioController.h"
#if !defined(__COREAUDIO_USE_FLAT_INCLUDES__)
#include <CoreAudio/CoreAudioTypes.h>
#include <CoreFoundation/CoreFoundation.h>
#else
#include <CoreAudioTypes.h>
#include <CoreFoundation.h>
#endif
#import <CoreAudio/CoreAudio.h>
#import <AVFoundation/AVFoundation.h>

#include <AudioToolbox/AudioUnitUtilities.h>

@implementation AudioController
-(id) init {
    if (self = [super init]) {
        laserSoundEffects = [NSMutableArray array];
        for (int i = 0; i < 6; i++) {
            NSURL* url = [[NSBundle mainBundle] URLForResource:@"laser3-lipa-modified" withExtension:@"mp3"];
            
            AVAudioPlayer* s = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
            [s prepareToPlay];
            [laserSoundEffects addObject:s];
            
        }
        explosionSoundEffects = [NSMutableArray array];
        for (int i = 0; i < 6; i++) {
            NSURL* url = [[NSBundle mainBundle] URLForResource:@"21410_21830-lq-short-lipa" withExtension:@"mp3"];
            
            AVAudioPlayer* s = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
            [s prepareToPlay];
            [explosionSoundEffects addObject:s];
            
        }
    }
    return self;
}

-(void) playMissileFireSound:(int) times :(double) timePeriod {
    for (int i = 0; i < times; i++) {
        AVAudioPlayer* a = [laserSoundEffects objectAtIndex:currentMissileFire];
        if ([a isPlaying]) {
            break;
        }
        currentMissileFire = (currentMissileFire + 1) % [laserSoundEffects count];
        double delay;
        delay = 0+ i * timePeriod / times;
        //delay = .10*i;
        [a playAtTime:a.deviceCurrentTime+delay];
    }
}
-(void) playMissileExplodeSound:(int) times :(double) timePeriod {
    
   
    for (int i = 0; i < times; i++) {
        AVAudioPlayer* a = [explosionSoundEffects objectAtIndex:currentExplosion];
        if ([a isPlaying]) {
            break;
        }
        currentExplosion = (currentExplosion + 1) % [explosionSoundEffects count];
        double delay;
        delay = 0+ i * timePeriod / times;
        //delay = .10*i;
        [a playAtTime:a.deviceCurrentTime+delay];
    }
}

@end
