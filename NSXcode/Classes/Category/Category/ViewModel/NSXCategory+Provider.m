//
//  OSCcategory.m
//  iosapp
//
//  Created by chenhaoxiang on 10/27/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSXCategory.h"
#import "NSXCategoryParam.h"
#import "NSXCategoryResult.h"
#import "NSXBaseTool.h"




@implementation NSXCategory (Provider)
+ (void)categoryWithParam:(NSXCategoryParam *)param success:(void (^)(NSXCategoryResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"category"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXCategoryResult class] success:success failure:failure];
}

+ (void)categoryArrayWithParam:(NSXCategoryParam *)param success:(void (^)(NSXCategoryResult *result))success failure:(void (^)(NSError *error))failure
{
        NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"categoryArray"];
[NSXBaseTool postWithUrl:url param:param resultClass:[NSXCategoryResult class] success:success failure:failure];
    
//    [NSXBaseTool postWithUrl:@"http://localhost:4000" param:param resultClass:[NSXCategoryResult class] success:success failure:failure];
}

+ (void)categoryInsertWithParam:(NSXCategoryParam *)param success:(void (^)(NSXCategoryResult *result))success failure:(void (^)(NSError *error))failure
{
      NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"categoryInsert"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXCategoryResult class] success:success failure:failure];
}

+ (void)categoryUpdateWithParam:(NSXCategoryParam *)param success:(void (^)(NSXCategoryResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"categoryUpdate"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXCategoryResult class] success:success failure:failure];
}


+ (void)categoryDeleteWithParam:(NSXCategoryParam *)param success:(void (^)(NSXCategoryResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"categoryDelete"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXCategoryResult class] success:success failure:failure];
}




@end
