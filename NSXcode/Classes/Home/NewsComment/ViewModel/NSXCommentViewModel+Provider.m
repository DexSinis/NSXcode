//
//  OSCcomment.m
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
+ (void)commentViewModelWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"commentViewModel"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXCommentViewModelResult class] success:success failure:failure];
}

+ (void)commentViewModelArrayWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure
{
        NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"commentArray"];
[NSXBaseTool postWithUrl:url param:param resultClass:[NSXCommentViewModelResult class] success:success failure:failure];
    
//    [NSXBaseTool postWithUrl:@"http://localhost:4000" param:param resultClass:[NSXCommentViewModelResult class] success:success failure:failure];
}

+ (void)commentViewModelInsertWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure
{
      NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"commentInsert"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXCommentViewModelResult class] success:success failure:failure];
}

+ (void)commentViewModelUpdateWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"commentUpdate"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXCommentViewModelResult class] success:success failure:failure];
}


+ (void)commentViewModelDeleteWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"commentDelete"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXCommentViewModelResult class] success:success failure:failure];
}




@end
