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
#include <AudioToolbox/AudioToolbox.h>
#include <AudioToolbox/AudioUnitUtilities.h>
#import <Cocoa/Cocoa.h>
#import <AudioToolbox/AudioQueue.h>
#import <AudioToolbox/AudioFile.h>

//#include "PlayFileInterface.h"
static void callback(void *a, AudioQueueRef b, AudioQueueBufferRef c)
{

	AudioQueueStop(b, false);
    AudioQueueDispose(b, false);
}








const int numberOfBufffers = 1;
void playSoundEffect(NSString* name, float volume) {
    NSURL* url = [[NSBundle mainBundle] URLForResource:name withExtension:@"caf"];
    CFURLRef theURL = (__bridge CFURLRef)(url);
    AudioFileID audioFileID;
    OSStatus x1 = AudioFileOpenURL(theURL, 0x01, kAudioFileCAFType, &audioFileID);
    if  (x1) {
        AudioFileClose(audioFileID);
        return;
    }
    AudioQueueBufferRef	b[numberOfBufffers];
	AudioStreamBasicDescription dataFormat;
    UInt32 size = sizeof(dataFormat);
    OSStatus x2 = AudioFileGetProperty(audioFileID, kAudioFilePropertyDataFormat, &size, &dataFormat);
    if  (x2) {
        AudioFileClose(audioFileID);
        return;
    }
    AudioQueueRef audioQueue;
	OSStatus x3 = AudioQueueNewOutput(&dataFormat, callback, nil, nil, nil, 0, &audioQueue);
    if  (x3) {
        AudioFileClose(audioFileID);
        return;
    }
    UInt32 packs = 0x20000 / dataFormat.mBytesPerPacket;
    AudioStreamPacketDescription *audioStreamPacketDescription = nil;
	
    
    UInt32 ind = 0,n,s;
    for (int i = 0; i < numberOfBufffers; i++) {
		OSStatus x4 = AudioQueueAllocateBuffer(audioQueue, 0x60000, &b[i]);
        if  (x4) {
            AudioFileClose(audioFileID);
            return;
        }
        AudioQueueBufferRef bu = b[i];
        s = packs;
        OSStatus x5 = AudioFileReadPackets(audioFileID, NO, &n, audioStreamPacketDescription, ind, &s, bu->mAudioData);
        if  (x5) {
            AudioFileClose(audioFileID);
            return;
        }
        ind += s;
        if (s > 0) {
            bu->mAudioDataByteSize = n;
            OSStatus x6 = AudioQueueEnqueueBuffer(audioQueue, bu, (audioStreamPacketDescription ? s : 0), audioStreamPacketDescription);
            if  (x6) {
                AudioFileClose(audioFileID);
                return;
            }
        }
	}
	OSStatus x7 = AudioQueueSetParameter(audioQueue, kAudioQueueParam_Volume, volume);
    if  (x7) {
        AudioFileClose(audioFileID);
        return;
    }
    OSStatus x8 = AudioFileClose(audioFileID);
    if (x8) {
        return;
    }
    AudioQueueStart(audioQueue, nil);
    //return queue;
}

void playQueue(AudioQueueRef queue) {

    
}

@implementation AudioController
-(id) init {
    if (self = [super init]) {
        laserSoundEffects = [NSMutableArray array];
        
        for (int i = 0; i < 200; i++) {
            //AudioQueueRef ptr = loadSoundEffect(@"laser3-lipa-modified");
            //[laserSoundEffects addObject:[NSValue valueWithPointer:ptr ]];
            
        }
        explosionSoundEffects = [NSMutableArray array];
        for (int i = 0; i < 6; i++) {
            
            
        }
    }
    return self;
}

-(void) playMissileFireSound:(int) times :(double) timePeriod {
    for (int i = 0; i < times; i++) {
        playSoundEffect(@"laser3-lipa-modified",0.1);
        /*
        currentMissileFire = (currentMissileFire + 1) % [laserSoundEffects count];
        int old = (currentMissileFire + [laserSoundEffects count]/2) % [laserSoundEffects count];
        AudioQueueRef ptr  = [[laserSoundEffects objectAtIndex:currentMissileFire] pointerValue];
        AudioQueueRef oldptr  = [[laserSoundEffects objectAtIndex:old] pointerValue];
        playQueue(ptr);
        AudioQueueReset(oldptr);*/
        
    }
}
-(void) playMissileExplodeSound:(int) times :(double) timePeriod {
    
   
    for (int i = 0; i < times; i++) {
        
        /*
        AVAudioPlayer* a = [explosionSoundEffects objectAtIndex:currentExplosion];
        if ([a isPlaying]) {
            break;
        }
        currentExplosion = (currentExplosion + 1) % [explosionSoundEffects count];
        double delay;
        delay = 0+ i * timePeriod / times;
        //delay = .10*i;
        [a playAtTime:a.deviceCurrentTime+delay];*/
        
        playSoundEffect(@"21410_21830-lq-short-lipa",0.8);
    }
}

-(void) playBotExploded:(int) time :(double) timePeriod {
    if (time > 0) {
        playSoundEffect(@"76151_35187-lq",1.0);
        
    }
}


@end
