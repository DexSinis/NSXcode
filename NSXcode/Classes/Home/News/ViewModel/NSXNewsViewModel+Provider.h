@class NSXNewsViewModelResult,NSXNewsViewModelParam;


@interface NSXNewsViewModel (Provider)

+ (void)newsViewModelWithParam:(NSXNewsViewModelParam *)param success:(void (^)(NSXNewsViewModelResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)newsViewModelArrayWithParam:(NSXNewsViewModelParam *)param success:(void (^)(NSXNewsViewModelResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)newsViewModelInsertWithParam:(NSXNewsViewModelParam *)param success:(void (^)(NSXNewsViewModelResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)newsViewModelUpdateWithParam:(NSXNewsViewModelParam *)param success:(void (^)(NSXNewsViewModelResult *result))success failure:(void (^)(NSError *error))failure;


+ (void)newsViewModelDeleteWithParam:(NSXNewsViewModelParam *)param success:(void (^)(NSXNewsViewModelResult *result))success failure:(void (^)(NSError *error))failure;

@end

