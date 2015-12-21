//
//  NDHttpTool.m
//  Dexter微博
//
//  Created by user on 15/4/20.
//  Copyright (c) 2015年 dexter. All rights reserved.
//

#import "NSXHttpTool.h"
#import "AFNetworking.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
@implementation NSXHttpTool

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *mar =[AFHTTPRequestOperationManager manager];
      mar.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mar GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *mar =[AFHTTPRequestOperationManager manager];
      mar.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mar POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getASI:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    
    NSURL *urlASI = [NSURL URLWithString:url];
    __weak ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:urlASI];
    request.timeOutSeconds = 10;
    
    [request setStartedBlock:^{
        NSLog(@"setStartedBlock------");
    }];
    [request setDataReceivedBlock:^(NSData *data) {
        NSLog(@"setDataReceivedBlock ----");
    }];
    
    [request setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableLeaves error:nil];
        if (dict) {
            success(dict);
        }
        NSLog(@"setCompletionBlock ----");
        NSLog(@"%@",dict);
    }];
    
    [request setFailedBlock:^{
        if (request.error) {
            failure(request.error);
        }
        NSLog(@"setFailedBlock ----");
    }];
    
    [request startAsynchronous];
    
}

+ (void)postASI:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    
    // 1.创建请求对象
    NSURL *urlASI = [NSURL URLWithString:url];
   __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:urlASI];
    
    // 2.添加请求参数(请求体中的参数)
    [request setPostValue:@"123" forKey:@"username"];
    [request setPostValue:@"999" forKey:@"pwd"];
    
                     [request setStartedBlock:^{
        NSLog(@"setStartedBlock------");
    }];
                     [request setDataReceivedBlock:^(NSData *data) {
        NSLog(@"setDataReceivedBlock ----");
    }];
                     
    [request setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableLeaves error:nil];
        if (dict) {
            success(dict);
        }
        NSLog(@"setCompletionBlock ----");
        NSLog(@"%@",dict);
    }];
                     
    [request setFailedBlock:^{
        if (request.error) {
            failure(request.error);
        }
        NSLog(@"setFailedBlock ----");
    }];
    
    // 3.发送请求
    [request startAsynchronous];
}

@end
