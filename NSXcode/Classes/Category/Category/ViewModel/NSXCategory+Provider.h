@class NSXCategoryResult,NSXCategoryParam;


@interface NSXCategory (Provider)

+ (void)categoryWithParam:(NSXCategoryParam *)param success:(void (^)(NSXCategoryResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)categoryArrayWithParam:(NSXCategoryParam *)param success:(void (^)(NSXCategoryResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)categoryInsertWithParam:(NSXCategoryParam *)param success:(void (^)(NSXCategoryResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)categoryUpdateWithParam:(NSXCategoryParam *)param success:(void (^)(NSXCategoryResult *result))success failure:(void (^)(NSError *error))failure;


+ (void)categoryDeleteWithParam:(NSXCategoryParam *)param success:(void (^)(NSXCategoryResult *result))success failure:(void (^)(NSError *error))failure;

@end

