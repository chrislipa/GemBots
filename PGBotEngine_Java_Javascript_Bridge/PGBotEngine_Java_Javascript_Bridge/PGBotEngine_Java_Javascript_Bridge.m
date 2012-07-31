//
//  PGBotEngine_Java_Javascript_Bridge.m
//  PGBotEngine_Java_Javascript_Bridge
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <JavaVM/jni.h>
#import "PGBotEngine_Java_Javascript_Bridge.h"

#define PATH_SEPARATOR '/' /* define it to be ':' on Solaris */
#define USER_CLASSPATH "." /* where Prog.class is */


@implementation PGBotEngine_Java_Javascript_Bridge

-(id) init {
    if (self = [super init]) {
        [self initializeJVM];
    }
    return self;
}

-(void) initializeJVM {
    
    jstring jstr;
    jclass stringClass;
    jobjectArray args;
    
    
    
    
    JavaVMInitArgs vm_args;
    JavaVMOption options[1];
    options[0].optionString =
    "-Djava.class.path=" USER_CLASSPATH;
    vm_args.version = 0x00010002;
    vm_args.options = options;
    vm_args.nOptions = 1;
    vm_args.ignoreUnrecognized = JNI_TRUE;
    
    jint res = JNI_CreateJavaVM(&jvm, (void**)&env, &vm_args);
    
    
    if (res < 0) {
        NSLog(@"Can't create Java VM\n");
        return;
    }
    jclass cls = (*env)->FindClass(env, "Prog");
    if (cls == NULL) {
        goto destroy;
    }
    
    jmethodID mid = (*env)->GetStaticMethodID(env, cls, "main",
                                              "([Ljava/lang/String;)V");
    if (mid == NULL) {
        goto destroy;
    }
    jstr = (*env)->NewStringUTF(env, " from C!");
    if (jstr == NULL) {
        goto destroy;
    }
    stringClass = (*env)->FindClass(env, "java/lang/String");
    args = (*env)->NewObjectArray(env, 1, stringClass, jstr);
    if (args == NULL) {
        goto destroy;
    }
    (*env)->CallStaticVoidMethod(env, cls, mid, args);
    
    

}



-(void) destroyJVM {
    if ((*env)->ExceptionOccurred(env)) {
        (*env)->ExceptionDescribe(env);
    }
    (*jvm)->DestroyJavaVM(jvm);
}


//Reads in the robot at the given URL into the engine.
-(void) addRobot:(NSData*) robotData {
    
}

-(void) setRobot:(NSString*) sessionUniqueRobotIdentifier:(NSString*)surid toTeam:(int) team {
    
}


//Returns an array of GemBotDescriptions
-(NSArray*) robots {
    return [NSArray array];
}


-(void) setGameCycleTimeout:(int) maxNumberOfGameCycles {
    
}

-(void) setNumberOfMatches:(int) numberOfMatches {
    
}


-(void) startNewSetOfMatches {
    
}

-(void) stepGameCycle {
    
}

-(GameStateDescriptor*) currentGameStateDescription {
    return nil;
}

-(bool) isSetOfMatchesCompleted {
    return YES;
}
@end
