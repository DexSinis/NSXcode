//
//  OSCUser.h
//  iosapp
//
//  Created by chenhaoxiangs on 11/5/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//
@class NSXUserParam,NSXUserResult;

@interface NSXUser (Provider)

+ (void)userWithParam:(NSXUserParam *)param success:(void (^)(NSXUserResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)userArrayWithParam:(NSXUserParam *)param success:(void (^)(NSXUserResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)userInsertWithParam:(NSXUserParam *)param success:(void (^)(NSXUserResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)userUpdateWithParam:(NSXUserParam *)param success:(void (^)(NSXUserResult *result))success failure:(void (^)(NSError *error))failure;


+ (void)userDeleteWithParam:(NSXUserParam *)param success:(void (^)(NSXUserResult *result))success failure:(void (^)(NSError *error))failure;

@end
