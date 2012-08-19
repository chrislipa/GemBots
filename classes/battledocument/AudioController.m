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
	
}


static AudioQueueBufferRef buffer[3];
static AudioStreamBasicDescription dataFormat;
static AudioStreamPacketDescription *audioStreamPacketDescription[3] = {nil,nil,nil};
static UInt32 s[3];

void initBuffer(NSString* name, AudioQueueBufferRef b[3]) {
    NSURL* url = [[NSBundle mainBundle] URLForResource:name withExtension:@"caf"];
    CFURLRef theURL = (__bridge CFURLRef)(url);
    AudioFileID audioFileID;
    AudioFileOpenURL(theURL, 0x01, kAudioFileCAFType, &audioFileID);
    CFRelease(theURL);
    
	
    UInt32 size = sizeof(dataFormat);
    AudioFileGetProperty(audioFileID, kAudioFilePropertyDataFormat, &size, &dataFormat);
    AudioQueueRef audioQueue;
	AudioQueueNewOutput(&dataFormat, callback, nil, nil, nil, 0, &audioQueue);
    UInt32 packs = 0x20000 / dataFormat.mBytesPerPacket;
   
	
    
    UInt32 ind = 0,n;
    for (int i = 0; i < 3; i++) {
		AudioQueueAllocateBuffer(audioQueue, 0x20000, &b[i]);
        AudioQueueBufferRef bu = b[i];
        s[i] = packs;
        AudioFileReadPackets(audioFileID, NO, &n, audioStreamPacketDescription[i], ind, &s[i], bu->mAudioData);
        ind += s[i];
        
	}
}




void playFromBuffer(AudioQueueBufferRef c[3]) {
    AudioQueueRef audioQueue;
    AudioQueueNewOutput(&dataFormat, callback, nil, nil, nil, 0, &audioQueue);
    AudioQueueBufferRef b[3];
//    AudioQueueSetParameter(audioQueue, kAudioQueueParam_Volume, 0.1);
    UInt32 ind = 0;
    for (int i = 0; i < 3; i++) {
       
		
        ind += s[i];
        AudioQueueEnqueueBuffer(audioQueue, b[i], (audioStreamPacketDescription[i] ? s[i] : 0), audioStreamPacketDescription[i]);
    }
    
    
}


void playSoundEffect(NSString* name, float volume) {
    AudioQueueRef audioQueue;
    NSURL* url = [[NSBundle mainBundle] URLForResource:name withExtension:@"caf"];
    CFURLRef theURL = (__bridge CFURLRef)(url);
    AudioFileID audioFileID;
    AudioFileOpenURL(theURL, 0x01, kAudioFileCAFType, &audioFileID);
    CFRelease(theURL);
    AudioQueueBufferRef	b[3];
	AudioStreamBasicDescription dataFormat;
    UInt32 size = sizeof(dataFormat);
    AudioFileGetProperty(audioFileID, kAudioFilePropertyDataFormat, &size, &dataFormat);

	AudioQueueNewOutput(&dataFormat, callback, nil, nil, nil, 0, &audioQueue);
    UInt32 packs = 0x20000 / dataFormat.mBytesPerPacket;
    AudioStreamPacketDescription *audioStreamPacketDescription = nil;
	
    
    UInt32 ind = 0,n,s;
    for (int i = 0; i < 3; i++) {
		AudioQueueAllocateBuffer(audioQueue, 0x20000, &b[i]);
        AudioQueueBufferRef bu = b[i];
        s = packs;
        AudioFileReadPackets(audioFileID, NO, &n, audioStreamPacketDescription, ind, &s, bu->mAudioData);
        ind += s;
        if (s > 0) {
            bu->mAudioDataByteSize = n;
            AudioQueueEnqueueBuffer(audioQueue, bu, (audioStreamPacketDescription ? s : 0), audioStreamPacketDescription);
        }
	}
    AudioQueueSetParameter(audioQueue, kAudioQueueParam_Volume, volume);
	AudioQueueStart(audioQueue, nil);
    
    
}

void playQueue(AudioQueueRef queue) {

    
}

@implementation AudioController
-(id) init {
    if (self = [super init]) {
        laserSoundEffects = [NSMutableArray array];
        initBuffer(@"laser3-lipa-modified", buffer);
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

-(void) playBotExploded:(int) time :(double) timePeriod {
    if (time > 0) {
        playSoundEffect(@"76151_35187-lq",1.0);

    }
}

-(void) playMissileFireSound:(int) times :(double) timePeriod {
    //playFromBuffer(buffer);
    
    if (times >= 1) {
        
    
    
        playSoundEffect(@"laser3-lipa-modified",0.05);
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
    
   
    if (times >= 1) {
        playSoundEffect(@"21410_21830-lq-short-lipa",0.7);
    }
    

}

@end
