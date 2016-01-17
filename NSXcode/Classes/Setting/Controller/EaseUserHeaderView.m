//
//  EaseUserHeaderView.m
//  Coding_iOS
//
//  Created by Ease on 15/3/17.
//  Copyright (c) 2015年 Coding. All rights reserved.
//
#define kScaleFrom_iPhone5_Desgin(_X_) (_X_ * (kScreenWidth/320))
#define EaseUserHeaderView_Height_Me kScaleFrom_iPhone5_Desgin(190)
#define EaseUserHeaderView_Height_Other kScaleFrom_iPhone5_Desgin(250)
//#define kColorTableBG [UIColor colorWithHexString:@"0xfafafa"]



#import "EaseUserHeaderView.h"
#import <UIImage+BlurredFrame/UIImage+BlurredFrame.h>
#import <Masonry/Masonry.h>
#import <BlocksKit/BlocksKit.h>
#import <BlocksKit/UIControl+BlocksKit.h>
#import "UIColor+expanded.h"
//#import "NSString+Common.h"
@interface EaseUserHeaderView ()

@property (strong, nonatomic) UITapImageView *userIconView, *userSexIconView;
@property (strong, nonatomic) UILabel *userLabel;
@property (strong, nonatomic) UIButton *fansCountBtn, *followsCountBtn, *followBtn;
@property (strong, nonatomic) UIView *splitLine, *coverView;
@property (assign, nonatomic) CGFloat userIconViewWith;
@end


@implementation EaseUserHeaderView

+ (id)userHeaderViewWithUser:(NSXUser *)user image:(UIImage *)image{
    if (!user || !image) {
        return nil;
    }
    EaseUserHeaderView *headerView = [[EaseUserHeaderView alloc] init];
    headerView.userInteractionEnabled = YES;
    headerView.contentMode = UIViewContentModeScaleAspectFill;

    headerView.curUser = user;
    headerView.bgImage = image;
    
    [headerView configUI];
    return headerView;
}

- (void)setCurUser:(NSXUser *)curUser{
    _curUser = curUser;
    [self updateData];
}

- (void)setBgImage:(UIImage *)bgImage{
    _bgImage = bgImage;
    [self updateData];
}

- (void)configUI{
    if (!_curUser) {
        return;
    }
    if (!_coverView) {//遮罩
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        [self addSubview:_coverView];
        [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    
    BOOL isMe = YES;
    //[_curUser.global_key isEqualToString:[Login curLoginUser].global_key];
    CGFloat viewHeight = isMe? EaseUserHeaderView_Height_Me: EaseUserHeaderView_Height_Other;
    [self setFrame:CGRectMake(0, 0, kScreenWidth, viewHeight)];
    __weak typeof(self) weakSelf = self;
    
    if (!_fansCountBtn) {
        _fansCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fansCountBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_fansCountBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.fansCountBtnClicked) {
                weakSelf.fansCountBtnClicked();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_fansCountBtn];
    }
    
    if (!_followsCountBtn) {
        _followsCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _followsCountBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_followsCountBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.followsCountBtnClicked) {
                weakSelf.followsCountBtnClicked();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_followsCountBtn];
    }
    
    if (!_splitLine) {
        _splitLine = [[UIView alloc] init];
        _splitLine.backgroundColor = [UIColor colorWithHexString:@"0xcacaca"];
        [self addSubview:_splitLine];
    }
    
    if (!isMe && !_followBtn) {
        _followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_followBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.followBtnClicked) {
                weakSelf.followBtnClicked();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_followBtn];
    }else{
        _followBtn.hidden = YES;
    }
    
    if (!_userLabel) {
        _userLabel = [[UILabel alloc] init];
        _userLabel.font = [UIFont boldSystemFontOfSize:18];
        _userLabel.textColor = [UIColor whiteColor];
        _userLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_userLabel];
    }
    
    if (!_userIconView) {
        _userIconView = [[UITapImageView alloc] init];
        _userIconView.backgroundColor = [UIColor colorWithHexString:@"0xfafafa"];
        [_userIconView addTapBlock:^(id obj) {
            if (weakSelf.userIconClicked) {
                weakSelf.userIconClicked();
            }
        }];
        [self addSubview:_userIconView];
    }
    
    if (kDevice_Is_iPhone6Plus) {
        _userIconViewWith = 100;
    }else if (kDevice_Is_iPhone6){
        _userIconViewWith = 90;
    }else{
        _userIconViewWith = 75;
    }
    
    if (!_userSexIconView) {
        _userSexIconView = [[UITapImageView alloc] init];
//        [_userIconView doBorderWidth:1.0 color:nil cornerRadius:_userIconViewWith/2];
        [self addSubview:_userSexIconView];
    }
    
    [_fansCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(_splitLine.mas_left).offset(kScaleFrom_iPhone5_Desgin(-15));
        make.bottom.equalTo(self.mas_bottom).offset(kScaleFrom_iPhone5_Desgin(-15));
    }];
    
    [_followsCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.left.equalTo(_splitLine.mas_right).offset(kScaleFrom_iPhone5_Desgin(15));
        make.height.equalTo(@[_fansCountBtn.mas_height, @kScaleFrom_iPhone5_Desgin(20)]);
    }];

    [_splitLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(@[_fansCountBtn, _followsCountBtn]);
        make.size.mas_equalTo(CGSizeMake(0.5, 15));
    }];
    
    if (!isMe) {
        [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_fansCountBtn.mas_top).offset(-20);
            make.size.mas_equalTo(CGSizeMake(128, 39));
            make.centerX.equalTo(self);
        }];

        [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_followBtn.mas_top).offset(kScaleFrom_iPhone5_Desgin(-25));
            make.height.mas_equalTo(kScaleFrom_iPhone5_Desgin(20));
        }];
    }else{
        [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_fansCountBtn.mas_top).offset(kScaleFrom_iPhone5_Desgin(-20));
            make.height.mas_equalTo(kScaleFrom_iPhone5_Desgin(20));
        }];
    }
    
    [_userIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(_userIconViewWith, _userIconViewWith));
        make.bottom.equalTo(_userLabel.mas_top).offset(-15);
        make.centerX.equalTo(self);
    }];
    
    CGFloat userSexIconViewWidth = (14);
    [_userSexIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(userSexIconViewWidth, userSexIconViewWidth));
        
        make.left.equalTo(_userLabel.mas_right).offset(5);
        make.centerY.equalTo(_userLabel);
    }];
    
//    left, right 只是占位，使名字和性别能居中显示
    UIView *left = [[UIView alloc] init], *right = [[UIView alloc] init];
    [self addSubview:left];
    [self addSubview:right];
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(right);
        make.left.equalTo(self);
        make.right.equalTo(_userLabel.mas_left);
    }];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(_userSexIconView.mas_right);
        make.centerY.equalTo(@[_userLabel, left]);
    }];
    
    [self updateData];
}

- (NSMutableAttributedString*)getStringWithTitle:(NSString *)title andValue:(NSString *)value{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", value, title]];
    [attrString addAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:17],
                                 NSForegroundColorAttributeName : [UIColor whiteColor]}
                         range:NSMakeRange(0, value.length)];
    
    [attrString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],
                                 NSForegroundColorAttributeName : [UIColor whiteColor]}
                         range:NSMakeRange(value.length+1, title.length)];
    return  attrString;
}

- (void)updateData{
    if (!_userIconView) {
        return;
    }
    self.image = _bgImage;
    [_userIconView sd_setImageWithURL:_curUser.portraitURL];
    if (_curUser.relationship == 0) {
        //        男
        [_userSexIconView setImage:[UIImage imageNamed:@"n_sex_man_icon"]];
        _userSexIconView.hidden = NO;
    }else if (_curUser.relationship == 1){
        //        女
        [_userSexIconView setImage:[UIImage imageNamed:@"n_sex_woman_icon"]];
        _userSexIconView.hidden = NO;
    }else{
        //        未知
        _userSexIconView.hidden = YES;
    }
    _userLabel.text = _curUser.name;
    [_userLabel sizeToFit];
    
    NSString *fansCount = [NSString stringWithFormat:@"%d",_curUser.fansCount];
    [_fansCountBtn setAttributedTitle:[self getStringWithTitle:@"粉丝" andValue:fansCount] forState:UIControlStateNormal];
    NSString *followersCount = [NSString stringWithFormat:@"%d",_curUser.followersCount];
    [_followsCountBtn setAttributedTitle:[self getStringWithTitle:@"关注" andValue:followersCount] forState:UIControlStateNormal];
    
    NSString *imageName;
    if (_curUser.relationship) {
        if (_curUser.relationship) {
            imageName = @"n_btn_followed_both";
        }else{
            imageName = @"n_btn_followed_yes";
        }
    }else{
        imageName = @"n_btn_followed_not";
    }
    [_followBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}
@end
