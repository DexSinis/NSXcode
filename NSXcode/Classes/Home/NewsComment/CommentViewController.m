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

#import "NSXHttpTool.h"

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
//
//-(void)loadNewData
//{
//    // Do any additional setup after loading the view, typically from a nib.
//    /*说明：从网易客服端获取的json，为测试用，做了编辑*/
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"testa" ofType:@"json"];
//    
//    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
//    
//    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
////    self.dataSource = [[NSMutableArray alloc] init];
//    
//    if (self.dataSource!=nil) {
//        
//        int i = 0;
//        for (NSDictionary *dic in dict[@"hotPosts"]) {
//            NSMutableArray *arr =[[NSMutableArray alloc] init];
//            NSArray *allkey =[dic allKeys];
//            NSArray *sortedArray= [allkey sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//                
//                NSNumber *number1 = [NSNumber numberWithInt:[obj1 intValue]];
//                NSNumber *number2 = [NSNumber numberWithInt:[obj2 intValue]];
//                
//                NSComparisonResult result = [number1 compare:number2];
//                
//                return result == NSOrderedDescending; // 升序
//                
//            }];
//    
//            i++;
//            for (NSString *index in sortedArray) {
//                NSDictionary *dict =dic[index];
////                CommentModel *model =[[CommentModel alloc] initWithDict:dict];
//                NSXComment *model = [[NSXComment alloc] initWithDict:dict];
//                model.timeString = [NSString stringWithFormat:@"%@",[NSDate new]];
//                int a = arc4random()%1000;
//                int b = arc4random()%2000;
//                model.likeCount =[NSString stringWithFormat:@"%d",b];
//                model.commentCount =[NSString stringWithFormat:@"%d",a];
//                model.userId = @"4f0f3105-dd04-4105-a2b5-93fa5bc0b189";
//                model.newsId = @"20e8a993-bb33-4472-b434-8a4485e37e02";
//                model.floor = index;
//                model.storey = [NSString stringWithFormat:@"%d",i];
//                [arr addObject:model];
//                
////                NSXCommentViewModelParam *param = [[NSXCommentViewModelParam alloc] init];
////                param.user = model.username;
////                param.address = model.address;
////                param.comment = model.comment;
////                param.timeString = model.timeString;
////                param.floor = model.floor;
////                param.newsId = model.newsId;
////                param.userId = model.userId;
////                param.likeCount = model.likeCount;
////                param.commentCount = model.commentCount;
//                
////                NSDictionary *dictmodel = [model mj_keyValues];
////                
////                [NSXCommentViewModel commentViewModelArrayWithParam:dictmodel success:^(NSXCommentViewModelResult *result) {
////                    [_tableview reloadData];
////                    
////                    [_tableview.mj_footer endRefreshing];
////                    
////                } failure:^(NSError *error) {
////                    
////                }];
////                NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"commentInsert"];
////
////                 NSDictionary *dictmodel = [model mj_keyValues];
////                [NSXHttpTool post:url params:dictmodel success:^(id responseObj) {
////                    
////                } failure:^(NSError *error) {
////                    
////                }];
//               
//            }
//            
//            [self.dataSource addObject:arr];
//        }
//        
//        
//        [_tableview reloadData];
//        
//        [_tableview.mj_header endRefreshing];
//    }
//    
//   
//}




-(void)loadNewData
{
    //    // Do any additional setup after loading the view, typically from a nib.
    //    /*说明：从网易客服端获取的json，为测试用，做了编辑*/
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"testb" ofType:@"json"];
    //
    //    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
    //
    //    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    ////    self.dataSource = [[NSMutableArray alloc] init];
    //
    //    if (self.dataSource!=nil) {
    //        for (NSDictionary *dic in dict[@"hotPosts"]) {
    //            NSMutableArray *arr =[[NSMutableArray alloc] init];
    //            NSArray *allkey =[dic allKeys];
    //            NSArray *sortedArray= [allkey sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
    //
    //                NSNumber *number1 = [NSNumber numberWithInt:[obj1 intValue]];
    //                NSNumber *number2 = [NSNumber numberWithInt:[obj2 intValue]];
    //
    //                NSComparisonResult result = [number1 compare:number2];
    //
    //                return result == NSOrderedDescending; // 升序
    //
    //            }];
    //
    //            for (NSString *index in sortedArray) {
    //                NSDictionary *dict =dic[index];
    ////                CommentModel *model =[[CommentModel alloc] initWithDict:dict];
    //                NSXComment *model = [[NSXComment alloc] initWithDict:dict];
    //                model.floor = index;
    //                [arr addObject:model];
    //            }
    //
    //            [self.dataSource addObject:arr];
    //
    //        }
    //
    //
    //        [_tableview reloadData];
    //
    //        [_tableview.mj_footer endRefreshing];
    //    }
    //
    
    
    NSXCommentViewModelParam *param = [[NSXCommentViewModelParam alloc] init];
    
    [NSXCommentViewModel commentViewModelWithParam:param success:^(NSXCommentViewModelResult *result) {
        
        
        
        //         [result.viewModel.hotPostsIdArray addObjectsFromArray:[result.viewModel.hotPosts valueForKeyPath:@"username"]];
        //
        //        NSArray *a = result.viewModel.hotPostsIdArray;
        //        NSMutableSet *set=[NSMutableSet set];
        //
        //
        //        NSArray *sortedByName = [result.viewModel.hotPosts  sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"storey" ascending:YES]]];
        //
        //        for (int i = 0; i<sortedByName.count; i++) {
        //             NSArray *t1Only = [result.viewModel.hotPosts  filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"storey = %@", sortedByName[i]]];
        //
        //        }
        
        
        
        
        //        [result.viewModel.hotPosts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        //            [set addObject:obj[@"storey"]];//利用set不重复的特性,得到有多少组,根据数组中的MeasureType字段
        //        }];
        
        NSDictionary *dict  = [result mj_keyValues];
        //        NSLog(@"%@",dict);
        
        //        NSArray *sortedByName = [result.viewModel.hotPosts  sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"storey" ascending:YES]]];
        //
        //        for (int i = 0; i<sortedByName.count; i++) {
        //            NSArray *t1Only = [result.viewModel.hotPosts  filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"storey = %@", sortedByName[i]]];
        //
        //        }
        NSXCommentViewModel *vm = result.viewModel;
        NSArray *sortedByName1 = [vm valueForKeyPath:@"hotPosts.storey"];
        NSInteger max = [[sortedByName1 valueForKeyPath:@"@max.intValue"] integerValue];
        
        //        [dict valueForKeyPath:@"vm.hotPosts.storey"];
        NSLog(@"%@,-------%ld",sortedByName1,(long)max);
        
        
        NSComparator cmptr = ^(id obj1, id obj2){
            NSXComment *comment1 = obj1;
            NSXComment *comment2 = obj2;
            if ([comment1.floor intValue] > [comment2.floor intValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([comment1.floor intValue] < [comment2.floor intValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        };
        
        for (int i=1; i<=6; i++) {
            NSMutableArray *arr =[[NSMutableArray alloc] init];
            NSArray *arrafter =[[NSMutableArray alloc] init];
            for (NSXComment *comment in result.viewModel.hotPosts) {
                if ([comment.storey isEqualToString:[NSString stringWithFormat:@"%d",i]]) {
                    [arr addObject:comment];
                }
            }
            arrafter = [arr sortedArrayUsingComparator:cmptr];
            for (NSXComment *comment in arrafter) {
                comment.maxfloor = [NSString stringWithFormat:@"%lu",(unsigned long)arrafter.count];
            }
            [self.dataSource addObject:arrafter];
        }
        
        
        //        _dataSource = result.viewModel.hotPosts;
        
        [_tableview reloadData];
        
        [_tableview.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)loadMoreData
{
//    // Do any additional setup after loading the view, typically from a nib.
//    /*说明：从网易客服端获取的json，为测试用，做了编辑*/
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"testb" ofType:@"json"];
//    
//    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
//    
//    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
////    self.dataSource = [[NSMutableArray alloc] init];
//    
//    if (self.dataSource!=nil) {
//        for (NSDictionary *dic in dict[@"hotPosts"]) {
//            NSMutableArray *arr =[[NSMutableArray alloc] init];
//            NSArray *allkey =[dic allKeys];
//            NSArray *sortedArray= [allkey sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//                
//                NSNumber *number1 = [NSNumber numberWithInt:[obj1 intValue]];
//                NSNumber *number2 = [NSNumber numberWithInt:[obj2 intValue]];
//                
//                NSComparisonResult result = [number1 compare:number2];
//                
//                return result == NSOrderedDescending; // 升序
//                
//            }];
//            
//            for (NSString *index in sortedArray) {
//                NSDictionary *dict =dic[index];
////                CommentModel *model =[[CommentModel alloc] initWithDict:dict];
//                NSXComment *model = [[NSXComment alloc] initWithDict:dict];
//                model.floor = index;
//                [arr addObject:model];
//            }
//            
//            [self.dataSource addObject:arr];
//
//        }
//        
//        
//        [_tableview reloadData];
//        
//        [_tableview.mj_footer endRefreshing];
//    }
//    

    
    NSXCommentViewModelParam *param = [[NSXCommentViewModelParam alloc] init];
    
    [NSXCommentViewModel commentViewModelWithParam:param success:^(NSXCommentViewModelResult *result) {
        
        
        
//         [result.viewModel.hotPostsIdArray addObjectsFromArray:[result.viewModel.hotPosts valueForKeyPath:@"username"]];
//        
//        NSArray *a = result.viewModel.hotPostsIdArray;
//        NSMutableSet *set=[NSMutableSet set];
//        
//        
//        NSArray *sortedByName = [result.viewModel.hotPosts  sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"storey" ascending:YES]]];
//        
//        for (int i = 0; i<sortedByName.count; i++) {
//             NSArray *t1Only = [result.viewModel.hotPosts  filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"storey = %@", sortedByName[i]]];
//            
//        }
      
       
        
        
//        [result.viewModel.hotPosts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            [set addObject:obj[@"storey"]];//利用set不重复的特性,得到有多少组,根据数组中的MeasureType字段
//        }];
        
        NSDictionary *dict  = [result mj_keyValues];
//        NSLog(@"%@",dict);
        
//        NSArray *sortedByName = [result.viewModel.hotPosts  sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"storey" ascending:YES]]];
//        
//        for (int i = 0; i<sortedByName.count; i++) {
//            NSArray *t1Only = [result.viewModel.hotPosts  filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"storey = %@", sortedByName[i]]];
//            
//        }
        NSXCommentViewModel *vm = result.viewModel;
        NSArray *sortedByName1 = [vm valueForKeyPath:@"hotPosts.storey"];
        NSInteger max = [[sortedByName1 valueForKeyPath:@"@max.intValue"] integerValue];
        
//        [dict valueForKeyPath:@"vm.hotPosts.storey"];
        NSLog(@"%@,-------%ld",sortedByName1,(long)max);
    
        
        NSComparator cmptr = ^(id obj1, id obj2){
            NSXComment *comment1 = obj1;
            NSXComment *comment2 = obj2;
            if ([comment1.floor intValue] > [comment2.floor intValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([comment1.floor intValue] < [comment2.floor intValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;  
        };
        
        for (int i=1; i<=6; i++) {
             NSMutableArray *arr =[[NSMutableArray alloc] init];
             NSArray *arrafter =[[NSMutableArray alloc] init];
            for (NSXComment *comment in result.viewModel.hotPosts) {
                if ([comment.storey isEqualToString:[NSString stringWithFormat:@"%d",i]]) {
                    [arr addObject:comment];
                }
            }
             arrafter = [arr sortedArrayUsingComparator:cmptr];
            for (NSXComment *comment in arrafter) {
                comment.maxfloor = [NSString stringWithFormat:@"%d",arrafter.count];
            }
            [self.dataSource addObject:arrafter];
        }
        
    
//        _dataSource = result.viewModel.hotPosts;
        
        [_tableview reloadData];
        
        [_tableview.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        
    }];
   
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

