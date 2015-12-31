//
//  OSCNews.m
//  iosapp
//
//  Created by chenhaoxiang on 10/27/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSXNewsViewModel.h"
#import "NSXNewsViewModelParam.h"
#import "NSXNewsViewModelResult.h"
#import "NSXBaseTool.h"



@implementation NSXNewsViewModel (Provider)
+ (void)newsViewModelWithParam:(NSXNewsViewModelParam *)param success:(void (^)(NSXNewsViewModelResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"newsViewModel"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXNewsViewModelResult class] success:success failure:failure];
}

+ (void)newsViewModelArrayWithParam:(NSXNewsViewModelParam *)param success:(void (^)(NSXNewsViewModelResult *result))success failure:(void (^)(NSError *error))failure
{
        NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"newsArray"];
[NSXBaseTool postWithUrl:url param:param resultClass:[NSXNewsViewModelResult class] success:success failure:failure];
    
//    [NSXBaseTool postWithUrl:@"http://localhost:4000" param:param resultClass:[NSXNewsViewModelResult class] success:success failure:failure];
}

+ (void)newsViewModelInsertWithParam:(NSXNewsViewModelParam *)param success:(void (^)(NSXNewsViewModelResult *result))success failure:(void (^)(NSError *error))failure
{
      NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"newsInsert"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXNewsViewModelResult class] success:success failure:failure];
}

+ (void)newsViewModelUpdateWithParam:(NSXNewsViewModelParam *)param success:(void (^)(NSXNewsViewModelResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"newsUpdate"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXNewsViewModelResult class] success:success failure:failure];
}


+ (void)newsViewModelDeleteWithParam:(NSXNewsViewModelParam *)param success:(void (^)(NSXNewsViewModelResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"newsDelete"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXNewsViewModelResult class] success:success failure:failure];
}




@end
