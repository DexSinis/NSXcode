//
//  CYXTabBarController.m
//   
//
//  Created by Macx on 15/9/4.
//  Copyright (c) 2015年 CYX. All rights reserved.
//

#import "NSXTabBarController.h"
#import "NSXHomeController.h"
#import "NSXMessageController.h"
#import "NSXSearchController.h"
#import "NSXSettingController.h"
#import "DemoVC3.h"

@interface NSXTabBarController ()

@end

@implementation NSXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpAllChildViewController];


}

/**
 *  添加所有子控制器
 */
- (void)setUpAllChildViewController{
    // 1.添加第一个控制器
//    NSXHomeController *oneVC = [[NSXHomeController alloc]init];
    DemoVC3 *oneVC = [[DemoVC3 alloc] init];
    [self setUpOneChildViewController:oneVC image:[UIImage imageNamed:@"tab_home_icon"] title:@"首页"];
    
    // 2.添加第2个控制器
    NSXMessageController *twoVC = [[NSXMessageController alloc]init];
    [self setUpOneChildViewController:twoVC image:[UIImage imageNamed:@"js"] title:@"技术"];
    
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
    
    viewController.navigationItem.title = title;
    
    [self addChildViewController:navC];
}





@end
