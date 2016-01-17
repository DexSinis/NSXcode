//
//  NSXCategotyTableViewController.m
//  NSXcode
//
//  Created by DexSinis on 16/1/14.
//  Copyright © 2016年 DexSinis. All rights reserved.
//

#import "NSXCategotyTableViewController.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "NSXNews.h"
#import "NSXNewsResult.h"
#import "NSXNewsParam.h"
#import "NSXNews+provider.h"

#import "NSXNewsCell.h"
@interface NSXCategotyTableViewController ()
@property (strong, nonatomic) NSMutableArray *newsArray;
@end

@implementation NSXCategotyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSXNews newsArrayWithParam:nil success:^(NSXNewsResult *result) {
        self.newsArray = result.newsArray;
        [self.tableView reloadData];
        NSLog(@"%@", result.totalNumber);
        for (NSXNews *news in result.newsArray) {
            NSLog(@"%@", news.title);
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

#pragma mark - UITableviewDatasource 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    [self.tableView startAutoCellHeightWithCellClass:[NSXNewsCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    return self.newsArray.count;
    //    return self.menus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSXNews *news = self.newsArray[indexPath.row];
    //    NSXNews *news = [[NSXNews alloc] init];
    
    //    news.newsID = 112312312;
    ////    news.pubDate = [NSDate new];
    ////    news.title =@"github发布被doss攻击，被逼迁移到中国,要求日本道歉并赔偿损失";
    //    news.title = @"SonarQube 5.2发布,提升监控";
    //
    //    news.body =@"当你的 app 没有提供 3x 的 LaunchImage 时,github于2015年十月23日被日本的doss攻击，被逼迁移到中国，强烈要求日本道歉并赔偿损失";
    
    static NSString *ID = @"test";
    NSXNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSXNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.news = news;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSXNews *news = self.newsArray[indexPath.row];
    ////    int index = indexPath.row % 5;
    //    NSXNews *news = [[NSXNews alloc] init];
    //    news.newsID = 112312312;
    ////    news.pubDate = [NSDate new];
    //    //    news.title =@"github发布被doss攻击，被逼迁移到中国,要求日本道歉并赔偿损失";
    //    news.title = @"SonarQube 5.2发布,提升监控";
    //    news.body =@"当你的 app 没有提供 3x 的 LaunchImage 时,github于2015年十月23日被日本的doss攻击，被逼迁移到中国，强烈要求日本道歉并赔偿损失";
    return [self.tableView cellHeightForIndexPath:indexPath model:news keyPath:@"news"];
}

#pragma mark - UITableviewDelegate 代理方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 点击了第indexPath.row行Cell所做的操作
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
