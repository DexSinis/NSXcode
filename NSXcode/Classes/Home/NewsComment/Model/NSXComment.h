//
//  Comment.h
//  NSXcode
//
//  Created by DexSinis on 16/1/5.
//  Copyright © 2016年 DexSinis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSXComment : NSObject

@property (nonatomic,strong) NSString *commentId;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *comment;
@property (nonatomic,strong) NSString *timeString;
@property (nonatomic,strong) NSString *floor;
@property (nonatomic,strong) NSString *storey;

@property (nonatomic,strong) NSString *newsId;  //新闻的id
@property (nonatomic,strong) NSString *userId;  //评论用户的id

@property (nonatomic,strong) NSString *likeCount;  //点赞数
@property (nonatomic,strong) NSString *commentCount;  //评论数

-(instancetype)initWithDict:(NSDictionary *)dic;
- (CGSize)sizeWithConstrainedToSize:(CGSize)size;
@end

