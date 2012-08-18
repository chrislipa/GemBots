//
//  main.m
//  bot
//
//  Created by Christopher Lipa on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "gembotscript.h"

int main(int argc, char *argv[])
{
    /*
    char* argvfake[] = {"script", "-d", "file:///Users/lipa/bot/", "-b", "sniper.gembot", "-b", "sniper.gembot", "-n" ,"160", "-o", "output.txt"};
    int argcfake = 11;*/
    for (int i = 0; i<argc ; i++) {
        if (strcmp(argv[i], "script") == 0) {
            gembotscript(argc, argv);
            return 0;
        }
    }
    return NSApplicationMain(argc, (const char **)argv);
}
