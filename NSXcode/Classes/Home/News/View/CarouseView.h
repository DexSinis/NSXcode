//
//  CarouseView.h
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/29.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarouseViewDelegate <NSObject>

- (void)didSelectItemWithTag:(NSInteger)tag;

@end

@interface CarouseView : UIView

@property(strong,nonatomic)NSArray *topStories;
@property(weak,nonatomic) id<CarouseViewDelegate> delegate;

- (void)updateSubViewsOriginY:(CGFloat)value;

@end
