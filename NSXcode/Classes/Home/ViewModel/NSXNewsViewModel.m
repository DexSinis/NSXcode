//
//  HomeViewModel.m
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/5.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import "NSXNewsViewModel.h"
#import "NSXNews.h"

@interface SectionViewModel : NSObject

@property(copy,nonatomic)NSString *sectionTitleText;
@property(strong,nonatomic)NSArray *sectionDataSource;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

@implementation SectionViewModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.sectionTitleText = [self stringConvertToSectionTitleText:dic[@"date"]];
        NSArray *newsArray = dic[@"newsArray"];
        NSMutableArray *storyModelList = [NSMutableArray new];
        for (NSDictionary *newsDict in newsArray) {
//            StoryModel *model = [[StoryModel alloc] initWithDictionary:storyDic];
            NSXNews *news = [NSXNews  mj_objectWithKeyValues:newsDict];
            [storyModelList addObject:news];
        }
        self.sectionDataSource = storyModelList;
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

@property(copy,nonatomic)NSString *currentLoadDayStr; //已加载最靠前那一天的日期字符串

@end

@implementation NSXNewsViewModel

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

- (StoryModel *)storyAtIndexPath:(NSIndexPath *)indexPath {
    SectionViewModel *svm = _daysDataList[indexPath.section];
    StoryModel *story = svm.sectionDataSource[indexPath.row];
    return story;
}

//获取最新的新闻
- (void)getLatestStories {
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
//    _isLoading = YES;
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
//    _isLoading = YES;
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
