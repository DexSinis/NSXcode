//
//  OSCNews.m
//  iosapp
//
//  Created by chenhaoxiang on 10/27/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSXNews.h"
#import "NSXNewsParam.h"
#import "NSXNewsResult.h"
#import "NSXBaseTool.h"

@implementation NSXNews (provider)
+ (void)homeStatusesWithParam:(NSXNewsParam *)param success:(void (^)(NSXNewsResult *result))success failure:(void (^)(NSError *error))failure
{
    [NSXBaseTool getWithUrl:@"http://localhost:4000/" param:param resultClass:[NSXNewsResult class] success:success failure:failure];
}

@end
