//
//  HomeViewModel.h
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/5.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StoryModel;
@interface NSXNewsViewModel : NSObject

@property(strong,nonatomic)NSMutableArray *daysDataList;
@property(strong,nonatomic)NSMutableArray *top_stories;
@property(assign,readonly,nonatomic)BOOL isLoading;
@property(strong,readonly,nonatomic)NSMutableArray *storiesID;

- (void)getLatestStories;
- (void)getPreviousStories;
- (void)updateLatestStories;

- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfRowsInSection:(NSUInteger)section;
- (NSAttributedString *)titleForSection:(NSInteger)section;
- (StoryModel *)storyAtIndexPath:(NSIndexPath *)indexPath;


@end
