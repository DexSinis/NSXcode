//
//  OSCUser.h
//  iosapp
//
//  Created by chenhaoxiangs on 11/5/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//

@class NSXAccountParam,NSXAccountResult;
@interface NSXAccount (Provider)

+ (void)accountWithParam:(NSXAccountParam *)param success:(void (^)(NSXAccountResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)accountArrayWithParam:(NSXAccountParam *)param success:(void (^)(NSXAccountResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)accountInsertWithParam:(NSXAccountParam *)param success:(void (^)(NSXAccountResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)accountUpdateWithParam:(NSXAccountParam *)param success:(void (^)(NSXAccountResult *result))success failure:(void (^)(NSError *error))failure;


+ (void)accountDeleteWithParam:(NSXAccountParam *)param success:(void (^)(NSXAccountResult *result))success failure:(void (^)(NSError *error))failure;

@end
