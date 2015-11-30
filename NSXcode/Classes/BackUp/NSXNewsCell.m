//
//  NSXHomeCell.m
//  NSXcode
//
//  Created by DexSinis on 15/11/23.
//  Copyright © 2015年 DexSinis. All rights reserved.
//

#import "NSXNewsCell.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+Visuals.h"
#import "UIImageView+WebCache.h"

#import "OSCNews.h"



@implementation NSXNewsCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        [self initSubviews];
        [self setLayout];
    }
    return self;
    
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        
//        
//        
//        
//        
//        UIImageView *view0 = [UIImageView new];
//        view0.image = [UIImage imageNamed:@"iii"];
//        view0.backgroundColor = [UIColor redColor];
//        self.view0 = view0;
//        
//        UILabel *view1 = [UILabel new];
//        view1.backgroundColor = [UIColor grayColor];
//       self.view1 = view1;
//        
//        UILabel *view2 = [UILabel new];
//        view2.backgroundColor = [UIColor brownColor];
//        self.view2 = view2;
//        
//        UILabel *view3 = [UILabel new];
//        view3.backgroundColor = [UIColor orangeColor];
//        self.view3 = view3;
//        
//        UIView *view4 = [UIView new];
//        view4.backgroundColor = [UIColor purpleColor];
//        self.view4 = view4;
//        
//        UIView *view5 = [UIView new];
//        view5.backgroundColor = [UIColor yellowColor];
//        self.view5 = view5;
//        
//        [self.contentView addSubview:self.view0];
//        [self.contentView addSubview:self.view1];
//        [self.contentView addSubview:self.view2];
//        [self.contentView addSubview:self.view3];
//        [self.contentView addSubview:self.view4];
//        [self.contentView addSubview:self.view5];
//        
//        
//        
//        self.view0.sd_layout
//        .widthIs(50)
//        .heightIs(50)
//        .topSpaceToView(self.contentView, 10)
//        .leftSpaceToView(self.contentView, 10);
//        self.view0.layer.cornerRadius = 50/4;
//         self.view0.layer.masksToBounds = YES;
////        [self.view0 cornerRadius:50/4 strokeSize:0 color:nil];
//        
//        self.view1.sd_layout
//        .topEqualToView(self.view0)
//        .leftSpaceToView(self.view0, 10)
//        .rightSpaceToView(self.contentView, 10)
//        .heightRatioToView(self.view0, 0.4);
//        
//        self.view2.sd_layout
//        .topSpaceToView(self.view1, 10)
//        .rightSpaceToView(self.contentView, 60)
//        .leftEqualToView(self.view1)
//        .autoHeightRatio(0);
//        
//        self.view3.sd_layout
//        .topEqualToView(self.view2)
//        .leftSpaceToView(self.view2, 10)
//        .heightRatioToView(self.view2, 1)
//        .rightEqualToView(self.view1);
//        
//        self.view4.sd_layout
//        .leftEqualToView(self.view2)
//        .topSpaceToView(self.view2, 10)
//        .heightIs(30)
//        .widthRatioToView(self.view1, 0.7);
//        
//        self.view5.sd_layout
//        .leftSpaceToView(self.view4, 10)
//        .rightSpaceToView(self.contentView, 10)
//        .bottomSpaceToView(self.contentView, 10)
//        .heightRatioToView(self.view4, 1);
//        
//        
//        //***********************高度自适应cell设置步骤************************
//        
//        [self setupAutoHeightWithBottomView:self.view4 bottomMargin:10];
//        
//    }
//    return self;
}

-(void)initSubviews
{
            UILabel *view0 = [UILabel new];
//            view0.image = [UIImage imageNamed:@"iii"];
            view0.backgroundColor = [UIColor redColor];
            self.view0 = view0;
    
            UILabel *view1 = [UILabel new];
            view1.backgroundColor = [UIColor grayColor];
            view1.lineBreakMode = NSLineBreakByWordWrapping;
            view1.font = [UIFont boldSystemFontOfSize:15];
            self.view1 = view1;
    
            UILabel *view2 = [UILabel new];
            view2.backgroundColor = [UIColor brownColor];
            view2.lineBreakMode = NSLineBreakByWordWrapping;
            view2.font = [UIFont systemFontOfSize:13];
            self.view2 = view2;
    
            UILabel *view3 = [UILabel new];
            view3.backgroundColor = [UIColor orangeColor];
            self.view3 = view3;
    
            UILabel *view4 = [UILabel new];
            view4.backgroundColor = [UIColor purpleColor];
            self.view4 = view4;
    
            UILabel *view5 = [UILabel new];
            view5.backgroundColor = [UIColor yellowColor];
            self.view5 = view5;
    
            [self.contentView addSubview:self.view0];
            [self.contentView addSubview:self.view1];
            [self.contentView addSubview:self.view2];
            [self.contentView addSubview:self.view3];
            [self.contentView addSubview:self.view4];
            [self.contentView addSubview:self.view5];
}


-(void)setLayout
{
            self.view0.sd_layout
            .widthIs(50)
            .heightIs(50)
            .topSpaceToView(self.contentView, 10)
            .leftSpaceToView(self.contentView, 10);
            self.view0.layer.cornerRadius = 50/4;
             self.view0.layer.masksToBounds = YES;
    //        [self.view0 cornerRadius:50/4 strokeSize:0 color:nil];
    
            self.view1.sd_layout
            .topEqualToView(self.view0)
            .leftSpaceToView(self.view0, 10)
            .rightSpaceToView(self.contentView, 10)
            .autoHeightRatio(0);
    
//            .heightRatioToView(self.view0, 0.6);
    
            self.view2.sd_layout
            .topSpaceToView(self.view1, 10)
            .rightSpaceToView(self.contentView, 60)
            .leftEqualToView(self.view1)
            .autoHeightRatio(0);
    
            self.view3.sd_layout
            .topEqualToView(self.view2)
            .leftSpaceToView(self.view2, 10)
            .heightRatioToView(self.view2, 1)
            .rightEqualToView(self.view1);
    
            self.view4.sd_layout
            .leftEqualToView(self.view2)
            .topSpaceToView(self.view2, 10)
            .heightIs(30)
            .widthRatioToView(self.view1, 0.7);
    
            self.view5.sd_layout
            .leftSpaceToView(self.view4, 10)
            .rightSpaceToView(self.contentView, 10)
            .bottomSpaceToView(self.contentView, 10)
            .heightRatioToView(self.view4, 1);
    
    //***********************高度自适应cell设置步骤************************
    
    [self setupAutoHeightWithBottomView:self.view4 bottomMargin:10];
}



-(void)setNews:(OSCNews *)news
{
    _news = news;

    
    // 利用SDWebImage框架加载图片资源
   
//    [self.view0 sd_setImageWithURL:[NSURL URLWithString:menu.albums] placeholderImage:[UIImage imageNamed:@"default"]];
    
    // 设置标题
    self.view1.attributedText = news.attributedTittle;
//    self.view1.text = news.title;
    
    // 设置材料数据
     NSString *str =[NSString stringWithFormat:@"%@,当你的 app 没有提供 3x 的 LaunchImage 时",news.body];
    self.view2.text = str;

    // 设置材料数据
//    self.ingredientsLabel.text = menu.ingredients;
}



@end
