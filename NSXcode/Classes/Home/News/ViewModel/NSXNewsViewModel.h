//
//  HomeViewModel.h
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/5.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSXNews;
@interface NSXNewsViewModel : NSObject

@property(strong,nonatomic)NSMutableArray *daysDataList;
@property(strong,nonatomic)NSMutableArray *top_stories;
@property(assign,nonatomic)BOOL isLoading;
@property(strong,nonatomic)NSMutableArray *newsIdArray;

@property(copy,nonatomic)NSString *currentLoadDayStr; //已加载最靠前那一天的日期字符串


- (void)getLatestStories;
- (void)getPreviousStories;
- (void)updateLatestStories;

- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfRowsInSection:(NSUInteger)section;
- (NSAttributedString *)titleForSection:(NSInteger)section;
- (NSXNews *)storyAtIndexPath:(NSIndexPath *)indexPath;


@end
