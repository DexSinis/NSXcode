//
//  HomeViewModel.m
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/5.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import "NSXNewsViewModel.h"
#import "NSXNews.h"
//#import "NSXNews+Provider.h"
#import "NSXNewsViewModel+Provider.h"
#import "NSXNewsViewModelParam.h"
#import "NSXNewsViewModelResult.h"
#import <MJExtension/MJExtension.h>

@interface SectionViewModel : NSObject

@property(copy,nonatomic) NSString *sectionTitleText;
@property(strong,nonatomic)NSArray *sectionDataSource;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

@implementation SectionViewModel

//- (instancetype)initWithDictionary:(NSDictionary *)dic {
//    self = [super init];
//    if (self) {
//        self.sectionTitleText = [self stringConvertToSectionTitleText:dic[@"date"]];
//        NSArray *newsArray = dic[@"newsArray"];
//        NSMutableArray *newsModelList = [NSMutableArray new];
//        for (NSDictionary *newsDict in newsArray) {
////            StoryModel *model = [[StoryModel alloc] initWithDictionary:storyDic];
//            NSXNews *news = [NSXNews  mj_objectWithKeyValues:newsDict];
//            [newsModelList addObject:news];
//        }
//        self.sectionDataSource = newsModelList;
//    }
//    return self;
//}

- (instancetype)initWithViewModel:(NSXNewsViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.sectionTitleText = viewModel.currentLoadDayStr;
//        NSArray *newsArray = viewModel.daysDataList;
//        NSMutableArray *newsModelList = [NSMutableArray new];
//        for (NSXNews *news in newsArray) {
//            //            StoryModel *model = [[StoryModel alloc] initWithDictionary:storyDic];
////            NSXNews *news = [NSXNews  mj_objectWithKeyValues:newsDict];
//            [newsModelList addObject:news];
//        }
        self.sectionDataSource = viewModel.daysDataList;
    }
    return self;
}

- (NSString*)stringConvertToSectionTitleText:(NSString*)str {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:str];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CH"];
    [formatter setDateFormat:@"MM月dd日 EEEE"];
    NSString *sectionTitleText = [formatter stringFromDate:date];
    
    return sectionTitleText;
}

@end

@interface NSXNewsViewModel()


@end

@implementation NSXNewsViewModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"daysDataList" : @"NSXNews",
             @"top_stories" : @"NSXNews",
             };
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"currentLoadDayStr" : @"date",
//             @"newsId" : @"id"
             };
    
}

- (NSUInteger)numberOfSections {
    return self.daysDataList.count;
}

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section {
    SectionViewModel *svm = _daysDataList[section];
    return svm.sectionDataSource.count;
}

- (NSAttributedString *)titleForSection:(NSInteger)section {
    SectionViewModel *svm = _daysDataList[section];
    return [[NSAttributedString alloc] initWithString:svm.sectionTitleText attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18] ,NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (NSXNews *)storyAtIndexPath:(NSIndexPath *)indexPath {
    SectionViewModel *svm = _daysDataList[indexPath.section];
    NSXNews *news = svm.sectionDataSource[indexPath.row];
    return news;
}

//获取最新的新闻
- (void)getLatestStories {
    
    NSLog(@"getLatestStories----------");
    NSXNewsViewModelParam *param = [[NSXNewsViewModelParam alloc] init];
    param.currentLoadDayStr =@"20151226";
    [NSXNewsViewModel newsViewModelWithParam:param success:^(NSXNewsViewModelResult *result) {
        NSXNewsViewModel *viewModel = result.viewModel;
        self.currentLoadDayStr = viewModel.currentLoadDayStr;
        SectionViewModel *vm = [[SectionViewModel alloc] initWithViewModel:viewModel];
        self.daysDataList = [NSMutableArray arrayWithObject:vm];
        self.top_stories = viewModel.top_stories;
        NSDictionary *vmjson = vm.mj_keyValues;
        NSLog(@"%@",vmjson);
        self.newsIdArray = [NSMutableArray arrayWithArray:[vmjson valueForKeyPath:@"sectionDataSource.id"]];

        
        for (NSXNews *news in viewModel.daysDataList) {
            NSLog(@"%@",news.images);
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadLatestDaily" object:nil];

    } failure:^(NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadLatestDaily" object:nil userInfo:@{@"cyl_reloadData":@"cyl_reloadData"}];
    }];
//    NSXNewsViewModelParam *param = [[NSXNewsViewModelParam alloc] init];
//   [NSXNewsViewModel newsViewModelWithParam:param success:^(NSXNewsViewModelResult *result) {
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
    NSXNewsViewModelParam *param = [[NSXNewsViewModelParam alloc] init];

    param.currentLoadDayStr = self.currentLoadDayStr;
    param.currentLoadDayStr =@"20151227";
    [NSXNewsViewModel newsViewModelWithParam:param success:^(NSXNewsViewModelResult *result) {
        NSXNewsViewModel *viewModel = result.viewModel;
        SectionViewModel *newvm = [[SectionViewModel alloc] initWithViewModel:viewModel];
        SectionViewModel *oldvm = _daysDataList[0];
        
        if ([newvm.sectionTitleText isEqualToString:oldvm.sectionTitleText]) {
//            NSArray* new = newvm.sectionDataSource;
//            NSArray* old = oldvm.sectionDataSource;
            if (newvm.sectionDataSource.count>oldvm.sectionDataSource.count) {
                NSUInteger newItemsCount = newvm.sectionDataSource.count-oldvm.sectionDataSource.count;
                for (int i = 1; i <=newItemsCount; i++) {
                    NSXNews *news = newvm.sectionDataSource[newItemsCount-i];
                    [_newsIdArray insertObject:news.newsId atIndex:0];
                }
                [_daysDataList removeObject:oldvm];
                [_daysDataList insertObject:newvm atIndex:0];
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateLatestDaily" object:nil];
        }else {
            self.currentLoadDayStr = viewModel.currentLoadDayStr;
            self.daysDataList = [NSMutableArray arrayWithObject:newvm];
            _newsIdArray = [NSMutableArray arrayWithArray:[newvm valueForKeyPath:@"sectionDataSource.newsId"]];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateLatestDaily" object:nil userInfo:@{@"isNewDay":@(YES)}];
        }
        _isLoading = NO;
        
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
        NSXNewsViewModelParam *param = [[NSXNewsViewModelParam alloc] init];
        param.currentLoadDayStr = self.currentLoadDayStr;
        param.currentLoadDayStr =@"20151225";
       [NSXNewsViewModel newsViewModelWithParam:param success:^(NSXNewsViewModelResult *result) {
           NSXNewsViewModel *viewModel = result.viewModel;
           SectionViewModel *vm = [[SectionViewModel alloc] initWithViewModel:viewModel];
           [self.daysDataList addObject:vm];
           [self.newsIdArray addObjectsFromArray:[vm valueForKeyPath:@"sectionDataSource.newsId"]];
           [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadPreviousDaily" object:nil];
           _isLoading = NO;
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
