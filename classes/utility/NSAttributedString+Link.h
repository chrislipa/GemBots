//
//  NSAttributedString+Link.h
//  Gem Bots
//
//  Created by Christopher Lipa on 8/18/12.
//
//

#import <Foundation/Foundation.h>



@interface NSAttributedString (Hyperlink)
+(id)hyperlinkFromString:(NSString*)inString withURL:(NSURL*)aURL;
@end

