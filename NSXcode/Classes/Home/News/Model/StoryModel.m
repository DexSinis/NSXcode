//
//  StoryModel.m
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/5.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import "StoryModel.h"

@implementation StoryModel

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
    
    if ([key isEqualToString:@"multipic"]) {
        [self setValue:value forKey:@"isMultipic"];
    }
    
}

@end
