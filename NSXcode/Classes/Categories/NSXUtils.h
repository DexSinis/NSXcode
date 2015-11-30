//
//  NSXUtils.h
//  NSXcode
//
//  Created by DexSinis on 15/11/27.
//  Copyright © 2015年 DexSinis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSXUtils : NSObject
+ (NSAttributedString *)attributedTimeString:(NSDate *)date;
+ (NSAttributedString *)attributedCommentCount:(int)commentCount;
@end
