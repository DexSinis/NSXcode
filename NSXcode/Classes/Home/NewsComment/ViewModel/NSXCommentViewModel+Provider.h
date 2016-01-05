@class NSXCommentViewModelResult,NSXCommentViewModelParam;
#import "NSXCommentViewModelParam.h"

@interface NSXCommentViewModel (Provider)

+ (void)newsViewModelWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)newsViewModelArrayWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)newsViewModelInsertWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)newsViewModelUpdateWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure;


+ (void)newsViewModelDeleteWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure;

@end

