//
//  ViewController.m
//  NewsCommentLayout
//
//  Created by xiaohaibo on 11/29/15.
//  Copyright © 2015 xiao haibo. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentTableViewCell.h"
#import "LayoutContainerView.h"
//#import "CommentModel.h"
#import "MJExtension.h"
#import "MJRefresh.h"

#import "NSXComment.h"
#import "NSXCommentViewModel+Provider.h"
#import "NSXCommentViewModel.h"
#import "NSXCommentViewModelParam.h"
#import "NSXCommentViewModelResult.h"

@interface CommentViewController ()<UITableViewDataSource ,UITableViewDelegate>
//{
 @property (nonatomic,strong)   NSMutableArray *dataSource;
 @property  (nonatomic,strong)  UITableView    *tableview;
//}

@end

@implementation CommentViewController

#pragma mark - 初始化
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
//
//-(NSMutableArray *)dataSource
//{
//    // Do any additional setup after loading the view, typically from a nib.
//    /*说明：从网易客服端获取的json，为测试用，做了编辑*/
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"];
//    
//    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
//    
//    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
//    self.dataSource = [[NSMutableArray alloc] init];
//    
//    for (NSDictionary *dic in dict[@"hotPosts"]) {
//        NSMutableArray *arr =[[NSMutableArray alloc] init];
//        NSArray *allkey =[dic allKeys];
//        NSArray *sortedArray= [allkey sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//            
//            NSNumber *number1 = [NSNumber numberWithInt:[obj1 intValue]];
//            NSNumber *number2 = [NSNumber numberWithInt:[obj2 intValue]];
//            
//            NSComparisonResult result = [number1 compare:number2];
//            
//            return result == NSOrderedDescending; // 升序
//            
//        }];
//        
//        for (NSString *index in sortedArray) {
//            NSDictionary *dict =dic[index];
//            CommentModel *model =[[CommentModel alloc] initWithDict:dict];
//            model.floor = index;
//            [arr addObject:model];
//        }
//        
//        [self.dataSource addObject:arr];
//    }
//    
//    return self.dataSource;
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableview.backgroundView = nil;
    if ([_tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([_tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    _tableview.scrollEnabled =NO;
//    NSLog(@"%f------------------------------>>>>>>>>>>>>>>>>>>",.contentSize);
    
    _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 马上进入刷新状态
    [_tableview.mj_header beginRefreshing];
    
    _tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    
//    _tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.view addSubview:_tableview];
    
}

-(void)loadNewData
{
    // Do any additional setup after loading the view, typically from a nib.
    /*说明：从网易客服端获取的json，为测试用，做了编辑*/
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testa" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
    
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
//    self.dataSource = [[NSMutableArray alloc] init];
    
    if (self.dataSource!=nil) {
        for (NSDictionary *dic in dict[@"hotPosts"]) {
            NSMutableArray *arr =[[NSMutableArray alloc] init];
            NSArray *allkey =[dic allKeys];
            NSArray *sortedArray= [allkey sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                
                NSNumber *number1 = [NSNumber numberWithInt:[obj1 intValue]];
                NSNumber *number2 = [NSNumber numberWithInt:[obj2 intValue]];
                
                NSComparisonResult result = [number1 compare:number2];
                
                return result == NSOrderedDescending; // 升序
                
            }];
            
            for (NSString *index in sortedArray) {
                NSDictionary *dict =dic[index];
//                CommentModel *model =[[CommentModel alloc] initWithDict:dict];
                NSXComment *model = [[NSXComment alloc] initWithDict:dict];
                model.floor = index;
                [arr addObject:model];
            }
            
            [self.dataSource addObject:arr];
        }
        
        
        [_tableview reloadData];
        
        [_tableview.mj_header endRefreshing];
    }
    
   
}

-(void)loadMoreData
{
    // Do any additional setup after loading the view, typically from a nib.
    /*说明：从网易客服端获取的json，为测试用，做了编辑*/
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testb" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
    
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
//    self.dataSource = [[NSMutableArray alloc] init];
    
    if (self.dataSource!=nil) {
        for (NSDictionary *dic in dict[@"hotPosts"]) {
            NSMutableArray *arr =[[NSMutableArray alloc] init];
            NSArray *allkey =[dic allKeys];
            NSArray *sortedArray= [allkey sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                
                NSNumber *number1 = [NSNumber numberWithInt:[obj1 intValue]];
                NSNumber *number2 = [NSNumber numberWithInt:[obj2 intValue]];
                
                NSComparisonResult result = [number1 compare:number2];
                
                return result == NSOrderedDescending; // 升序
                
            }];
            
            for (NSString *index in sortedArray) {
                NSDictionary *dict =dic[index];
//                CommentModel *model =[[CommentModel alloc] initWithDict:dict];
                NSXComment *model = [[NSXComment alloc] initWithDict:dict];
                model.floor = index;
                [arr addObject:model];
            }
            
            [self.dataSource addObject:arr];

        }
        
        
        [_tableview reloadData];
        
        [_tableview.mj_footer endRefreshing];
    }
    
    
//    [NSXCommentViewModel commentViewModelWithParam]
   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LayoutContainerView * container =[[LayoutContainerView alloc] initWithModelArray:self.dataSource[indexPath.row]];
    return container.frame.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableViewCell * ce =[[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    ce.selectionStyle = UITableViewCellSelectionStyleNone;
    LayoutContainerView * container =[[LayoutContainerView alloc] initWithModelArray:self.dataSource[indexPath.row]];
    [ce.contentView addSubview:container];
    return ce;
    
}
-(CGFloat)getTableViewHeight
{
    return _tableview.contentSize.height;
}
@end

