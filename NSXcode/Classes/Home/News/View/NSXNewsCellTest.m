//
//  NSXHomeCell.m
//  NSXcode
//
//  Created by DexSinis on 15/11/23.
//  Copyright © 2015年 DexSinis. All rights reserved.
//

#import "NSXNewsCellTest.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
//#import "UIView+Visuals.h"
#import "UIImageView+WebCache.h"

#import "NSXNews.h"



@implementation NSXNewsCellTest


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        [self initSubviews];
        [self setLayout];
    }
    return self;
}


- (void)initSubviews
{
    self.titleLabel = [UILabel new];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    self.titleLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.bodyLabel = [UILabel new];
    self.bodyLabel.numberOfLines = 0;
    self.bodyLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.bodyLabel.font = [UIFont systemFontOfSize:13];
    self.bodyLabel.textColor = [UIColor grayColor];
    self.bodyLabel.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:self.bodyLabel];
    
    self.authorLabel = [UILabel new];
    self.authorLabel.font = [UIFont systemFontOfSize:12];
    self.authorLabel.textColor = [UIColor blueColor];
    self.bodyLabel.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:self.authorLabel];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.timeLabel];
    
    self.commentCount = [UILabel new];
    self.commentCount.font = [UIFont systemFontOfSize:12];
    self.commentCount.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.commentCount];
    
    
    UIView *view5 = [UIView new];
    view5.backgroundColor = [UIColor yellowColor];
    self.view5 = view5;
    [self.contentView addSubview:self.view5];
}

- (void)setLayout
{
//    for (UIView *view in [self.contentView subviews]) {
//        view.translatesAutoresizingMaskIntoConstraints = NO;
//    }
//    
//    NSDictionary *viewsDict = NSDictionaryOfVariableBindings(_titleLabel, _bodyLabel, _authorLabel, _timeLabel, _commentCount);
//    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_titleLabel]-5-[_bodyLabel]"
//                                                                             options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
//                                                                             metrics:nil views:viewsDict]];
//    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bodyLabel]-5-[_authorLabel]-8-|"
//                                                                             options:NSLayoutFormatAlignAllLeft
//                                                                             metrics:nil views:viewsDict]];
//    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-8-[_titleLabel]-8-|"
//                                                                             options:0 metrics:nil views:viewsDict]];
//    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_authorLabel]-10-[_timeLabel]-10-[_commentCount]"
//                                                                             options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
//                                                                             metrics:nil views:viewsDict]];

    
    self.titleLabel.sd_layout
    .widthIs(50)
    .heightIs(50)
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10);
    self.titleLabel.layer.cornerRadius = 50/4;
    self.titleLabel.layer.masksToBounds = YES;
    //        [self.titleLabel cornerRadius:50/4 strokeSize:0 color:nil];
    
    self.authorLabel.sd_layout
    .topEqualToView(self.titleLabel)
    .leftSpaceToView(self.titleLabel, 10)
    .rightSpaceToView(self.contentView, 10)
    .heightRatioToView(self.titleLabel, 0.4);
    
    self.authorLabel.sd_layout
    .topSpaceToView(self.authorLabel, 10)
    .rightSpaceToView(self.contentView, 60)
    .leftEqualToView(self.authorLabel)
    .autoHeightRatio(0);
    
    self.timeLabel.sd_layout
    .topEqualToView(self.authorLabel)
    .leftSpaceToView(self.authorLabel, 10)
    .heightRatioToView(self.authorLabel, 1)
    .rightEqualToView(self.authorLabel);
    
    self.commentCount.sd_layout
    .leftEqualToView(self.authorLabel)
    .topSpaceToView(self.authorLabel, 10)
    .heightIs(30)
    .widthRatioToView(self.authorLabel, 0.7);
    
    self.view5.sd_layout
    .leftSpaceToView(self.commentCount, 10)
    .rightSpaceToView(self.contentView, 10)
    .bottomSpaceToView(self.contentView, 10)
    .heightRatioToView(self.commentCount, 1);
}

//-(void)setNews:(NSXNews *)news
//{
//    _news = news;
//    [self.titleLabel setAttributedText:news.attributedTittle];
//    [self.bodyLabel setText:news.body];
//    [self.authorLabel setText:news.author];
//     self.titleLabel.textColor = [UIColor blackColor];
//    [self.timeLabel setText:@"today"];
//    [self.commentCount setAttributedText:news.attributedCommentCount];
//}


@end
