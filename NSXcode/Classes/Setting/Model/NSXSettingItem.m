//
//  CYXSettingItem.m
//  
//
//  Created by Macx on 15/9/11.
//  Copyright (c) 2015年 CYX. All rights reserved.
//

#import "NSXSettingItem.h"

@implementation NSXSettingItem

+ (instancetype)itemWithtitle:(NSString *)title{
    
    NSXSettingItem *item = [[NSXSettingItem alloc]init];
    
    item.title = title;
    
    return item;
}

@end
