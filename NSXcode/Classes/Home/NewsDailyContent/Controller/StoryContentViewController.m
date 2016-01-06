//
//  StoryContentViewController.m
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/17.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import "StoryContentViewController.h"
#import "PreView.h"
#import "CommentViewController.h"

#import "CommentViewController.h"
#import "CommentTableViewCell.h"
#import "LayoutContainerView.h"


#import "RDRGrowingTextView.h"

#import "MJExtension.h"
#import "MJRefresh.h"
#import "NSXComment.h"
#import "NSXCommentViewModel+Provider.h"
#import "NSXCommentViewModel.h"
#import "NSXCommentViewModelParam.h"
#import "NSXCommentViewModelResult.h"
#import "NSXHttpTool.h"
static CGFloat const MaxToolbarHeight = 200.0f;
@interface StoryContentViewController ()<UIScrollViewDelegate, UIWebViewDelegate, UITableViewDataSource, UITableViewDelegate,UITextViewDelegate>
{
    UIToolbar *_toolbar;
    RDRGrowingTextView *_textView;
}
@property (nonatomic,strong)   NSMutableArray *dataSource;
@property  (nonatomic,strong)  UITableView    *tableview;

@property(strong,nonatomic)UIImageView *imageView;
@property(strong,nonatomic)UIView *headerView;
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *imaSourceLab;
@property(strong,nonatomic)UIWebView *webView;
@property(strong,nonatomic)PreView *preView;

@property(strong,nonatomic)UIView *commentView;
@property(strong,nonatomic)CommentViewController *commentViewController;

@property(strong,nonatomic)StoryContentViewModel *viewmodel;

@property(strong,nonatomic)NSXComment *currentComment;

@end

@implementation StoryContentViewController

- (instancetype)initWithViewModel:(StoryContentViewModel *)vm {
    self = [super init];
    if (self) {
        self.viewmodel = vm;
        [_viewmodel addObserver:self forKeyPath:@"storyModel" options:NSKeyValueObservingOptionNew context:nil];
        [_viewmodel getStoryContentWithStoryID:_viewmodel.loadedStoryID];
        
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginUpdateComment:)  name:@"commentNotification" object:nil];
        
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endUpdateComment:)  name:@"commentFinishNotification" object:nil];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.commentViewController = [[CommentViewController alloc] init];

    [self initSubViews];
    
    [self setUpTableView];
   
}

-(void)beginUpdateComment:(NSNotification *)noti
{
    _toolbar.hidden = NO;
    NSXComment *comment = noti.userInfo[@"comment"];
    self.currentComment = comment;
    NSString *placeholderText = [NSString stringWithFormat:@"回复:%@",comment.username];
    _textView.placeholder = placeholderText;
    [_textView becomeFirstResponder];
}

-(void)endUpdateComment:(NSNotification *)noti
{
    _toolbar.hidden = YES;
    
    [_textView resignFirstResponder];
    
#pragma 写入评论数据，刷新数据
    [_tableview reloadData];
}

- (void)dealloc {
    [_viewmodel removeObserver:self forKeyPath:@"storyModel"];
}

- (void)initSubViews {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-20-43)];
    _webView.scrollView.delegate = self;
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];


}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextStoryAction:(id)sender {
    [_viewmodel getNextStoryContent];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    return;
    CGFloat offSetY = scrollView.contentOffset.y;
    if (-offSetY<=80&&-offSetY>=0) {
        _headerView.frame = CGRectMake(0, -40-offSetY/2, kScreenWidth, 260-offSetY/2);
        [_imaSourceLab setTop:240-offSetY/2];
        [_titleLab setBottom:_imaSourceLab.bottom-20];
        if (-offSetY>40&&!_webView.scrollView.isDragging){
            [self.viewmodel getPreviousStoryContent];
        }
    }else if (-offSetY>80) {
        _webView.scrollView.contentOffset = CGPointMake(0, -80);
    }else if (offSetY <=300 ){
        _headerView.frame = CGRectMake(0, -40-offSetY, kScreenWidth, 260);
    }
    if (offSetY + kScreenHeight > scrollView.contentSize.height + 160&&!_webView.scrollView.isDragging) {
//////        [self.viewmodel getNextStoryContent];
//////        self.commentView.hidden =NO;
////        UIView *commentView  = [[UIView alloc] init];
////        commentView.frame = CGRectMake(0, scrollView.contentSize.height, 375, 667);
////        commentView.backgroundColor = [UIColor lightGrayColor];
////        self.commentView = commentView;
//////        self.commentView.hidden =YES;
////        [self.view addSubview:commentView];
//        self.commentViewController.view.frame = CGRectMake(0,scrollView.contentSize.height, self.view.frame.size.width, self.view.frame.size.height);
//        scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, scrollView.contentSize.height+1000);
//        //    self.subViewController.dataArray = self.product.detailPhotos;
//        //    self.subViewController.product = self.product;
//        [scrollView addSubview:self.commentViewController.view];
//        [self addSubPage];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    //获取页面高度（像素）
    NSString * clientheight_str = [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    float clientheight = [clientheight_str floatValue];
    //设置到WebView上
    webView.frame = CGRectMake(0, 0, self.view.frame.size.width, clientheight);
    //获取WebView最佳尺寸（点）
    CGSize frame = [webView sizeThatFits:webView.frame.size];
    //获取内容实际高度（像素）
    NSString * height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('webview_content_wrapper').offsetHeight + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-top'))  + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-bottom'))"];
    float height = [height_str floatValue];
    //内容实际高度（像素）* 点和像素的比
    height = height * frame.height / clientheight;
    
 
    
    
    _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, _webView.frame.size.height)];

    
    [_tableview.tableHeaderView addSubview:_webView];
    
    UIView *vsd = [[UIView alloc] initWithFrame:CGRectMake(0, -40, kScreenWidth, 260)];
    vsd.backgroundColor =[ UIColor redColor];
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -40, kScreenWidth, 260)];
    _headerView.clipsToBounds = YES;
//    _headerView.backgroundColor =[ UIColor yellowColor];
    [_tableview.tableHeaderView addSubview:_headerView];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 300.f)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_headerView addSubview:_imageView];
    
    _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLab.numberOfLines = 0;
    [_headerView addSubview:_titleLab];
    
    _imaSourceLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 240, kScreenWidth-20, 20)];
    _imaSourceLab.textAlignment = NSTextAlignmentRight;
    _imaSourceLab.font = [UIFont systemFontOfSize:12];
    _imaSourceLab.textColor = [UIColor whiteColor];
    [_headerView addSubview:_imaSourceLab];
    
    [self setUpHeaderView];
    
    [self.view addSubview:_tableview];
    
//    [self.view addSubview:_tableview];
    
    
    UIView *toolBar = [[UIView alloc] initWithFrame:CGRectMake(0.f, kScreenHeight-43, kScreenWidth, 43)];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/5, 43)];
    [backBtn setImage:[UIImage imageNamed:@"News_Navigation_Arrow"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:backBtn];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/5,0 ,kScreenWidth/5 , 43)];
    [nextBtn setImage:[UIImage imageNamed:@"News_Navigation_Next"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextStoryAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:nextBtn];
    
    UIButton *votedBtn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth/5)*2, 0 ,kScreenWidth/5 , 43)];
    [votedBtn setImage:[UIImage imageNamed:@"News_Navigation_Voted"] forState:UIControlStateNormal];
    [toolBar addSubview:votedBtn];
    
    UIButton *sharedBtn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth/5)*3, 0 ,kScreenWidth/5 , 43)];
    [sharedBtn setImage:[UIImage imageNamed:@"News_Navigation_Share"] forState:UIControlStateNormal];
    [toolBar addSubview:sharedBtn];
    
    UIButton *commentdBtn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth/5)*4, 0 ,kScreenWidth/5 , 43)];
    [commentdBtn setImage:[UIImage imageNamed:@"News_Navigation_Comment"] forState:UIControlStateNormal];
    [toolBar addSubview:commentdBtn];
    toolBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:toolBar];
    
    
    
    _preView = [[PreView alloc] initWithFrame:kScreenBounds];
    [self.view addSubview:_preView];
    
    
    
    
//    [_viewmodel getStoryContentWithStoryID:_viewmodel.loadedStoryID];
    
}


-(void)setUpHeaderView
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_viewmodel.imageURLString]];
    CGSize size = [_viewmodel.titleAttText boundingRectWithSize:CGSizeMake(kScreenWidth-30, 60) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
    _titleLab.frame = CGRectMake(15, _headerView.frame.size.height-20-size.height, kScreenWidth-30, size.height);
    _titleLab.attributedText = _viewmodel.titleAttText;
    _imaSourceLab.text = _viewmodel.imaSourceText;
}


- (void)addSubPage
{
//    if (!self.commentViewController) {
//        return;
//    }
//    
//    self.subViewController.mainViewController = self;
   

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"storyModel"]) {

        [_webView loadHTMLString:_viewmodel.htmlStr baseURL:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_preView removeFromSuperview];
        });
        
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 初始化
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)setUpTableView {

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
    
    
    
    _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 马上进入刷新状态
    [_tableview.mj_header beginRefreshing];
    
    _tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //    _tableview.scrollEnabled =NO;
    //    NSLog(@"%f------------------------------>>>>>>>>>>>>>>>>>>",.contentSize);
//    _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 300.f)];
   
    
}

-(void)loadNewData1
{
    // Do any additional setup after loading the view, typically from a nib.
    /*说明：从网易客服端获取的json，为测试用，做了编辑*/
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testa" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
    
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    //    self.dataSource = [[NSMutableArray alloc] init];
    
    if (self.dataSource!=nil) {
        
        int i = 0;
        for (NSDictionary *dic in dict[@"hotPosts"]) {
            NSMutableArray *arr =[[NSMutableArray alloc] init];
            NSArray *allkey =[dic allKeys];
            NSArray *sortedArray= [allkey sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                
                NSNumber *number1 = [NSNumber numberWithInt:[obj1 intValue]];
                NSNumber *number2 = [NSNumber numberWithInt:[obj2 intValue]];
                
                NSComparisonResult result = [number1 compare:number2];
                
                return result == NSOrderedDescending; // 升序
                
            }];
            
            i++;
            for (NSString *index in sortedArray) {
                NSDictionary *dict =dic[index];
                //                CommentModel *model =[[CommentModel alloc] initWithDict:dict];
                NSXComment *model = [[NSXComment alloc] initWithDict:dict];
                model.timeString = [NSString stringWithFormat:@"%@",[NSDate new]];
                int a = arc4random()%1000;
                int b = arc4random()%2000;
                model.likeCount =[NSString stringWithFormat:@"%d",b];
                model.commentCount =[NSString stringWithFormat:@"%d",a];
                model.userId = @"4f0f3105-dd04-4105-a2b5-93fa5bc0b189";
                model.newsId = @"20e8a993-bb33-4472-b434-8a4485e37e02";
                model.floor = index;
                model.storey = [NSString stringWithFormat:@"%d",i];
                [arr addObject:model];
                
                //                NSXCommentViewModelParam *param = [[NSXCommentViewModelParam alloc] init];
                //                param.user = model.username;
                //                param.address = model.address;
                //                param.comment = model.comment;
                //                param.timeString = model.timeString;
                //                param.floor = model.floor;
                //                param.newsId = model.newsId;
                //                param.userId = model.userId;
                //                param.likeCount = model.likeCount;
                //                param.commentCount = model.commentCount;
                
                //                NSDictionary *dictmodel = [model mj_keyValues];
                //
                //                [NSXCommentViewModel commentViewModelArrayWithParam:dictmodel success:^(NSXCommentViewModelResult *result) {
                //                    [_tableview reloadData];
                //
                //                    [_tableview.mj_footer endRefreshing];
                //
                //                } failure:^(NSError *error) {
                //
                //                }];
                //                NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"commentInsert"];
                //
                //                 NSDictionary *dictmodel = [model mj_keyValues];
                //                [NSXHttpTool post:url params:dictmodel success:^(id responseObj) {
                //
                //                } failure:^(NSError *error) {
                //
                //                }];
                
            }
            
            [self.dataSource addObject:arr];
        }
        
        
        [_tableview reloadData];
        
        [_tableview.mj_header endRefreshing];
    }
    
    
}


-(void)loadNewData
{
    
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
        
        [_tableview.mj_header endRefreshing];
        
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


#pragma mark -- tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LayoutContainerView * container =[[LayoutContainerView alloc] initWithModelArray:_dataSource[indexPath.row]];
    return container.frame.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableViewCell * ce =[[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    ce.selectionStyle = UITableViewCellSelectionStyleNone;
    LayoutContainerView * container =[[LayoutContainerView alloc] initWithModelArray:_dataSource[indexPath.row]];
    [ce.contentView addSubview:container];
    
//    UILongPressGestureRecognizer *longPressed = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressToDo:)];
//    
//    longPressed.minimumPressDuration = 1;
//    
//    [ce.contentView addGestureRecognizer:longPressed];
    
    return ce;
    
}

//-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
//
//
//{
//    
//    if (gesture.state==UIGestureRecognizerStateBegan) {
//        [self becomeFirstResponder];
//     
//      CGPoint locationcell = [gesture locationInView:self.view];
//       NSIndexPath * indexPath = [_tableview indexPathForRowAtPoint:locationcell];
//        
//        LayoutContainerView * container =[[LayoutContainerView alloc] initWithModelArray:_dataSource[indexPath.row]];
//        
//        CommentTableViewCell *cell = (CommentTableViewCell *)gesture.view;
//        CGPoint location = [gesture locationInView:cell];
//        NSLog(@"%@",NSStringFromCGPoint(location));
//        
//        UIMenuController *menu=[UIMenuController sharedMenuController];
//        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyItemClicked:)];
//        UIMenuItem *resendItem = [[UIMenuItem alloc] initWithTitle:@"转发" action:@selector(resendItemClicked:)];
//        [menu setMenuItems:[NSArray arrayWithObjects:copyItem,resendItem,nil]];
////        [menu setTargetRect:CGRectMake(location.x, location.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) inView:self.view];
////        UIView *temp = [[UIView alloc] initWithFrame:CGRectMake(location.x, location.y,1 , 1)];
////        [menu setTargetRect:CGRectMake(location.x,location.y,0,0) inView:self.view];
//        [menu setTargetRect:CGRectMake(100,100,0,0) inView:cell];
//        NSLog(@"%@",NSStringFromCGRect([UIScreen mainScreen].bounds));
//         NSLog(@"%@",NSStringFromCGRect(cell.frame));
//
//        [menu setMenuVisible:YES animated:YES];
//    }
//    
//    
//    
//}
//
//#pragma mark 处理action事件
//-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
//    if(action ==@selector(copyItemClicked:)){
//        return YES;
//    }else if (action==@selector(resendItemClicked:)){
//        return YES;
//    }
//    return [super canPerformAction:action withSender:sender];
//}
//#pragma mark  实现成为第一响应者方法
//-(BOOL)canBecomeFirstResponder{
//    return YES;
//}
//
//#pragma mark method
//-(void)resendItemClicked:(id)sender{
//    NSLog(@"转发");
//    //通知代理
//}
//-(void)copyItemClicked:(id)sender{
//    NSLog(@"复制");
//    // 通知代理
//}


#pragma mark - Overrides

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (UIView *)inputAccessoryView
{
    if (_toolbar) {
        return _toolbar;
    }
    
    _toolbar = [UIToolbar new];
    
    RDRGrowingTextView *textView = [RDRGrowingTextView new];
    textView.font = [UIFont systemFontOfSize:17.0f];
    textView.textContainerInset = UIEdgeInsetsMake(4.0f, 3.0f, 3.0f, 3.0f);
    textView.layer.cornerRadius = 4.0f;
    textView.layer.borderColor = [UIColor colorWithRed:255.0f/255.0f green:200.0f/255.0f blue:205.0f/255.0f alpha:1.0f].CGColor;
    textView.layer.borderWidth = 1.0f;
    textView.layer.masksToBounds = YES;
    textView.delegate = self;
    textView.returnKeyType =UIReturnKeyDone;
    _textView = textView;
    [_toolbar addSubview:textView];
    
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    _toolbar.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_toolbar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[textView]-8-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(textView)]];
    [_toolbar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[textView]-8-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(textView)]];
    
    [textView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [textView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_toolbar setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    [_toolbar addConstraint:[NSLayoutConstraint constraintWithItem:_toolbar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:MaxToolbarHeight]];
    _toolbar.hidden = YES;
    return _toolbar;
}

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    _tableview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _toolbar.hidden = YES;
    [_textView resignFirstResponder];
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    NSLog(@"%@",textView.text);
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"commentFinishNotification" object:nil userInfo:@{@"comment":textView.text}];
//
//    return NO;
//}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (1 == range.length) {//按下回格键
        return YES;
    }
    
    if ([text isEqualToString:@"\n"]) {//按下return键
        //这里隐藏键盘，不做任何处理
        [textView resignFirstResponder];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"commentFinishNotification" object:nil userInfo:@{@"comment":textView.text}];
        
//        [NSXCommentViewModel commentViewModelInsertWithParam:<#(NSXCommentViewModelParam *)#> success:<#^(NSXCommentViewModelResult *result)success#> failure:<#^(NSError *error)failure#>];
        
        NSString *url = [NSString stringWithFormat:@"%@%@",Domain,@"commentInsert"];
       
        NSXComment *model = [[NSXComment alloc] init];
        
        model.timeString = [NSString stringWithFormat:@"%@",[NSDate new]];
        int a = arc4random()%1000;
        int b = arc4random()%2000;
        model.likeCount =[NSString stringWithFormat:@"%d",b];
        model.commentCount =[NSString stringWithFormat:@"%d",a];
        model.userId = @"4f0f3105-dd04-4105-a2b5-93fa5bc0b189";
        model.newsId = @"20e8a993-bb33-4472-b434-8a4485e37e02";
//        model.floor = [NSString stringWithFormat:@"%d",[self.currentComment.maxfloor intValue]+1];
        model.storey = self.currentComment.storey;
        model.username =@"dexsinis";
        model.comment = textView.text;
        model.address = @"广州千云科技";
        
        NSDictionary *dictmodel = [model keyValues];
        
        [NSXHttpTool post:url params:dictmodel success:^(id responseObj) {
            
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
                self.dataSource = [NSMutableArray array];
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
                    for (NSXComment *comment in arrafter) {
                        comment.maxfloor = [NSString stringWithFormat:@"%lu",(unsigned long)arrafter.count];
                    }
                    arrafter = [arr sortedArrayUsingComparator:cmptr];
                    [self.dataSource addObject:arrafter];
                }
                
                
                //        _dataSource = result.viewModel.hotPosts;
                
                [_tableview reloadData];
                
                [_tableview.mj_footer endRefreshing];
                
            } failure:^(NSError *error) {
                
            }];
        } failure:^(NSError *error) {
            
        }];
        
        
         NSLog(@"%@",textView.text);
        
        
         textView.text =nil;
        return NO;
    }else {
        if ([textView.text length] < 140) {//判断字符个数
            return YES;
        }
    }
    return NO;
}
@end
