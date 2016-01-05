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



@implementation NSXNews (Provider)
+ (void)newsWithParam:(NSXNewsParam *)param success:(void (^)(NSXNewsResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"news"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXNewsResult class] success:success failure:failure];
}

+ (void)newsArrayWithParam:(NSXNewsParam *)param success:(void (^)(NSXNewsResult *result))success failure:(void (^)(NSError *error))failure
{
        NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"newsArray"];
[NSXBaseTool postWithUrl:url param:param resultClass:[NSXNewsResult class] success:success failure:failure];
    
//    [NSXBaseTool postWithUrl:@"http://localhost:4000" param:param resultClass:[NSXNewsResult class] success:success failure:failure];
}

+ (void)newsInsertWithParam:(NSXNewsParam *)param success:(void (^)(NSXNewsResult *result))success failure:(void (^)(NSError *error))failure
{
      NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"newsInsert"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXNewsResult class] success:success failure:failure];
}

+ (void)newsUpdateWithParam:(NSXNewsParam *)param success:(void (^)(NSXNewsResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"newsUpdate"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXNewsResult class] success:success failure:failure];
}


+ (void)newsDeleteWithParam:(NSXNewsParam *)param success:(void (^)(NSXNewsResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"newsDelete"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXNewsResult class] success:success failure:failure];
}




@end
