//
//  NSXNewsResult.h
//  NSXcode
//
//  Created by DexSinis on 15/11/30.
//  Copyright © 2015年 DexSinis. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSXNews;
@interface NSXNewsResult : NSObject

/** 微博数组（装着HMStatus模型） */
@property (nonatomic, strong) NSMutableArray *results;

/** 近期的微博总数 */
@property (nonatomic, assign) int total_number;



@end
