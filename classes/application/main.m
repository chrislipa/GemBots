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
    for (int i = 0; i<argc ; i++) {
        if (strcmp(argv[i], "script") == 0) {
            gembotscript(argc, argv);
        }
    }
    return NSApplicationMain(argc, (const char **)argv);
}
