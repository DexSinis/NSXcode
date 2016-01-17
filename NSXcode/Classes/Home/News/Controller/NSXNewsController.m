//
//  CYXOneViewController.m
//  
//
//  Created by Macx on 15/9/4.
//  Copyright (c) 2015年 CYX. All rights reserved.
//

#import "NSXNewsController.h"
//#import "NSXCell.h"
//#import "NSXNewsCell.h"
#import "XHFeedCell3.h"
#import "NSXMenu.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "NSXNews.h"
//#import "NSXNewsResult.h"
//#import "NSXNewsParam.h"
//#import "NSXNews+provider.h"
#import "NSXNewsViewModel.h"

#import "CarouseView.h"
#import "RefreshView.h"
#import "StoryModel.h"

#import "UIFont+FontAwesome.h"
#import "NSString+FontAwesome.h"
#import "CYLTableViewPlaceHolder.h"
#import "XTNetReloader.h"
#import "UITableView+CYLTableViewPlaceHolder.h"

#import "StoryContentViewModel.h"
#import "StoryContentViewController.h"

#import "UIViewController+MMDrawerController.h"


#define kRowHeight 88.f
#define kSectionHeaderHeight 36.f

@interface NSXNewsController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,CarouseViewDelegate,CYLTableViewPlaceHolderDelegate>


/** 用于加载下一页的参数(页码) */
@property (nonatomic,assign) NSInteger pn;

//@property (strong, nonatomic) NSMutableArray *newsArray;
//@property(assign,readonly,nonatomic)BOOL isLoading;
@property(strong,nonatomic)NSXNewsViewModel *viewModel;

@property(weak,nonatomic)UITableView *mainTableView;
@property(weak,nonatomic)UIView *navBarBackgroundView;
@property(weak,nonatomic)UILabel *newsTodayLb;
@property(weak,nonatomic)CarouseView *carouseView;
@property(weak,nonatomic)RefreshView *refreshView;

@end

@implementation NSXNewsController

- (instancetype)initWithViewModel:(NSXNewsViewModel *)vm {
    self = [super init];
    if (self) {
        self.viewModel = vm;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadingLatestDaily:) name:@"LoadLatestDaily" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadingPreviousDaily:) name:@"LoadPreviousDaily" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLatestDaily:) name:@"UpdateLatestDaily" object:nil];
        [self.viewModel getLatestStories];
    }
    return self;
}

#pragma mark - life cycle 生命周期方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    
  
   
//    [NSXNews newsArrayWithParam:nil success:^(NSXNewsResult *result) {
//        self.newsArray = result.newsArray;
//        [self.mainTableView reloadData];
//         NSLog(@"%@", result.totalNumber);
//        for (NSXNews *news in result.newsArray) {
//             NSLog(@"%@", news.title);
//        }
//       
//    } failure:^(NSError *error) {
//        
//    }];

}


#pragma mark - private methods 私有方法

- (void)setupTable{

    
    UITableView *tv = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    tv.delegate = self;
    tv.dataSource = self;
//    tv.rowHeight = kRowHeight;
    tv.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 220.f)];
    [self.view addSubview:tv];
    _mainTableView = tv;
    
    
    CarouseView *cv = [[CarouseView alloc] initWithFrame:CGRectMake(0.f, -40.f, kScreenWidth, 260.f)];
    cv.delegate = self;
    cv.clipsToBounds = YES;
    [self.view addSubview:cv];
    _carouseView = cv;
    
     [self setTopStoriesContent];
    
    
    //官方版高度没有64,所以加个高度56仿冒NavBar的View,56也配合每个section(36)过渡时的动画
    UIView *navBarBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 56.f)];
    navBarBackgroundView.backgroundColor = [UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:253.f/255.f alpha:0.f];;
    [self.view addSubview:navBarBackgroundView];
    _navBarBackgroundView = navBarBackgroundView;
    
    UILabel *lab = [[UILabel alloc] init];
    lab.attributedText = [[NSAttributedString alloc] initWithString:@"今日新闻" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18] ,NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [lab sizeToFit];
    [lab setCenter:CGPointMake(self.view.centerX, 38)];
    [self.view addSubview:lab];
    _newsTodayLb = lab;
    

    RefreshView *refreshView = [[RefreshView alloc] initWithFrame:CGRectMake(_newsTodayLb.left-20.f, _newsTodayLb.centerY-10, 20.f, 20.f)];
    [self.view addSubview:refreshView];
    _refreshView = refreshView;
    
    
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(16.f, 28.f, 22.f, 22.f)];
    [menuBtn setImage:[UIImage imageNamed:@"Home_Icon"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuBtn];
    

   
    
    
//    // 头部刷新控件
//    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    // 尾部刷新控件
//    self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


- (void)setTopStoriesContent {
   [_carouseView setTopStories:self.viewModel.top_stories];
}



- (void)loadingLatestDaily:(NSNotification *)noti {
    NSLog(@"loadingLatestDaily--------noti");
//    
//    NSDictionary *dict = [noti userInfo];
//    NSString *cyl_reloadData = dict[@"cyl_reloadData"];
//    if ([cyl_reloadData isEqualToString:@"cyl_reloadData"]) {
//        [_mainTableView cyl_reloadData];
//    }else
//    {
    if(self.viewModel.daysDataList.count>0)
    {
    
//        NSIndexSet *indexset = [NSIndexSet indexSetWithIndex: 0];
//        [_mainTableView insertSections:indexset withRowAnimation:UITableViewRowAnimationFade];
        [self setTopStoriesContent];
        [_mainTableView cyl_reloadData];
    }else{
        [_mainTableView cyl_reloadData];
    }
    
//    }
    

}

- (void)loadingPreviousDaily:(NSNotification *)noti {
        NSLog(@"loadingPreviousDaily--------noti");
//    NSDictionary *dict = [noti userInfo];
//    NSString *cyl_reloadData = dict[@"cyl_reloadData"];
//    if ([cyl_reloadData isEqualToString:@"cyl_reloadData"]) {
//        [_mainTableView cyl_reloadData];
//    }else
//    {
//    NSIndexSet *indexset = [NSIndexSet indexSetWithIndex: [self.viewModel numberOfSections]-1];
//    [_mainTableView insertSections:indexset withRowAnimation:UITableViewRowAnimationFade];
//    [_mainTableView cyl_reloadData];
//    }
    if(self.viewModel.daysDataList.count>0)
    {
        [_mainTableView cyl_reloadData];
    }else{
        [_mainTableView cyl_reloadData];
    }
}

- (void)updateLatestDaily:(NSNotification *)noti {
            NSLog(@"updateLatestDaily--------noti");
//    NSDictionary *dict = [noti userInfo];
//    NSString *cyl_reloadData = dict[@"cyl_reloadData"];
//    if ([cyl_reloadData isEqualToString:@"cyl_reloadData"]) {
//        [_mainTableView cyl_reloadData];
//    }else
//    {
//    if (![noti.userInfo[@"isNewDay"] boolValue]) {
//        NSIndexSet *indexset = [NSIndexSet indexSetWithIndex: 0];
//        [_mainTableView reloadSections:indexset withRowAnimation:UITableViewRowAnimationFade];
//        [self setTopStoriesContent];
//    }else {
//        [_mainTableView cyl_reloadData];
//        [self setTopStoriesContent];
//    }
//    }
    
    if(self.viewModel.daysDataList.count>0)
    {
        [_mainTableView cyl_reloadData];
    }else{
        [_mainTableView cyl_reloadData];
    }
}



#pragma mark - CarouseViewDelegate

- (void)didSelectItemWithTag:(NSInteger)tag {
//    StoryModel *story = self.viewmodel.top_stories[tag-100];
//    StoryContentViewModel* vm = [[StoryContentViewModel alloc] init];
//    vm.loadedStoryID = story.storyID;
//    vm.storiesID = _viewmodel.storiesID;
//    StoryContentViewController *storyContentVC = [[StoryContentViewController alloc] initWithViewModel:vm];
//    AppDelegate* appdele = kAppdelegate;
//    [appdele.mainVC.navigationController pushViewController:storyContentVC animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:_mainTableView]) {
        //下拉刷新和navBar的background渐变
        CGFloat offSetY = scrollView.contentOffset.y;
        if (offSetY<=0&&offSetY>=-80) {
            if (-offSetY<=40) {
                if(!self.viewModel.isLoading){
                    [_refreshView redrawFromProgress:-offSetY/40];
                }else{
                    [_refreshView redrawFromProgress:0];
                }
            }
            if (-offSetY>40&&-offSetY<=80&&!scrollView.isDragging&&!self.viewModel.isLoading) {
                [self.viewModel updateLatestStories];
//                [self loadData];
                [_refreshView startAnimation];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [_refreshView stopAnimation];
                });
            }
            _carouseView.frame = CGRectMake(0, -40-offSetY/2, kScreenWidth, 260-offSetY/2);
            [_carouseView updateSubViewsOriginY:offSetY];
            _navBarBackgroundView.backgroundColor = [UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:253.f/255.f alpha:0.f];
        }else if(offSetY<-80){
            _mainTableView.contentOffset = CGPointMake(0.f, -80.f);
        }else if(offSetY <= 300) {
            [_refreshView redrawFromProgress:0];
            _carouseView.frame = CGRectMake(0, -40-offSetY, kScreenWidth, 260);
            _navBarBackgroundView.backgroundColor = [UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:253.f/255.f alpha:offSetY/(220.f-56.f)];
        }
        
        //上拉刷新
        if (offSetY + kRowHeight > scrollView.contentSize.height - kScreenHeight) {
            if (!self.viewModel.isLoading) {
                [_viewModel getPreviousStories];
                [self loadMoreData];
            }
        }
    }
}

#pragma mark - 请求数据方法
/**
 *  发送请求并获取数据方法
 */
- (void)loadData{
    
    NSLog(@"loadData-----------");
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
//    self.pn = 1;
//    // 请求参数（根据接口文档编写）
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"menu"] = @"西红柿";
//    params[@"pn"] = @(self.pn);
//    params[@"rn"] = @"10";
//    params[@"key"] = @"c0caf7b6c19a46fc85f1baf05d214574";
//    
//    // 在AFN的block内使用，防止造成循环引用
//    __weak typeof(self) weakSelf = self;
//    
//    [self.manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
//    
//    [self.manager GET:CYXRequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        NSLog(@"请求成功");
//        
//        // 利用MJExtension框架进行字典转模型
//        weakSelf.menus = [NSXMenu objectArrayWithKeyValuesArray:responseObject[@"result"]];
//        weakSelf.pn ++;
//        // 刷新数据（若不刷新数据会显示不出）
//        [weakSelf.tableView reloadData];
//        [weakSelf.tableView.header endRefreshing];
//    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
//        NSLog(@"请求失败 原因：%@",error);
//        [weakSelf.tableView.header endRefreshing];
//    }];
//    
}
/**
 *  加载更多数据
 */
- (void)loadMoreData{
//       NSLog(@"loadMoreData-----------");
    
//      [self.viewModel getLatestStories];
//
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
//    
//    // 请求参数（根据接口文档编写）
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"menu"] = @"西红柿";
//    params[@"pn"] = @(self.pn);
//    params[@"rn"] = @"10";
//    params[@"key"] = @"2ba215a3f83b4b898d0f6fdca4e16c7c";
//    
//    // 在AFN的block内使用，防止造成循环引用
//    __weak typeof(self) weakSelf = self;
//    
//    [self.manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
//    
//    [self.manager GET:CYXRequestURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        NSLog(@"请求成功");
//        
//        
//        // 利用MJExtension框架进行字典转模型
//        NSArray *array = [NSXMenu objectArrayWithKeyValuesArray:responseObject[@"result"]];
//        [weakSelf.menus addObjectsFromArray:array];
//        
//        weakSelf.pn ++;
//        
//        // 刷新数据（若不刷新数据会显示不出）
//        [weakSelf.tableView reloadData];
//        [weakSelf.tableView.footer endRefreshing];
//    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
//        NSLog(@"请求失败 原因：%@",error);
//        [weakSelf.tableView.footer endRefreshing];
//    }];
//    

    
}

#pragma mark - UITableviewDaasource 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.numberOfSections;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    [self.mainTableView startAutoCellHeightWithCellClass:[NSXNewsCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
//    return self.newsArray.count;
//    return self.menus.count;
  return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSXNews *news = self.newsArray[indexPath.row];
    NSXNews *news = [self.viewModel storyAtIndexPath:indexPath];
    
    static NSString *cellIdentifier = @"FeedCell3";
//    XHFeedCell3* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (!cell) {
     XHFeedCell3*  cell = [[XHFeedCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
    
    
    cell.nameLabel.text = news.title;
    if (news.body.length>60) {
        news.body = [news.body substringToIndex:60];
    }
    cell.updateLabel.text = news.body;
    
    
    NSString *rawString = [NSString stringWithFormat:@"%@ %@", [NSString fontAwesomeIconStringForEnum:FAClockO], @"8 hours ago"];
    if (rawString != nil) {
        NSAttributedString *attributedTime = [[NSAttributedString alloc] initWithString:rawString
                                                                             attributes:@{
                                                                                          NSFontAttributeName: [UIFont fontAwesomeFontOfSize:12],
                                                                                          }];
        
        cell.dateLabel.attributedText = attributedTime;
    }
    else{
        cell.dateLabel.text = rawString;
    }
    
    NSString *likeCountLabelrawString = [NSString stringWithFormat:@"%@ %@", [NSString fontAwesomeIconStringForEnum:FAThumbsOUp], @"293"];
    if (rawString != nil) {
        NSAttributedString *attributedTime = [[NSAttributedString alloc] initWithString:likeCountLabelrawString
                                                                             attributes:@{
                                                                                          NSFontAttributeName: [UIFont fontAwesomeFontOfSize:12],
                                                                                          }];
        
        cell.likeCountLabel.attributedText = attributedTime;
    }
    else{
        cell.likeCountLabel.text = rawString;
    }
    
    NSString *dislikeCountLabelrawString = [NSString stringWithFormat:@"%@ %@", [NSString fontAwesomeIconStringForEnum:FAThumbsODown], @"293"];
    if (rawString != nil) {
        NSAttributedString *attributedTime = [[NSAttributedString alloc] initWithString:dislikeCountLabelrawString
                                                                             attributes:@{
                                                                                          NSFontAttributeName: [UIFont fontAwesomeFontOfSize:12],
                                                                                          }];
        
        cell.dislikeCountLabel.attributedText = attributedTime;
    }
    else{
        cell.dislikeCountLabel.text = rawString;
    }
    
    
    
    //    cell.likeCountLabel.text = @"293 likes";
    
    
    NSString *commentCountLabelrawString = [NSString stringWithFormat:@"%@ %@", [NSString fontAwesomeIconStringForEnum:FAComment], @"555K"];
    if (rawString != nil) {
        NSAttributedString *attributedTime = [[NSAttributedString alloc] initWithString:commentCountLabelrawString
                                                                             attributes:@{
                                                                                          NSFontAttributeName: [UIFont fontAwesomeFontOfSize:12],
                                                                                          }];
        
        cell.commentCountLabel.attributedText = attributedTime;
    }
    else{
        cell.commentCountLabel.text = rawString;
    }
    
    //    cell.commentCountLabel.text = @"555K comments";
    
    //
    //    [button_2 setTitle:[NSString stringWithFormat:@" %@ Delete按钮",iconString] forState:UIControlStateNormal];
    //    [button_2.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:14]];
    //
    //
//    NSString* profileImageName = self.profileImages[indexPath.row%self.profileImages.count];
    [cell.profileImageView sd_setImageWithURL:[NSURL URLWithString:@"http://d05.res.meilishuo.net/pic/_o/9b/5a/f1f34e24c1a89f2799de30894c21_750_750.cj.jpg"]];
//    cell.profileImageView.image = [UIImage imageNamed:@""];
    [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:@"http://d05.res.meilishuo.net/pic/_o/7f/33/64a4d0e9c5cf95e707581e98b7c9_750_750.cj.jpg"]];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return  100;
}

#pragma mark - UITableviewDelegate 代理方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSXNews *news = [self.viewModel storyAtIndexPath:indexPath];
    StoryContentViewModel* vm = [[StoryContentViewModel alloc] init];
    vm.loadedStoryID = news.newsId;
    vm.loadedStoryID = @"7667220";
    vm.storiesID = _viewModel.newsIdArray;
    StoryContentViewController *storyContentVC = [[StoryContentViewController alloc] initWithViewModel:vm];
//    AppDelegate* appdele = kAppdelegate;
    [storyContentVC setHidesBottomBarWhenPushed:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [self.navigationController pushViewController:storyContentVC animated:YES];
    
//    [self.navigationController pushViewController:storyContentVC animated:YES];

}
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

#pragma mark - CYLTableViewPlaceHolderDelegate Method

- (UIView *)makePlaceHolderView {
    UIView *taobaoStyle = [self taoBaoStylePlaceHolder];
    return taobaoStyle;
}

- (UIView *)taoBaoStylePlaceHolder {
    __block XTNetReloader *netReloader = [[XTNetReloader alloc] initWithFrame:CGRectMake(0, 0, 0, 0)
                                                                  reloadBlock:^{
//                                                                      [self.mainTableView.mj_header beginRefreshing];
                                                                 [self.viewModel getLatestStories];
                                                                  }] ;
    return netReloader;
}
- (BOOL)enableScrollWhenPlaceHolderViewShowing
{
    return YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
