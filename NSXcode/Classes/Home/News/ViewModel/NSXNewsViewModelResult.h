//
//  MJStatusResult.h
//  字典与模型的互转
//
//  Created by MJ Lee on 14-5-21.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//  微博结果（用来表示大批量的微博数据）

#import <UIKit/UIKit.h>
#import "NSXNewsViewModel.h"
@interface NSXNewsViewModelResult : NSObject
/** 存放着某一页微博数据（里面都是Status模型） */
//@property (strong, nonatomic) NSMutableArray *newsArray;
//@property(strong,nonatomic)NSMutableArray *daysDataList;
//@property(strong,nonatomic)NSMutableArray *top_stories;
//@property(assign,readonly,nonatomic)BOOL isLoading;
//@property(strong,readonly,nonatomic)NSMutableArray *storiesID;

//@property(copy,nonatomic)NSString *currentLoadDayStr;

@property(strong,nonatomic)NSXNewsViewModel *viewModel;


/** 总数 */
@property (strong, nonatomic) NSNumber *totalNumber;
/** 上一页的游标 */
@property (assign, nonatomic) long long previousCursor;
/** 下一页的游标 */
@property (assign, nonatomic) long long nextCursor;

/** 存放着一堆的广告数据（里面都是MJAd模型） */
@property (strong, nonatomic) NSArray *ads;

@end
