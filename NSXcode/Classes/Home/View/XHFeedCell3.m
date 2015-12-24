//
//  XHFeedCell3.m
//  XHFeed
//
//  Created by 曾 宪华 on 13-12-12.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "XHFeedCell3.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#import "NSString+FontAwesome.h"
@implementation XHFeedCell3

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initSubviews];
        [self setLayout];
    }
    return self;
}


-(void)initSubviews
{
    UIColor* mainColor = [UIColor colorWithRed:28.0/255 green:158.0/255 blue:121.0/255 alpha:1.0f];
    UIColor* neutralColor = [UIColor colorWithWhite:0.4 alpha:1.0];
    
    UIColor* mainColorLight = [UIColor colorWithRed:28.0/255 green:158.0/255 blue:121.0/255 alpha:0.4f];
    UIColor* lightColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    
    NSString* fontName = @"Avenir-Book";
    NSString* boldItalicFontName = @"Avenir-BlackOblique";
    NSString* boldFontName = @"Avenir-Black";
    
    _profileImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    _cellImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _cellImageView.backgroundColor =[UIColor redColor];
    //        _profileImageView.layer.cornerRadius = 10.0f;
    
    UIFont *nameLabelFont = [UIFont fontWithName:boldFontName size:(isIpad ? 35.0f : 12.0f)];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nameLabel.textColor =  mainColor;
    _nameLabel.font = nameLabelFont;
    
    UIFont *updateLabelFont = [UIFont fontWithName:fontName size:(isIpad ? 26.0f : 13.0f)];
    _updateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _updateLabel.numberOfLines = 0;
    _updateLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _updateLabel.textColor =  neutralColor;
    _updateLabel.font = updateLabelFont;
    
    UIFont *dateLabelFont = [UIFont fontWithName:fontName size:(isIpad ? 24.0f : 12.0f)];
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _dateLabel.textAlignment = NSTextAlignmentRight;
    _dateLabel.textColor = lightColor;
    _dateLabel.font =  dateLabelFont;
    
    UIFont *countLabelFont = [UIFont fontWithName:boldItalicFontName size:(isIpad ? 20.0f : 10.0f)];
    _commentCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _commentCountLabel.textColor = mainColorLight;
    _commentCountLabel.font = countLabelFont;
    
    _likeCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _likeCountLabel.textColor = mainColorLight;
    _likeCountLabel.font = countLabelFont;
    
    _dislikeCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _dislikeCountLabel.textColor = mainColorLight;
    _dislikeCountLabel.font = countLabelFont;
    
    [self addSubview:self.profileImageView];
    [self addSubview:self.cellImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.updateLabel];
    [self addSubview:self.commentCountLabel];
    [self addSubview:self.likeCountLabel];
    [self addSubview:self.dateLabel];
    [self addSubview:self.dislikeCountLabel];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
-(void)setLayout
{
    
    
#define profileImageViewX (isIpad ? 40 :20)
#define profileImageViewY (isIpad ? 22 :11)
#define profileImageViewSize (isIpad ? 80 :40)
    
#define nameLabelX (isIpad ? 170 : 68)
#define nameLabelWidth (isIpad ? 432 : 216)
#define nameLabelHeight (isIpad ? 42 : 21)
    
    // 内容的
#define updateLabelY (isIpad ? 64 : 32)
#define updateLabelWidth (isIpad ? 550 : 238)
#define updateLabelHeight (isIpad ? 120 : 60)
    
#define commentCountLabelY (isIpad ? 186 : 93)
#define commentCountLabelWidth (isIpad ? 160 : 77)
#define commentCountLabelHeight (isIpad ? 42 : 21)
    
#define likeCountLabelSpeator (isIpad ? 60 : 10)
    
#define dateLabelSpeator (isIpad ? 10 : 5)
//    
//    _profileImageView.frame = CGRectMake(profileImageViewX, profileImageViewY, profileImageViewSize, profileImageViewSize);
//    _nameLabel.frame = CGRectMake(nameLabelX, _profileImageView.frame.origin.y, nameLabelWidth, nameLabelHeight);
//    _updateLabel.frame = CGRectMake(_nameLabel.frame.origin.x, updateLabelY, updateLabelWidth, updateLabelHeight);
//    _commentCountLabel.frame = CGRectMake(_nameLabel.frame.origin.x, commentCountLabelY, commentCountLabelWidth, commentCountLabelHeight);
//    _likeCountLabel.frame = CGRectMake(_commentCountLabel.frame.origin.x + _commentCountLabel.frame.size.width + likeCountLabelSpeator, _commentCountLabel.frame.origin.y, _commentCountLabel.frame.size.width, _commentCountLabel.frame.size.height);
//    _dateLabel.frame = CGRectMake(_likeCountLabel.frame.origin.x + _likeCountLabel.frame.size.width + dateLabelSpeator, _commentCountLabel.frame.origin.y, _commentCountLabel.frame.size.width, _commentCountLabel.frame.size.height);
    
    
    [_cellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 大小、上边距约束与黑色view相同
        make.top.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        make.size.equalTo(CGSizeMake(75,50));
        // 添加右边距约束（这里的间距是有方向性的，左、上边距约束为正数，右、下边距约束为负数）
        //        make.left.mas_equalTo(20);
    }];

    
    
    [_updateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 大小、上边距约束与黑色view相同
                make.left.and.top.mas_equalTo(8);
//        make.top.equalTo(_profileImageView.mas_bottom).offset(8);
        make.right.mas_equalTo(_cellImageView.mas_left);
        make.left.mas_equalTo(8);
        // 添加右边距约束（这里的间距是有方向性的，左、上边距约束为正数，右、下边距约束为负数）
        //        make.left.mas_equalTo(self.view2.mas_right).offset(10);
    }];
    
    
  
    
    [ _commentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 大小、上边距约束与黑色view相同
        make.top.equalTo(_cellImageView.mas_bottom).offset(5);
        make.left.mas_equalTo(8);
        
        // 添加右边距约束（这里的间距是有方向性的，左、上边距约束为正数，右、下边距约束为负数）
        //        make.left.mas_equalTo(self.view2.mas_right).offset(10);
    }];
    
    [_likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_commentCountLabel.mas_top);
        make.left.mas_equalTo(_commentCountLabel.mas_right).offset(8);
       
    }];
    
    
    [_dislikeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_commentCountLabel.mas_top);
        make.left.mas_equalTo(_likeCountLabel.mas_right).offset(8);
        
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 大小、上边距约束与黑色view相同
        make.top.equalTo(_nameLabel.mas_top);
        make.right.mas_equalTo(-8);
//        make.left.mas_equalTo(_commentCountLabel.mas_right).offset(8);
        // 添加右边距约束（这里的间距是有方向性的，左、上边距约束为正数，右、下边距约束为负数）
        //        make.left.mas_equalTo(self.view2.mas_right).offset(10);
    }];
    
    
    [_profileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 大小、上边距约束与黑色view相同
        make.top.mas_equalTo(_likeCountLabel.mas_bottom).offset(8);
        make.left.mas_equalTo(8);
        make.size.equalTo(CGSizeMake(15,15));
        // 添加右边距约束（这里的间距是有方向性的，左、上边距约束为正数，右、下边距约束为负数）
        //        make.left.mas_equalTo(20);
    }];
    

    //
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 大小、上边距约束与黑色view相同
        make.top.equalTo(_profileImageView.mas_top);
        make.left.mas_equalTo(_profileImageView.mas_right).offset(8);
        //        make.right.mas_equalTo(-8);
        //        make.size.equalTo(CGSizeMake(60, 60));
        // 添加右边距约束（这里的间距是有方向性的，左、上边距约束为正数，右、下边距约束为负数）
        //        make.left.mas_equalTo(self.view1.mas_right).offset(10);
    }];
    
 }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
