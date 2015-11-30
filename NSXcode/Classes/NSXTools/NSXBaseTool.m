//
//  NDBaseTool.m
//  Dexter微博
//
//  Created by user on 15/4/20.
//  Copyright (c) 2015年 dexter. All rights reserved.
//

#import "NSXBaseTool.h"
#import "NSXHttpTool.h"
#import "MJExtension.h"

@implementation NSXBaseTool
+(void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void(^)(id))success failure:(void(^)(NSError *))failure
{
    NSDictionary *params = [param mj_keyValues];
    
    [NSXHttpTool get:url params:params success:^(id responseObj){
        if (success) {
            id result = [resultClass mj_objectWithKeyValues:responseObj];
            success(result);
        }
    }failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void(^)(id))success failure:(void(^)(NSError *))failure
{
    NSDictionary *params = [param mj_keyValues];
    
    [NSXHttpTool post:url params:params success:^(id responseObj){
        if (success) {
            id result = [resultClass mj_objectWithKeyValues:responseObj];
            success(result);
        }
    }failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
