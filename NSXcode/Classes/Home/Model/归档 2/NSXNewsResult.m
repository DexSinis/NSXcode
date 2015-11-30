//
//  NSXNewsResult.m
//  NSXcode
//
//  Created by DexSinis on 15/11/30.
//  Copyright © 2015年 DexSinis. All rights reserved.
//

#import "NSXNewsResult.h"
#import "NSXNews.h"
#import "MJExtension.h"
@implementation NSXNewsResult
- (NSDictionary *)mj_objectClassInArray
{
    return @{@"results" : @"NSXNews"};
}

@end

