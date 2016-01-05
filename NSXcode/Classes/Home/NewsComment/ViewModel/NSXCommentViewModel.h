//
//  HomeViewModel.h
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/5.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSXComment;
@interface NSXCommentViewModel : NSObject

@property(strong,nonatomic)NSMutableArray *hotPosts;
@property(strong,nonatomic)NSMutableArray *commonPosts;
@property(assign,nonatomic)BOOL isLoading;
@property(strong,nonatomic)NSMutableArray *hotPostsIdArray;
@property(strong,nonatomic)NSMutableArray *commonPostsIdArray;

@property(copy,nonatomic)NSString *currentcommonPostID; //已加载最靠前那一天的日期字符串
@property(copy,nonatomic)NSString *currenthotPostID; //已加载最靠前那一天的日期字符串


- (void)getLatestStories;
- (void)getPreviousStories;
- (void)updateLatestStories;


- (NSXComment *)storyAtIndexPath:(NSIndexPath *)indexPath;


@end
