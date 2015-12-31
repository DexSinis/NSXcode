//
//  StoryContentModel.h
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/18.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryContentModel : NSObject

@property(copy,nonatomic)NSString *body;
@property(copy,nonatomic)NSString *image_source;
@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *image;
@property(copy,nonatomic)NSNumber *storyID;
@property(copy,nonatomic)NSArray *css;
@property(copy,nonatomic)NSString *share_url;
@property(strong,nonatomic)NSArray *recommenders;
@property(strong,nonatomic)NSNumber *type;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
