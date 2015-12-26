//
//  OSCUser.m
//  iosapp
//
//  Created by chenhaoxiang on 11/5/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//

#import "NSXAccount.h"
#import "NSXAccountParam.h"
#import "NSXAccountResult.h"
#import "NSXBaseTool.h"
@implementation NSXAccount (Provider)

+ (void)accountWithParam:(NSXAccountParam *)param success:(void (^)(NSXAccountResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"account"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXAccountResult class] success:success failure:failure];
}

+ (void)accountArrayWithParam:(NSXAccountParam *)param success:(void (^)(NSXAccountResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"accountArray"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXAccountResult class] success:success failure:failure];
    
    //    [NSXBaseTool postWithUrl:@"http://localhost:4000" param:param resultClass:[NSXAccountResult class] success:success failure:failure];
}

+ (void)accountInsertWithParam:(NSXAccountParam *)param success:(void (^)(NSXAccountResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"accountInsert"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXAccountResult class] success:success failure:failure];
}

+ (void)accountUpdateWithParam:(NSXAccountParam *)param success:(void (^)(NSXAccountResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"accountUpdate"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXAccountResult class] success:success failure:failure];
}


+ (void)accountDeleteWithParam:(NSXAccountParam *)param success:(void (^)(NSXAccountResult *result))success failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"accountDelete"];
    [NSXBaseTool postWithUrl:url param:param resultClass:[NSXAccountResult class] success:success failure:failure];
}



@end
