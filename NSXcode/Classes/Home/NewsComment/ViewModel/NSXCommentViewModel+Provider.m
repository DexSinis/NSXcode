//
//  OSCNews.m
//  iosapp
//
//  Created by chenhaoxiang on 10/27/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSXCommentViewModel.h"
#import "NSXCommentViewModelParam.h"
#import "NSXCommentViewModelResult.h"
#import "NSXBaseTool.h"



@implementation NSXCommentViewModel (Provider)
+ (void)newsViewModelWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"newsViewModel"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXCommentViewModelResult class] success:success failure:failure];
}

+ (void)newsViewModelArrayWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure
{
        NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"newsArray"];
[NSXBaseTool postWithUrl:url param:param resultClass:[NSXCommentViewModelResult class] success:success failure:failure];
    
//    [NSXBaseTool postWithUrl:@"http://localhost:4000" param:param resultClass:[NSXCommentViewModelResult class] success:success failure:failure];
}

+ (void)newsViewModelInsertWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure
{
      NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"newsInsert"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXCommentViewModelResult class] success:success failure:failure];
}

+ (void)newsViewModelUpdateWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"newsUpdate"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXCommentViewModelResult class] success:success failure:failure];
}


+ (void)newsViewModelDeleteWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"newsDelete"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXCommentViewModelResult class] success:success failure:failure];
}




@end
