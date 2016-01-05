//
//  MJStatusResult.m
//  字典与模型的互转
//
//  Created by MJ Lee on 14-5-21.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import "NSXCommentViewModelResult.h"
#import <MJExtension/MJExtension.h>
@implementation NSXCommentViewModelResult
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"viewModel" : @"viewModel",
//             @"top_stories" : @"NSXCommentViewModel",
             };
}
@end
