//
//  NSXSideViewFooter.m
//  NSXcode
//
//  Created by DexSinis on 15/12/14.
//  Copyright © 2015年 DexSinis. All rights reserved.
//

#import "NSXSideViewFooter.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"
@implementation NSXSideViewFooter
typedef NS_ENUM(NSInteger, NSXButtonType) {
    NSXButtonTypeLogin = 0,                         // no button type
    NSXButtonTypeOther,
    NSXButtonTypeBottom,
    // Deprecated, use UIButtonTypeSystem instead
};
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
        [self setLayout];
    }
    return self;
}

-(void)initSubviews
{
    
    _dayDarkBtn = [self setupBtnWithIcon:@"Menu_Download" title:@"离线" tag:NSXButtonTypeBottom];
    _downloadBtn =[self setupBtnWithIcon:@"Menu_Day" title:@"日间" tag:NSXButtonTypeBottom];

    
    [self addSubview:_dayDarkBtn];
    [self addSubview:_downloadBtn];
    
}


- (void)setLayout
{
    //
    //    for (UIView *view in [self subviews]) {
    //        view.translatesAutoresizingMaskIntoConstraints = NO;
    //    }
    //
    //    NSDictionary *viewsDict = NSDictionaryOfVariableBindings(_loginBtn, _collectionBtn,_messageBtn,_settingBtn);
    //
    //    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_loginBtn]"
    //                                                                 options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
    //                                                                 metrics:nil views:viewsDict]];
    //
    //    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-40.0-[_loginBtn(300@300)]"
    //                                                                 options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
    //                                                                 metrics:nil views:viewsDict]];
    //
    //    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[_collectionBtn]"
    //                                                                 options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
    //                                                                 metrics:nil views:viewsDict]];
    //
    //    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-40.0-[_collectionBtn(60@300)]-10-[_messageBtn(60@400)]-10-[_settingBtn(60@500)]"
    //                                                                 options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
    //                                                                 metrics:nil views:viewsDict]];
    //
    //    [self addConstraint:[NSLayoutConstraint
    //                          constraintWithItem:_loginBtn
    //                          attribute:NSLayoutAttributeCenterX
    //                          relatedBy:NSLayoutRelationEqual
    //                          toItem:self
    //                          attribute:NSLayoutAttributeWidth
    //                          multiplier:1
    //                          constant:0.0]];
    //
    
    [_downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 添加大小约束
//        CGFloat *writh = [UIScreen mainScreen].bounds.size.width/2
        make.size.mas_equalTo(CGSizeMake(120, 40));
        // 添加左、上边距约束（左、上约束都是20）
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(0);
    }];
    
    [_dayDarkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 添加大小约束
        //        CGFloat *writh = [UIScreen mainScreen].bounds.size.width/2
        make.left.equalTo(_downloadBtn.mas_right).offset(10);
        // 添加左、上边距约束（左、上约束都是20）
        make.size.equalTo(_downloadBtn);
        make.top.mas_equalTo(_downloadBtn);
    }];
    
    //    [_collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(20);
    //        make.top.equalTo(50).offset(-50);
    //        make.size.mas_equalTo(CGSizeMake(60, 60));
    ////        make.bottom.and.top.and.width.and.height.equalTo(_loginBtn);
    //
    //    }];
    
    //    [_collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        // 添加右、下边距约束
    //        make.bottom.and.right.mas_equalTo(-20);
    //        // 添加高度约束，让高度等于黑色view
    //        make.height.equalTo(_loginBtn);
    //        // 添加上边距约束（上边距 = 黑色view的下边框 + 偏移量20）
    //        make.top.equalTo(_loginBtn.mas_bottom).offset(20);
    //        // 添加左边距（左边距 = 父容器纵轴中心 + 偏移量0）
    //        make.left.equalTo(s.mas_centerX).offset(0);
    //    }];
    
    //
//    [_collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        // 大小、上边距约束与黑色view相同
//        make.top.equalTo(_loginBtn.mas_bottom);
//        make.size.equalTo(CGSizeMake(60,60));
//        // 添加右边距约束（这里的间距是有方向性的，左、上边距约束为正数，右、下边距约束为负数）
//        make.left.mas_equalTo(20);
//    }];
//    //
//    [_messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        // 大小、上边距约束与黑色view相同
//        make.top.equalTo(_loginBtn.mas_bottom);
//        make.size.equalTo(CGSizeMake(60, 60));
//        // 添加右边距约束（这里的间距是有方向性的，左、上边距约束为正数，右、下边距约束为负数）
//        make.left.mas_equalTo(_collectionBtn.mas_right).offset(20);
//    }];
//    
//    
//    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        // 大小、上边距约束与黑色view相同
//        make.top.equalTo(_loginBtn.mas_bottom);
//        make.size.equalTo(CGSizeMake(60, 60));
//        // 添加右边距约束（这里的间距是有方向性的，左、上边距约束为正数，右、下边距约束为负数）
//        make.left.mas_equalTo(_messageBtn.mas_right).offset(20);
//    }];
    
    
    //
    //    [_collectionBtn makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(self.right).offset(-50);
    //        make.bottom.and.top.and.width.and.height.equalTo(_loginBtn);
    //    }];
    
    //    [blueView makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(self.view.right).offset(-50);
    //        make.bottom.and.top.and.width.and.height.equalTo(redView);
    //    }];
}

- (UIButton *)setupBtnWithIcon:(NSString *)icon title:(NSString *)title tag:(NSInteger)tag
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];//button的类型
//        btn.backgroundColor = [UIColor cyanColor];//button的背景颜色
    
    
    //
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    //    btn.imageEdgeInsets = UIEdgeInsetsMake(5,13,21,btn.titleLabel.bounds.size.width);
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    //    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    if (tag == NSXButtonTypeLogin) {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        //        [btn setTitleEdgeInsets:UIEdgeInsetsMake(50, -btn.titleLabel.bounds.size.width-45, 0, 0)];
    }else if (tag == NSXButtonTypeBottom)
    {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(4, 20, 0, 0)];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    else
    {
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(50, -btn.titleLabel.bounds.size.width-45, 0, 0)];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    
    // 设置间距
    //    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    return btn;
}

@end
