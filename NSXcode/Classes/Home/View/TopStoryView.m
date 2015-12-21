//
//  TopStoryView.m
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/25.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import "TopStoryView.h"

@implementation TopStoryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imaView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
        imaView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imaView];
        _imageView = imaView;
        
        UILabel *lab = [[UILabel alloc] init];
        lab.numberOfLines = 0;
        [self addSubview:lab];
        _label = lab;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
