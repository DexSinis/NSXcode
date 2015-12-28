//
//  CYXTabBarController.m
//   
//
//  Created by Macx on 15/9/4.
//  Copyright (c) 2015年 CYX. All rights reserved.
//

#import "NSXTabBarController.h"
#import "NSXNewsController.h"
#import "NSXMessageController.h"
#import "NSXSearchController.h"
#import "NSXSettingController.h"


#import "DemoVC3.h"
#import "WBStatusTimelineViewController.h"
#import "T1HomeTimelineItemsViewController.h"
#import "UIView+Util.h"
#import "UIImage+Util.h"
#import "UIColor+Util.h"
#import "NSXOptionButton.h"
//#import "SwipableViewController.h"
#import "NewsViewController.h"
#import "NSXNavigationController.h"
#import "NSXNavigationBarSearchViewController.h"

#import "HomepageViewController.h"

#import "LogInViewController.h"
#import "NSXNewsViewModel.h"

@interface NSXTabBarController ()  <UITabBarControllerDelegate,UISearchBarDelegate>
{
//    NSXHomeController *oneVC;
//    NSXMessageController *twoVC;
//    NSXSearchController *threeVC;
//    NSXSettingController *fourVC ;
    NewsViewController *newsViewCtl;
    NewsViewController *hotNewsViewCtl;
    NSXNewsController *blogViewCtl;
    NSXNewsController *recommendBlogViewCtl;
    
    NSXSettingController *newTweetViewCtl;
    NSXSettingController *hotTweetViewCtl;
    NSXSettingController *myTweetViewCtl;
}
@property (nonatomic, strong) UIView *dimView;
@property (nonatomic, strong) UIImageView *blurView;
@property (nonatomic, assign) BOOL isPressed;
@property (nonatomic, strong) NSMutableArray *optionButtons;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGGlyph length;

@property (nonatomic, strong) UIPanGestureRecognizer *leftSwipe;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percent;


@end

@implementation NSXTabBarController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dawnAndNightMode:) name:@"dawnAndNight" object:nil];
}

- (void)dawnAndNightMode:(NSNotification *)center
{

    newsViewCtl.view.backgroundColor = [UIColor themeColor];
    hotNewsViewCtl.view.backgroundColor = [UIColor themeColor];
    blogViewCtl.view.backgroundColor = [UIColor themeColor];
    recommendBlogViewCtl.view.backgroundColor = [UIColor themeColor];
    
    newTweetViewCtl.view.backgroundColor = [UIColor themeColor];
    hotTweetViewCtl.view.backgroundColor = [UIColor themeColor];
    myTweetViewCtl.view.backgroundColor = [UIColor themeColor];

    
    [[UINavigationBar appearance] setBarTintColor:[UIColor navigationbarColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor titleBarColor]];
    
    [self.viewControllers enumerateObjectsUsingBlock:^(UINavigationController *nav, NSUInteger idx, BOOL *stop) {
        if (idx == 0) {
//            SwipableViewController *newsVc = nav.viewControllers[0];
//            [newsVc.titleBar setTitleButtonsColor];
//            [newsVc.viewPager.controllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                UITableViewController *table = obj;
//                [table.navigationController.navigationBar setBarTintColor:[UIColor navigationbarColor]];
//                [table.tabBarController.tabBar setBarTintColor:[UIColor titleBarColor]];
//                [table.tableView reloadData];
//            }];
            
        } else if (idx == 1) {
//            SwipableViewController *tweetVc = nav.viewControllers[0];
//            [tweetVc.titleBar setTitleButtonsColor];
//            [tweetVc.viewPager.controllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                UITableViewController *table = obj;
//                [table.navigationController.navigationBar setBarTintColor:[UIColor navigationbarColor]];
//                [table.tabBarController.tabBar setBarTintColor:[UIColor titleBarColor]];
//                [table.tableView reloadData];
//            }];
            
        } else if (idx == 3) {
//            DiscoverViewController *dvc = nav.viewControllers[0];
//            [dvc.navigationController.navigationBar setBarTintColor:[UIColor navigationbarColor]];
//            [dvc.tabBarController.tabBar setBarTintColor:[UIColor titleBarColor]];
//            [dvc dawnAndNightMode];
        } else if (idx == 4) {
//            HomepageViewController *homepageVC = nav.viewControllers[0];
//            [homepageVC.navigationController.navigationBar setBarTintColor:[UIColor navigationbarColor]];
//            [homepageVC.tabBarController.tabBar setBarTintColor:[UIColor titleBarColor]];
//            [homepageVC dawnAndNightMode];
        }
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIViewController *c1=[[UIViewController alloc]init];
//    c1.view.backgroundColor=[UIColor grayColor];
//    c1.view.backgroundColor=[UIColor greenColor];
//    c1.tabBarItem.title=@"消息";
//    c1.tabBarItem.image=[UIImage imageNamed:@"tab_recent_nor"];
//    c1.tabBarItem.badgeValue=@"123";
//    
//    UIViewController *c2=[[UIViewController alloc]init];
//    c2.view.backgroundColor=[UIColor brownColor];
//    c2.tabBarItem.title=@"联系人";
//    c2.tabBarItem.image=[UIImage imageNamed:@"tab_buddy_nor"];
//    
//    UIViewController *c3=[[UIViewController alloc]init];
//    c3.tabBarItem.title=@"动态";
//    c3.tabBarItem.image=[UIImage imageNamed:@"tab_qworld_nor"];
//    
//    UIViewController *c4=[[UIViewController alloc]init];
//    c4.tabBarItem.title=@"设置";
//    c4.tabBarItem.image=[UIImage imageNamed:@"tab_me_nor"];
    
    
    //c.添加子控制器到ITabBarController中
    //c.1第一种方式
    //    [tb addChildViewController:c1];
    //    [tb addChildViewController:c2];
    
    //c.2第二种方式
//    self.viewControllers=@[c1,c2,c3,c4];


//    [self setUpAllChildViewController];

     self.delegate = self;

    newsViewCtl = [[NewsViewController alloc]  initWithNewsListType:NewsListTypeNews];
    hotNewsViewCtl = [[NewsViewController alloc]  initWithNewsListType:NewsListTypeAllTypeWeekHottest];
    
//    UIViewController *testVc = [[UIViewController alloc] init];
////    testVc.view.backgroundColor = [UIColor blueColor];
//    
//    SwipableViewController *newsSVC = [[SwipableViewController alloc] initWithTitle:@"综合"
//                                                                       andSubTitles:@[@"资讯", @"热点", @"博客", @"推荐"]
//                                                                     andControllers:@[newsViewCtl, hotNewsViewCtl]
//                                                                        underTabbar:YES];
//    
//    SwipableViewController *tweetsSVC = [[SwipableViewController alloc] initWithTitle:@"动弹"
//                                                                         andSubTitles:@[@"最新动弹", @"热门动弹", @"我的动弹"]
//                                                                       andControllers:@[newsViewCtl, hotNewsViewCtl]
//                                                                          underTabbar:YES];
    
    // 1.添加第一个控制器
    NSXNewsController *oneVc = [[NSXNewsController alloc]initWithViewModel:[NSXNewsViewModel new]];
    UINavigationController *oneNav = [[UINavigationController alloc]initWithRootViewController:oneVc];
    
    // 2.添加第2个控制器
    NSXMessageController *twoVc = [[NSXMessageController alloc]init];
    UINavigationController *twoNav = [[UINavigationController alloc]initWithRootViewController:twoVc];
    
    // 3.添加第3个控制器
    NSXSearchController *threeVc = [[NSXSearchController alloc]init];
//    [self setUpOneChildViewController:discoverVc image:[UIImage imageNamed:@"qw"] title:@"博文"];
    
    UINavigationController *threeNav = [[UINavigationController alloc]initWithRootViewController:threeVc];
    
    
    // 4.添加第4个控制器
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"NSXSettingController" bundle:nil];
    
    NSXSettingController *fourVc = [storyBoard instantiateInitialViewController];
    
    
//    CGRect frame = CGRectMake(150, 200, 150, 50);
//    NSString *label = @"JTFadingInfoView!";
//    JTFadingInfoView *infoView = [[JTFadingInfoView alloc] initWithFrame:frame
//                                                                   label:label];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"LoginRegist" bundle:nil];
    LogInViewController *fourNav = [mainStoryboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
    
//    LogInViewController *logInDemoVC = [[LogInViewController alloc] init];
//    [self.view addSubview:infoView];
    
//    UINavigationController *fourNav = [[UINavigationController alloc]initWithRootViewController:fourVc];
    
//    
//    UIStoryboard *homepageSB = [UIStoryboard storyboardWithName:@"Homepage" bundle:nil];
//    HomepageViewController *fourNav = [homepageSB instantiateViewControllerWithIdentifier:@"HomepageViewController"];
    
//    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Homepage" bundle:nil];
//    HomepageViewController *fourNav = [mainStoryboard instantiateViewControllerWithIdentifier:@"HomepageViewController"];
    
    //    CYXFourViewController *fourVC = [[CYXFourViewController alloc]init];
    
//    [self setUpOneChildViewController:homepageNav image:[UIImage imageNamed:@"user"] title:@"设置"];
    
    
    self.viewControllers = @[
//                             [self addNavigationItemForViewController:oneVc],
                             oneVc,
                             [self addNavigationItemForViewController:twoVc],
                             [UIViewController new],
                             [self addNavigationItemForViewController:threeVc],
//                             [self addNavigationItemForViewController:fourVc],
                             fourNav
                             ];
    
    NSArray *titles = @[@"综合", @"动弹", @"", @"发现", @"我"];
    NSArray *images = @[@"tabbar-news", @"tabbar-tweet", @"", @"tabbar-discover", @"tabbar-me"];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitle:titles[idx]];
        [item setImage:[UIImage imageNamed:images[idx]]];
        [item setSelectedImage:[UIImage imageNamed:[images[idx] stringByAppendingString:@"-selected"]]];
    }];
    
    [self.tabBar.items[2] setEnabled:NO];
    
    [self addCenterButtonWithImage:[UIImage imageNamed:@"tabbar-more"]];
    
    [self.tabBar addObserver:self
                  forKeyPath:@"selectedItem"
                     options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                     context:nil];
    
    _optionButtons = [NSMutableArray new];
    _screenHeight = [UIScreen mainScreen].bounds.size.height;
    _screenWidth  = [UIScreen mainScreen].bounds.size.width;
    _length = 60;        // 圆形按钮的直径
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    NSArray *buttonTitles = @[@"文字", @"相册", @"拍照", @"语音", @"扫一扫", @"找人"];
    NSArray *buttonImages = @[@"tweetEditing", @"picture", @"shooting", @"sound", @"scan", @"search"];
    int buttonColors[] = {0xe69961, 0x0dac6b, 0x24a0c4, 0xe96360, 0x61b644, 0xf1c50e};
    
    for (int i = 0; i < 6; i++) {
        NSXOptionButton *optionButton = [[NSXOptionButton alloc] initWithTitle:buttonTitles[i]
                                                                   image:[UIImage imageNamed:buttonImages[i]]
                                                                andColor:[UIColor colorWithHex:buttonColors[i]]];
        
        optionButton.frame = CGRectMake((_screenWidth/6 * (i%3*2+1) - (_length+16)/2),
                                        _screenHeight + 150 + i/3*100,
                                        _length + 16,
                                        _length + [UIFont systemFontOfSize:14].lineHeight + 24);
        [optionButton.button setCornerRadius:_length/2];
        
        optionButton.tag = i;
        optionButton.userInteractionEnabled = YES;
        [optionButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapOptionButton:)]];
        
        [self.view addSubview:optionButton];
        [_optionButtons addObject:optionButton];
    }
}

-(void)dealloc
{
     [self.tabBar removeObserver:self forKeyPath:@"selectedItem"];
}

-(void)addCenterButtonWithImage:(UIImage *)buttonImage
{
    _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGPoint origin = [self.view convertPoint:self.tabBar.center toView:self.tabBar];
    CGSize buttonSize = CGSizeMake(self.tabBar.frame.size.width / 5 - 6, self.tabBar.frame.size.height - 4);
    
    _centerButton.frame = CGRectMake(origin.x - buttonSize.height/2, origin.y - buttonSize.height/2, buttonSize.height, buttonSize.height);
    
    [_centerButton setCornerRadius:buttonSize.height/2];
    [_centerButton setBackgroundColor:[UIColor colorWithHex:0x24a83d]];
    [_centerButton setImage:buttonImage forState:UIControlStateNormal];
    [_centerButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabBar addSubview:_centerButton];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"selectedItem"]) {
        if(self.isPressed) {[self buttonPressed];}
    }
}


/**
 *  添加所有子控制器
 */
- (void)setUpAllChildViewController{
    // 1.添加第一个控制器
    NSXNewsController *oneVC = [[NSXNewsController alloc]init];
//    WBStatusTimelineViewController *oneVC = [[WBStatusTimelineViewController alloc] init];
    
//        T1HomeTimelineItemsViewController *oneVC = [[T1HomeTimelineItemsViewController alloc] init];
//    DemoVC3 *oneVC = [[DemoVC3 alloc] init];
    [self setUpOneChildViewController:oneVC image:[UIImage imageNamed:@"tab_home_icon"] title:@"首页"];
    
    // 2.添加第2个控制器
    NSXMessageController *twoVC = [[NSXMessageController alloc]init];
    [self setUpOneChildViewController:twoVC image:[UIImage imageNamed:@"js"] title:@"技术"];
    
    
    // .添加中间控制器
    NSXMessageController *centerVC = [[NSXMessageController alloc]init];
    [self setUpOneChildViewController:centerVC image:[UIImage imageNamed:@"tabbar-more"] title:@"center"];
    
    
    // 3.添加第3个控制器
    NSXSearchController *threeVC = [[NSXSearchController alloc]init];
    [self setUpOneChildViewController:threeVC image:[UIImage imageNamed:@"qw"] title:@"博文"];
    
    // 4.添加第4个控制器
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"NSXSettingController" bundle:nil];
    
    NSXSettingController *fourVC = [storyBoard instantiateInitialViewController];
//    CYXFourViewController *fourVC = [[CYXFourViewController alloc]init];

    [self setUpOneChildViewController:fourVC image:[UIImage imageNamed:@"user"] title:@"设置"];
}


/**
 *  添加一个子控制器的方法
 */
- (void)setUpOneChildViewController:(UIViewController *)viewController image:(UIImage *)image title:(NSString *)title{
    
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:viewController];
    navC.title = title;
    navC.tabBarItem.image = image;
    [navC.navigationBar setBackgroundImage:[UIImage imageNamed:@"commentary_num_bg"] forBarMetrics:UIBarMetricsDefault];

    [self addChildViewController:viewController];
}


#pragma mark -

- (UINavigationController *)addNavigationItemForViewController:(UIViewController *)viewController
{
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    viewController.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar-sidebar"]
                                                                                        style:UIBarButtonItemStylePlain
                                                                                       target:self action:@selector(onClickMenuButton)];
    
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                                     target:self
                                                                                                     action:@selector(pushSearchViewController)];
    
    
    
    return navigationController;
}


- (void)onClickMenuButton
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

#pragma mark - 处理左右navigationItem点击事件

- (void)pushSearchViewController
{
    [(UINavigationController *)self.selectedViewController pushViewController:[NSXNavigationBarSearchViewController new] animated:NO];
//    [self setupSearchView];
}



//
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//
//    
//    [self buttonPressed];
//    NSLog(@"%@",viewController);
//}
//



- (void)buttonPressed
{
    [self changeTheButtonStateAnimatedToOpen:_isPressed];
    
    _isPressed = !_isPressed;
}


- (void)changeTheButtonStateAnimatedToOpen:(BOOL)isPressed
{
    if (isPressed) {
        [self removeBlurView];
        
        [_animator removeAllBehaviors];
        for (int i = 0; i < 6; i++) {
            UIButton *button = _optionButtons[i];
            
            UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:button
                                                                         attachedToAnchor:CGPointMake(_screenWidth/6 * (i%3*2+1),
                                                                                                      _screenHeight + 200 + i/3*100)];
            attachment.damping = 0.65;
            attachment.frequency = 4;
            attachment.length = 1;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC * (6 - i)), dispatch_get_main_queue(), ^{
                [_animator addBehavior:attachment];
            });
        }
    } else {
        [self addBlurView];
        
        [_animator removeAllBehaviors];
        for (int i = 0; i < 6; i++) {
            UIButton *button = _optionButtons[i];
            [self.view bringSubviewToFront:button];
            
            UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:button
                                                                         attachedToAnchor:CGPointMake(_screenWidth/6 * (i%3*2+1),
                                                                                                      _screenHeight - 200 + i/3*100)];
            attachment.damping = 0.65;
            attachment.frequency = 4;
            attachment.length = 1;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.02 * NSEC_PER_SEC * (i + 1)), dispatch_get_main_queue(), ^{
                [_animator addBehavior:attachment];
            });
        }
    }
}

- (void)addBlurView
{
   [self.tabBar.items[2] setEnabled:NO];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGRect cropRect = CGRectMake(0, screenSize.height - 270, screenSize.width, screenSize.height);
    
    UIImage *originalImage = [self.view updateBlur];
    UIImage *croppedBlurImage = [originalImage cropToRect:cropRect];
    
    _blurView = [[UIImageView alloc] initWithImage:croppedBlurImage];
    _blurView.frame = cropRect;
    _blurView.userInteractionEnabled = YES;
    [self.view addSubview:_blurView];
    
    _dimView = [[UIView alloc] initWithFrame:self.view.bounds];
    _dimView.backgroundColor = [UIColor blackColor];
    _dimView.alpha = 0.4;
    [self.view insertSubview:_dimView belowSubview:self.tabBar];
    
    [_blurView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPressed)]];
    [_dimView  addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPressed)]];
    
    [UIView animateWithDuration:0.25f
                     animations:nil
                     completion:^(BOOL finished) {
                         if (finished) {self.tabBar.items[2].enabled = YES;}
                     }];
}

- (void)removeBlurView
{
    self.tabBar.items[2].enabled = NO;
    
    self.view.alpha = 1;
    [UIView animateWithDuration:0.25f
                     animations:nil
                     completion:^(BOOL finished) {
                         if(finished) {
                             [_dimView removeFromSuperview];
                             _dimView = nil;
                             
                             [self.blurView removeFromSuperview];
                             self.blurView = nil;
                             self.tabBar.items[2].enabled = YES;
                         }
                     }];
}



-(void)viewWillLayoutSubviews
{
//    NSLog(@"viewWillLayoutSubviews");
    [self updateCenterButton];
}

-(void)updateCenterButton
{
    
    CGPoint origin = [self.view convertPoint:self.tabBar.center toView:self.tabBar];
    CGSize buttonSize = CGSizeMake(self.tabBar.frame.size.width / 5 - 6, self.tabBar.frame.size.height - 4);
    
    _centerButton.frame = CGRectMake(origin.x - buttonSize.height/2, origin.y - buttonSize.height/2, buttonSize.height, buttonSize.height);
    
    [_centerButton setCornerRadius:buttonSize.height/2];
    
    [_centerButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabBar addSubview:_centerButton];
}


@end
