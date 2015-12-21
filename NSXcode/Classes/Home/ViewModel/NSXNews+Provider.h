@class NSXNewsResult,NSXNewsParam;


@interface NSXNews (Provider)

+ (void)newsWithParam:(NSXNewsParam *)param success:(void (^)(NSXNewsResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)newsArrayWithParam:(NSXNewsParam *)param success:(void (^)(NSXNewsResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)newsInsertWithParam:(NSXNewsParam *)param success:(void (^)(NSXNewsResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)newsUpdateWithParam:(NSXNewsParam *)param success:(void (^)(NSXNewsResult *result))success failure:(void (^)(NSError *error))failure;


+ (void)newsDeleteWithParam:(NSXNewsParam *)param success:(void (^)(NSXNewsResult *result))success failure:(void (^)(NSError *error))failure;

@end

