//
//  TBViewController.m
//  NSXcode
//
//  Created by DexSinis on 15/12/3.
//  Copyright © 2015年 DexSinis. All rights reserved.
//

#import "TBViewController.h"

@interface TBViewController ()

@end

@implementation TBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"First Controller";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(presentLeftMenuViewController:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Right"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(presentRightMenuViewController:)];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    imageView.image = [UIImage imageNamed:@"Balloon"];
//    [self.view addSubview:imageView];
    
    
         UIViewController *c1=[[UIViewController alloc]init];
         c1.view.backgroundColor=[UIColor grayColor];
         c1.view.backgroundColor=[UIColor greenColor];
         c1.tabBarItem.title=@"消息";
         c1.tabBarItem.image=[UIImage imageNamed:@"tab_recent_nor"];
         c1.tabBarItem.badgeValue=@"123";
    
         UIViewController *c2=[[UIViewController alloc]init];
         c2.view.backgroundColor=[UIColor brownColor];
         c2.tabBarItem.title=@"联系人";
         c2.tabBarItem.image=[UIImage imageNamed:@"tab_buddy_nor"];
    
         UIViewController *c3=[[UIViewController alloc]init];
        c3.tabBarItem.title=@"动态";
         c3.tabBarItem.image=[UIImage imageNamed:@"tab_qworld_nor"];

         UIViewController *c4=[[UIViewController alloc]init];
        c4.tabBarItem.title=@"设置";
         c4.tabBarItem.image=[UIImage imageNamed:@"tab_me_nor"];
    
    
         //c.添加子控制器到ITabBarController中
         //c.1第一种方式
     //    [tb addChildViewController:c1];
     //    [tb addChildViewController:c2];
    
         //c.2第二种方式
         self.viewControllers=@[c1,c2,c3,c4];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
