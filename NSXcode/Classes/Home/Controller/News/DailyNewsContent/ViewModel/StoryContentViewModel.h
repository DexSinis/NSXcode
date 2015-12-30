//
//  StoryContentViewModel.h
//
//
//  Created by 洪鹏宇 on 15/11/18.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoryContentModel.h"

@interface StoryContentViewModel : NSObject

@property(copy,nonatomic)NSString *loadedStoryID;
@property(strong,nonatomic)NSMutableArray *storiesID;
@property(strong,nonatomic)StoryContentModel *storyModel;
@property(copy,nonatomic)NSString *imageURLString;
@property(copy,nonatomic)NSAttributedString *titleAttText;
@property(copy,nonatomic)NSString *imaSourceText;
@property(copy,nonatomic)NSString *htmlStr;
@property(copy,nonatomic)NSString *share_URL;
@property(copy,nonatomic)NSNumber *storyType;
@property(strong,nonatomic)NSArray *recommenders;

- (void)getStoryContentWithStoryID:(NSNumber *)storyID; //通过id获取内容
- (void)getPreviousStoryContent; //获取上一篇内容
- (void)getNextStoryContent; //获取下一篇内容

@end
