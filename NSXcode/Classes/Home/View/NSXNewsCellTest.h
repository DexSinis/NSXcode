//
//  NSXHomeCell.h
//  NSXcode
//
//  Created by DexSinis on 15/11/23.
//  Copyright © 2015年 DexSinis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSXNews;

@interface NSXNewsCellTest : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *bodyLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *commentCount;
@property (nonatomic, strong)   UIView *view5;
@property (nonatomic, strong) NSXNews *news;

@end
