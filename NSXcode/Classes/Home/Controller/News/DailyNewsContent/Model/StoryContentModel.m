//
//  StoryContentModel.m
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/18.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import "StoryContentModel.h"

@implementation StoryContentModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"storyID"];
    }
}

@end
