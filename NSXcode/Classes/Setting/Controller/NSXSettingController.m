//
//  CYXFourViewController.m
//   
//
//  Created by Macx on 15/9/4.
//  Copyright (c) 2015年 CYX. All rights reserved.
//

#import "NSXSettingController.h"
#import "NSXSettingItem.h"
#import "NSXGroupItem.h"

@interface NSXSettingController ()

@property (strong, nonatomic) NSMutableArray * groups;/**< 组数组 描述TableView有多少组 */

@end

@implementation NSXSettingController
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
    
}

- (void)setGroup1{
    // 创建组模型
    NSXGroupItem *group = [[NSXGroupItem alloc]init];
    // 创建行模型
    NSXSettingItem *item = [NSXSettingItem itemWithtitle:@"我的账号"];
    NSXSettingItem *item1 = [NSXSettingItem itemWithtitle:@"我的收藏"];

    // 保存行模型数组
    group.items = @[item,item1];
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

    group.items = @[item,item1];
    
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

@end
