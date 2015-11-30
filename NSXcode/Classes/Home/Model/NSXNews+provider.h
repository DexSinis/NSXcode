@class NSXNewsResult,NSXNewsParam;


@interface NSXNews (provider)

+ (void)homeStatusesWithParam:(NSXNewsParam *)param success:(void (^)(NSXNewsResult *result))success failure:(void (^)(NSError *error))failure;

@end
