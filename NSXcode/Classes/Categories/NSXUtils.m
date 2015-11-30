//
//  NSXUtils.m
//  NSXcode
//
//  Created by DexSinis on 15/11/27.
//  Copyright © 2015年 DexSinis. All rights reserved.
//

#import "NSXUtils.h"
#import "NSDate+TimeAgo.h"
#import "UIFont+FontAwesome.h"
#import "NSString+FontAwesome.h"
@implementation NSXUtils

+ (NSAttributedString *)attributedTimeString:(NSDate *)date
{
    NSString *rawString = [NSString stringWithFormat:@"%@ %@", [NSString fontAwesomeIconStringForEnum:FAClockO], @"8 hours ago"];
    
    NSLog(@"%@",rawString);
    if (rawString != nil) {
        NSAttributedString *attributedTime = [[NSAttributedString alloc] initWithString:rawString
                                                                             attributes:@{
                                                                                          NSFontAttributeName: [UIFont fontAwesomeFontOfSize:12],
                                                                                          }];
         return attributedTime;
    }else
    {
        return NULL;
    }
 
    
   
}


+ (NSAttributedString *)attributedCommentCount:(int)commentCount
{
    NSString *rawString = [NSString stringWithFormat:@"%@ %d", [NSString fontAwesomeIconStringForEnum:FACommentsO], commentCount];
    NSAttributedString *attributedCommentCount = [[NSAttributedString alloc] initWithString:rawString
                                                                                 attributes:@{
                                                                                              NSFontAttributeName: [UIFont fontAwesomeFontOfSize:12],
                                                                                              }];
    
    return attributedCommentCount;
}

@end
