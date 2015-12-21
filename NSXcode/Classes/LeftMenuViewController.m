//
//  LeftMenuViewController.m
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/21.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import "LeftMenuViewController.h"
//#import "TMItemView.h"
//#import "ThemeItemModel.h"
//#import "DailyThemesViewController.h"


@interface LeftMenuViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong,nonatomic) NSMutableArray *subscribedList;
@property (strong,nonatomic) NSMutableArray *othersList;
@property (strong,nonatomic) NSMutableArray *themeItems;

@end

@implementation LeftMenuViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getThemeList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getThemeList {
//    [HttpOperation getRequestWithURL:@"themes" parameters:nil success:^(id responseObject) {
//        NSDictionary *jsonDic = (NSDictionary*)responseObject;
//        _subscribedList = [NSMutableArray array];
//        NSArray *subArr = jsonDic[@"subscribed"];
//        for (NSDictionary *dic in subArr) {
//            ThemeItemModel *model = [[ThemeItemModel alloc] initWithDictionary:dic];
//            [_subscribedList addObject:model];
//        }
//        _othersList = [NSMutableArray array];
//        NSArray *othArr = jsonDic[@"others"];
//        for (NSDictionary *dic in othArr) {
//            ThemeItemModel *model = [[ThemeItemModel alloc] initWithDictionary:dic];
//            [_othersList addObject:model];
//        }
//        [self setMentItems];
//    } failure:nil];
}


- (void)setMentItems {
//    _mainScrollView.contentSize = CGSizeMake(0, (1+_subscribedList.count+_othersList.count)*44.f);
//    TMItemView* homeItem = [[[NSBundle mainBundle] loadNibNamed:@"TMItemView" owner:self options:nil] firstObject];
//    homeItem.frame = CGRectMake(0, 0, _mainScrollView.width, 44);
//    homeItem.menuTitleLb.text = @"首页";
//    homeItem.menuImaView.image = [UIImage imageNamed:@"Menu_Icon_Home"];
//    [homeItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHome:)]];
//    [_mainScrollView addSubview:homeItem];
//    CGFloat tempHeight = homeItem.height;
//    NSMutableArray *themeItems = [NSMutableArray arrayWithArray:_subscribedList];
//    [themeItems addObjectsFromArray:_othersList];
//    for (int i = 0; i<themeItems.count; i++) {
//        TMItemView* itemView = [[[NSBundle mainBundle] loadNibNamed:@"TMItemView" owner:self options:nil] firstObject];
//        itemView.frame = CGRectMake(0, tempHeight, _mainScrollView.width, 44);
//        [itemView.menuImaView removeFromSuperview];
//        [itemView addConstraint:[NSLayoutConstraint constraintWithItem:itemView.menuTitleLb attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:itemView attribute:NSLayoutAttributeLeading multiplier:1 constant:4]];
//        ThemeItemModel *model = themeItems[i];
//        itemView.menuTitleLb.text = model.name;
//        [itemView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectedMenuItem:)]];
//        [itemView setTag:i];
//        [_mainScrollView addSubview:itemView];
//        tempHeight += 44.f;
//    }
//    _themeItems = themeItems;
}

- (void)showHome:(UIGestureRecognizer *)recognizer {
//    AppDelegate *appdele = kAppdelegate;
//    [appdele.mainVC showMainView];
}

- (void)didSelectedMenuItem:(UIGestureRecognizer *)recognizer {
//    ThemeItemModel *model = _themeItems[recognizer.view.tag];
//    DailyThemesViewController *dailyThemeVC = [[DailyThemesViewController alloc] init];
//    dailyThemeVC.themeID = model.themeID;
//    UINavigationController *subNavigationVC = [[UINavigationController alloc] initWithRootViewController:dailyThemeVC];
//    AppDelegate* appdele = kAppdelegate;
//    [appdele.mainVC presentViewController:subNavigationVC animated:YES completion:nil];
}




@end
