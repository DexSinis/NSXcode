//
//  NDBaseTool.h
//  Dexter微博
//
//  Created by user on 15/4/20.
//  Copyright (c) 2015年 dexter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSXBaseTool : NSObject
+(void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void(^)(id))success failure:(void(^)(NSError *))failure;

+(void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void(^)(id))success failure:(void(^)(NSError *))failure;
@end
