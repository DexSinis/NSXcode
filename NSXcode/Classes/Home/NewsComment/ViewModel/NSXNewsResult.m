//
//  MJStatusResult.m
//  字典与模型的互转
//
//  Created by MJ Lee on 14-5-21.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import "NSXNewsResult.h"

@implementation NSXNewsResult
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"newsArray" : @"NSXNews",
             };
}
@end
