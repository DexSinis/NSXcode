//
//  OSCUser.m
//  iosapp
//
//  Created by chenhaoxiang on 11/5/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//

#import "NSXUser.h"
#import "NSXUserParam.h"
#import "NSXUserResult.h"
#import "NSXBaseTool.h"
@implementation NSXUser (Provider)

+ (void)userWithParam:(NSXUserParam *)param success:(void (^)(NSXUserResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"user"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXUserResult class] success:success failure:failure];
}

+ (void)userArrayWithParam:(NSXUserParam *)param success:(void (^)(NSXUserResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"userArray"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXUserResult class] success:success failure:failure];
    
    //    [NSXBaseTool postWithUrl:@"http://localhost:4000" param:param resultClass:[NSXUserResult class] success:success failure:failure];
}

+ (void)userInsertWithParam:(NSXUserParam *)param success:(void (^)(NSXUserResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"userInsert"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXUserResult class] success:success failure:failure];
}

+ (void)userUpdateWithParam:(NSXUserParam *)param success:(void (^)(NSXUserResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"userUpdate"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXUserResult class] success:success failure:failure];
}


+ (void)userDeleteWithParam:(NSXUserParam *)param success:(void (^)(NSXUserResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"userDelete"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXUserResult class] success:success failure:failure];
}



@end
