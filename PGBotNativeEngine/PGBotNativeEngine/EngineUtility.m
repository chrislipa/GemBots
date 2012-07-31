//
//  Utility.m
//  PGBotNativeEngine
//
//  Created by Christopher Lipa on 7/30/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import "EngineUtility.h"

@implementation EngineUtility



@end

int readInteger(NSString* valueStr) {
    int value;
    if ([valueStr hasPrefix:@"0x"]) {
        NSScanner *scanner = [NSScanner scannerWithString:valueStr];
        [scanner setScanLocation:2];
        [scanner scanHexInt:&value];
    } else {
        value = [valueStr intValue];
    }
    return value;
}

NSDictionary* dictionaryFromTextFile:(NSString*) file {
    dictionary = [[NSMutableDictionary alloc] init];
    
    NSString* fileName = [[NSBundle mainBundle] pathForResource:file ofType:@"txt"];
    NSString* contents =  [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    
    NSArray* lines = [contents componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    
    for (NSString* line in allLinedStrings) {
        NSArray* lineComps = [line componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([lineComps length] == 2) {
            NSString* key = [lineComps objectAtIndex:0];
            NSString* valueStr = [lineComps objectAtIndex:1];
            int value = readInteger(valueStr);
            NSNumber* numberValue = [NSNumber numberWithInt:value];
            [dictionary setObject:numberValue forKey:key];
        }
    }
    return dictionary;
}

NSDictionary* constantDictionary() {
    static NSMutableDictionary* constantDictionary = nil;
    if (constantDictionary == nil) {
        constantDictionary = dictionaryFromTextFile(@"Constants");
    }
    return constantDictionary;
}


NSDictionary* defaultVariablesDictionary() {
    static NSMutableDictionary* constantDictionary = nil;
    if (constantDictionary == nil) {
        constantDictionary = dictionaryFromTextFile(@"DefaultVariables");
    }
    return constantDictionary;
}


