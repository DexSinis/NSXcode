//
//  NSXHomeCell.h
//  NSXcode
//
//  Created by DexSinis on 15/11/23.
//  Copyright © 2015年 DexSinis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OSCNews;

@interface NSXNewsCell : UITableViewCell

@property (strong, nonatomic)  UIImageView *albumsImageView;

@property (strong, nonatomic)  UILabel *titleLable;

@property (strong, nonatomic)  UILabel *ingredientsLabel;

@property (strong, nonatomic) UILabel * view0;
@property (strong, nonatomic) UILabel * view1;
@property (strong, nonatomic) UILabel * view2;
@property (strong, nonatomic) UILabel * view3;
@property (strong, nonatomic) UILabel * view4;
@property (strong, nonatomic) UILabel * view5;

/** 菜单模型 */
@property (strong, nonatomic) OSCNews * news;

@end
