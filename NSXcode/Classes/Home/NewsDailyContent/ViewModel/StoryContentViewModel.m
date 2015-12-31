//
//  StoryContentViewModel.m
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/18.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import "StoryContentViewModel.h"
#import "NSXHttpTool.h"
@implementation StoryContentViewModel

- (NSString *)imageURLString {
    return _storyModel.image;
}

-(NSAttributedString *)titleAttText {

    return [[NSAttributedString alloc] initWithString:_storyModel.title attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:21],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (NSString *)imaSourceText {
    return [NSString stringWithFormat:@"图片: %@",_storyModel.image_source];
}

- (NSString *)htmlStr {
    return [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>",_storyModel.css[0],_storyModel.body];
}
- (NSString *)share_URL {
    return _storyModel.share_url;
}

- (NSNumber *)storyType {
    return _storyModel.type;
}

- (NSArray *)recommenders {
    return _storyModel.recommenders;
}

- (void)getStoryContentWithStoryID:(NSNumber*)storyID {
    NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"newsContentViewModel"];
    [NSXHttpTool post:url params:nil success:^(id responseObj) {
//        NSDictionary *jsonDic = (NSDictionary*)responseObject;
         NSError *error;
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObj options:kNilOptions error:&error];
        StoryContentModel *model = [[StoryContentModel alloc] initWithDictionary:json];
        [self setValue:model forKey:@"storyModel"];
        _loadedStoryID = storyID;
        NSLog(@"%@",storyID);
    } failure:^(NSError *error) {
        
    }];
//    [HttpOperation getRequestWithURL:[NSString stringWithFormat:@"news/%@",[storyID stringValue]] parameters:nil success:^(id responseObject) {
//        NSDictionary *jsonDic = (NSDictionary*)responseObject;
//        StoryContentModel *model = [[StoryContentModel alloc] initWithDictionary:jsonDic];
//        [self setValue:model forKey:@"storyModel"];
//        _loadedStoryID = storyID;
//    } failure:nil];
}

- (void)getPreviousStoryContent {
    NSInteger index = [_storiesID indexOfObject:_loadedStoryID];
    if (--index >= 0) {
//        NSNumber* nextStoryID = [_storiesID objectAtIndex:index];
       NSNumber* nextStoryID = [NSNumber numberWithFloat:[@"7676441" integerValue]];
        //(NSNumber)@"7667220";
        [self getStoryContentWithStoryID:nextStoryID];
    }
}

- (void)getNextStoryContent {
    NSUInteger index = [_storiesID indexOfObject:_loadedStoryID];
    if (++index < _storiesID.count) {
//        NSNumber* nextStoryID = [_storiesID objectAtIndex:index];
        NSNumber* nextStoryID = [NSNumber numberWithFloat:[@"7669499" integerValue]];
        [self getStoryContentWithStoryID:nextStoryID];
    }
}

@end
