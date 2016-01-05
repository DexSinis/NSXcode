@class NSXCommentViewModelResult,NSXCommentViewModelParam;
#import "NSXCommentViewModelParam.h"

@interface NSXCommentViewModel (Provider)

+ (void)commentViewModelWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)commentViewModelArrayWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)commentViewModelInsertWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)commentViewModelUpdateWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure;

+ (void)commentViewModelDeleteWithParam:(NSXCommentViewModelParam *)param success:(void (^)(NSXCommentViewModelResult *result))success failure:(void (^)(NSError *error))failure;
@end

