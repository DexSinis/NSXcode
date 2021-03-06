//
//  NSXNewsCellBar.m
//  NSXcode
//
//  Created by DexSinis on 15/11/27.
//  Copyright © 2015年 DexSinis. All rights reserved.
//

#import "NSXNewsCellBar.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"
@implementation NSXNewsCellBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
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

    
    UILabel *view3 = [UILabel new];
    view3.backgroundColor = [UIColor orangeColor];
    view3.font = [UIFont systemFontOfSize:12];
    self.view3 = view3;
    
    UILabel *view4 = [UILabel new];
    view4.backgroundColor = [UIColor purpleColor];
    view4.font = [UIFont systemFontOfSize:12];
    self.view4 = view4;
    
    UILabel *view5 = [UILabel new];
    view5.backgroundColor = [UIColor yellowColor];
    view5.font = [UIFont systemFontOfSize:12];
    self.view5 = view5;

    [self addSubview:self.view3];
    [self addSubview:self.view4];
    [self addSubview:self.view5];
}

- (void)setLayout
{

    //    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_view1]-5-[_view2]"
    //                                                                             options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
    //                                                                             metrics:nil views:viewsDict]];
    //
    //    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_view2]-5-[_view3]-8-|"
    //                                                                             options:NSLayoutFormatAlignAllLeft
    //                                                                             metrics:nil views:viewsDict]];
    
    //    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-30.0-[_view3]-30.0-|"
    //                                                                             options:0 metrics:nil views:viewsDict]];
    //
    
//    for (UIView *view in [self subviews]) {
//        view.translatesAutoresizingMaskIntoConstraints = NO;
//    }
//    
//    NSDictionary *viewsDict = NSDictionaryOfVariableBindings( _view3, _view4, _view5);
//    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_view3]"
//                                                                 options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
//                                                                 metrics:nil views:viewsDict]];
//    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-8.0-[_view3]-10-[_view4]-10-[_view5]"
//                                                                             options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
//                                                                             metrics:nil views:viewsDict]];
    
    
    [_view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 大小、上边距约束与黑色view相同
        make.left.and.top.mas_equalTo(8);
//        make.size.equalTo(CGSizeMake(30,30));
        // 添加右边距约束（这里的间距是有方向性的，左、上边距约束为正数，右、下边距约束为负数）
        //        make.left.mas_equalTo(20);
    }];
    //
    [_view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 大小、上边距约束与黑色view相同
        make.top.equalTo(_view3.mas_top);
//        make.size.equalTo(CGSizeMake(30, 30));
        // 添加右边距约束（这里的间距是有方向性的，左、上边距约束为正数，右、下边距约束为负数）
        make.left.mas_equalTo(_view3.mas_right).offset(10);
    }];
    
    
    [_view5 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 大小、上边距约束与黑色view相同
        make.top.equalTo(_view3.mas_top);
//        make.size.equalTo(CGSizeMake(30, 30));
        // 添加右边距约束（这里的间距是有方向性的，左、上边距约束为正数，右、下边距约束为负数）
        make.left.mas_equalTo(_view4.mas_right).offset(10);
    }];
    
}


@end
