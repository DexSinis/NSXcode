//
//  HomeViewModel.m
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/5.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import "NSXCommentViewModel.h"
#import "NSXComment.h"
//#import "NSXComment+Provider.h"
#import "NSXCommentViewModel+Provider.h"
#import "NSXCommentViewModelParam.h"
#import "NSXCommentViewModelResult.h"
#import <MJExtension/MJExtension.h>

@interface NSXCommentViewModel()


@end

@implementation NSXCommentViewModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"hotPosts" : @"NSXComment",
             @"commonPosts" : @"NSXComment",
             };
}
//+ (NSDictionary *)mj_replacedKeyFromPropertyName
//{
//    return @{
//             @"currentLoadDayStr" : @"date",
////             @"newsId" : @"id"
//             };
//    
//}



//获取最新的新闻
- (void)getLatestStories {
    
    NSLog(@"getLatestStories----------");
    NSXCommentViewModelParam *param = [[NSXCommentViewModelParam alloc] init];
    param.currentcommonPostID =@"20151226";
    [NSXCommentViewModel commentViewModelWithParam:param success:^(NSXCommentViewModelResult *result) {
//        NSXCommentViewModel *viewModel = result.viewModel;
//        self.currentLoadDayStr = viewModel.currentLoadDayStr;
//        SectionViewModel *vm = [[SectionViewModel alloc] initWithViewModel:viewModel];
//        self.daysDataList = [NSMutableArray arrayWithObject:vm];
//        self.top_stories = viewModel.top_stories;
//        NSDictionary *vmjson = vm.mj_keyValues;
//        NSLog(@"%@",vmjson);
//        self.newsIdArray = [NSMutableArray arrayWithArray:[vmjson valueForKeyPath:@"sectionDataSource.id"]];
//
//        
//        for (NSXComment *news in viewModel.daysDataList) {
////            NSLog(@"%@",news.images);
//        }
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadLatestDaily" object:nil];

    } failure:^(NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadLatestDaily" object:nil userInfo:@{@"cyl_reloadData":@"cyl_reloadData"}];
    }];
//    NSXCommentViewModelParam *param = [[NSXCommentViewModelParam alloc] init];
//   [NSXCommentViewModel commentViewModelWithParam:param success:^(NSXCommentViewModelResult *result) {
//       
//   } failure:^(NSError *error) {
//       
//   }];
    
//    [HttpOperation getRequestWithURL:@"news/latest" parameters:nil success:^(id responseObject) {
//        NSDictionary *jsonDic = (NSDictionary*)responseObject;
//        self.currentLoadDayStr = responseObject[@"date"];
//
//        SectionViewModel *vm = [[SectionViewModel alloc] initWithDictionary:jsonDic];
//        _daysDataList = [NSMutableArray arrayWithObject:vm];
//        _storiesID = [NSMutableArray arrayWithArray:[vm valueForKeyPath:@"sectionDataSource.storyID"]];
//        
//        NSArray *stories = jsonDic[@"top_stories"];
//        NSMutableArray *storyModelList = [NSMutableArray new];
//        for (NSDictionary *storyDic in stories) {
//            StoryModel *model = [[StoryModel alloc] initWithDictionary:storyDic];
//            [storyModelList addObject:model];
//        }
//        StoryModel *first = [storyModelList firstObject];
//        StoryModel *last = [storyModelList lastObject];
//        [storyModelList addObject:first];
//        [storyModelList insertObject:last atIndex:0];
//        [self setValue:storyModelList forKey:@"top_stories"];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadLatestDaily" object:nil];
//        
//    } failure:nil];
}

- (void)updateLatestStories {
    _isLoading = YES;
    NSLog(@"updateLatestStories----------");
    NSXCommentViewModelParam *param = [[NSXCommentViewModelParam alloc] init];

    param.currentcommonPostID = self.currentcommonPostID;
    param.currentcommonPostID =@"20151227";
    [NSXCommentViewModel commentViewModelWithParam:param success:^(NSXCommentViewModelResult *result) {
//        NSXCommentViewModel *viewModel = result.viewModel;
//        SectionViewModel *newvm = [[SectionViewModel alloc] initWithViewModel:viewModel];
//        SectionViewModel *oldvm = _daysDataList[0];
//        
//        if ([newvm.sectionTitleText isEqualToString:oldvm.sectionTitleText]) {
////            NSArray* new = newvm.sectionDataSource;
////            NSArray* old = oldvm.sectionDataSource;
//            if (newvm.sectionDataSource.count>oldvm.sectionDataSource.count) {
//                NSUInteger newItemsCount = newvm.sectionDataSource.count-oldvm.sectionDataSource.count;
//                for (int i = 1; i <=newItemsCount; i++) {
//                    NSXComment *news = newvm.sectionDataSource[newItemsCount-i];
//                    [_newsIdArray insertObject:news.newsId atIndex:0];
//                }
//                [_daysDataList removeObject:oldvm];
//                [_daysDataList insertObject:newvm atIndex:0];
//            }
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateLatestDaily" object:nil];
//        }else {
//            self.currentLoadDayStr = viewModel.currentLoadDayStr;
//            self.daysDataList = [NSMutableArray arrayWithObject:newvm];
//            _newsIdArray = [NSMutableArray arrayWithArray:[newvm valueForKeyPath:@"sectionDataSource.newsId"]];
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateLatestDaily" object:nil userInfo:@{@"isNewDay":@(YES)}];
//        }
//        _isLoading = NO;
        
    } failure:^(NSError *error) {
           [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateLatestDaily" object:nil userInfo:@{@"cyl_reloadData":@"cyl_reloadData"}];
    }];
//    [HttpOperation getRequestWithURL:@"news/latest" parameters:nil success:^(id responseObject) {
//        NSDictionary *jsonDic = (NSDictionary*)responseObject;
//        
//        NSArray *stories = jsonDic[@"top_stories"];
//        NSMutableArray *storyModelList = [NSMutableArray new];
//        for (NSDictionary *storyDic in stories) {
//            StoryModel *model = [[StoryModel alloc] initWithDictionary:storyDic];
//            [storyModelList addObject:model];
//        }
//        StoryModel *first = [storyModelList firstObject];
//        StoryModel *last = [storyModelList lastObject];
//        [storyModelList addObject:first];
//        [storyModelList insertObject:last atIndex:0];
//        [self setValue:storyModelList forKey:@"top_stories"];
//        
//        SectionViewModel *newvm = [[SectionViewModel alloc] initWithDictionary:jsonDic];
//        SectionViewModel *oldvm = _daysDataList[0];
////        NSMutableArray* newArr = [NSMutableArray arrayWithArray:newvm.sectionDataSource];
////        [newArr addObjectsFromArray:oldvm.sectionDataSource];
////        newvm.sectionDataSource = newArr;
//
//        if ([newvm.sectionTitleText isEqualToString:oldvm.sectionTitleText]) {
//            NSArray* new = newvm.sectionDataSource;
//            NSArray* old = oldvm.sectionDataSource;
//            if (new.count>old.count) {
//                NSUInteger newItemsCount = new.count-old.count;
//                for (int i = 1; i <=newItemsCount; i++) {
//                    StoryModel *model = new[newItemsCount-i];
//                    [_storiesID insertObject:model.storyID atIndex:0];
//                }
//                [_daysDataList removeObject:oldvm];
//                [_daysDataList insertObject:newvm atIndex:0];
//            }
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateLatestDaily" object:nil];
//        }else {
//            _currentLoadDayStr = responseObject[@"date"];
//            _daysDataList = [NSMutableArray arrayWithObject:newvm];
//            _storiesID = [NSMutableArray arrayWithArray:[newvm valueForKeyPath:@"sectionDataSource.storyID"]];
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateLatestDaily" object:nil userInfo:@{@"isNewDay":@(YES)}];
//        }
//        _isLoading = NO;
//    } failure:nil];
}


- (void)getPreviousStories {
    
      NSLog(@"getPreviousStories----------");
     _isLoading = YES;
        NSXCommentViewModelParam *param = [[NSXCommentViewModelParam alloc] init];
        param.currentcommonPostID = self.currentcommonPostID;
        param.currentcommonPostID =@"20151225";
       [NSXCommentViewModel commentViewModelWithParam:param success:^(NSXCommentViewModelResult *result) {
//           NSXCommentViewModel *viewModel = result.viewModel;
//           SectionViewModel *vm = [[SectionViewModel alloc] initWithViewModel:viewModel];
//           [self.daysDataList addObject:vm];
//           [self.newsIdArray addObjectsFromArray:[vm valueForKeyPath:@"sectionDataSource.newsId"]];
//           [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadPreviousDaily" object:nil];
//           _isLoading = NO;
       } failure:^(NSError *error) {
      [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadPreviousDaily" object:nil userInfo:@{@"cyl_reloadData":@"cyl_reloadData"}];
       }];
//    [HttpOperation getRequestWithURL:[NSString stringWithFormat:@"news/before/%@",_currentLoadDayStr] parameters:nil success:^(id responseObject) {
//        NSDictionary *jsonDic = (NSDictionary*)responseObject;
//        self.currentLoadDayStr = responseObject[@"date"];
//        SectionViewModel *vm = [[SectionViewModel alloc] initWithDictionary:jsonDic];
//        [_daysDataList addObject:vm];
//        [_storiesID addObjectsFromArray:[vm valueForKeyPath:@"sectionDataSource.storyID"]];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadPreviousDaily" object:nil];
//        _isLoading = NO;
//    } failure:nil];
}


@end
