//
//  CYXFourViewController.m
//
//
//  Created by Macx on 15/9/4.
//  Copyright (c) 2015年 CYX. All rights reserved.
//

#import "NSXSearchController.h"
#import "NSXSettingItem.h"
#import "NSXGroupItem.h"
#import "EaseUserHeaderView.h"

#import "Config.h"
#import "UIButton+Bootstrap.h"

#import "SubLBXScanViewController.h"
#import "ShakingViewController.h"

@interface NSXSearchController ()

@property (strong, nonatomic) NSMutableArray * groups;/**< 组数组 描述TableView有多少组 */

@end

@implementation NSXSearchController
/** groups 数据懒加载*/
- (NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}


- (instancetype)init{
    
    // 设置tableView的分组样式为Group样式
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加第1组模型
    [self setGroup1];
    //添加第2组模型
    [self setGroup2];
    //添加第3组模型
    [self setGroup3];
    
    
    //    UITableView *tv = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //    tv.delegate = self;
    //    tv.dataSource = self;
    //    tv.rowHeight = kRowHeight;
//    NSXUser *user = [Config getOwnUser];
//    EaseUserHeaderView *headerView =  [EaseUserHeaderView userHeaderViewWithUser:user image:[UIImage imageNamed:@"1441594747553218"]];
//    headerView.frame = CGRectMake(0, 0, kScreenWidth, 260.f);
//    self.tableView.tableHeaderView = headerView;
//    
//    self.tableView.tableFooterView = [self tableFooterView];
    //[[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 220.f)];
    //    [self.view addSubview:tv];
    //    self.tableView = tv;
    
}

- (void)setGroup1{
    // 创建组模型
    NSXGroupItem *group = [[NSXGroupItem alloc]init];
    // 创建行模型
    NSXSettingItem *item = [NSXSettingItem itemWithtitle:@"扫一扫"];
    NSXSettingItem *item1 = [NSXSettingItem itemWithtitle:@"摇一摇"];
    NSXSettingItem *item2 = [NSXSettingItem itemWithtitle:@"我的博客"];
    
    // 保存行模型数组
    group.items = @[item,item1,item2];
    // 把组模型保存到groups数组
    [self.groups addObject:group];
}

- (void)setGroup2{
    
    NSXGroupItem *group = [[NSXGroupItem alloc]init];
    
    NSXSettingItem *item = [NSXSettingItem itemWithtitle:@"我去好评"];
    NSXSettingItem *item1 = [NSXSettingItem itemWithtitle:@"我去吐槽"];
    
    group.items = @[item,item1];
    
    [self.groups addObject:group];
}

- (void)setGroup3{
    
    NSXGroupItem *group = [[NSXGroupItem alloc]init];
    
    NSXSettingItem *item = [NSXSettingItem itemWithtitle:@"关注我们"];
    NSXSettingItem *item1 = [NSXSettingItem itemWithtitle:@"关于我们"];
    
    group.items = @[item];
    
    [self.groups addObject:group];
}

#pragma mark - TableView的数据源代理方法实现

/**
 *  返回有多少组的代理方法
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.groups.count;
}
/**
 *  返回每组有多少行的代理方法
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSXGroupItem *group = self.groups[section];
    return group.items.count;
}

/**
 *  返回每一行Cell的代理方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1 初始化Cell
    // 1.1 设置Cell的重用标识
    static NSString *ID = @"cell";
    // 1.2 去缓存池中取Cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 1.3 若取不到便创建一个带重用标识的Cell
    if (cell == nil) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    // 设置Cell右边的小箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // 2 设置数据
    // 2.1 取出组模型
    NSXGroupItem *group = self.groups[indexPath.section];
    // 2.2 根据组模型取出行（Cell）模型
    NSXSettingItem *item = group.items[indexPath.row];
    // 2.3 根据行模型的数据赋值
    cell.textLabel.text = item.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self qqStyle];
        }else
        {
            [self qqStyle2];
        }
    }else
    {
        [self qqStyle2];
    }

}

- (void)qqStyle2
{
    ShakingViewController *vc = [[ShakingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)qqStyle
{
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    //SubLBXScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;   
    
    vc.isQQSimulator = YES;
//    [self presentViewController:vc animated:YES completion:^{
//        
//    }];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
