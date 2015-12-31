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
#import "CommentModel.h"

@interface StoryContentViewController ()<UIScrollViewDelegate, UIWebViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_dataSource;
    UITableView    *_tableview;
}


@property(strong,nonatomic)UIImageView *imageView;
@property(strong,nonatomic)UIView *headerView;
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *imaSourceLab;
@property(strong,nonatomic)UIWebView *webView;
@property(strong,nonatomic)PreView *preView;

@property(strong,nonatomic)UIView *commentView;
@property(strong,nonatomic)CommentViewController *commentViewController;

@property(strong,nonatomic)StoryContentViewModel *viewmodel;

@end

@implementation StoryContentViewController

- (instancetype)initWithViewModel:(StoryContentViewModel *)vm {
    self = [super init];
    if (self) {
        self.viewmodel = vm;
        [_viewmodel addObserver:self forKeyPath:@"storyModel" options:NSKeyValueObservingOptionNew context:nil];
        [_viewmodel getStoryContentWithStoryID:_viewmodel.loadedStoryID];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.commentViewController = [[CommentViewController alloc] init];

    [self setUpTableView];
    
    [self initSubViews];
    
   
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

    _preView = [[PreView alloc] initWithFrame:kScreenBounds];
    [_tableview.tableHeaderView addSubview:_preView];

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

- (void)setUpTableView {
//    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*说明：从网易客服端获取的json，为测试用，做了编辑*/

    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
    
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    _dataSource = [[NSMutableArray alloc] init];
    
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
            CommentModel *model =[[CommentModel alloc] initWithDict:dict];
            model.floor = index;
            [arr addObject:model];
        }
        
        [_dataSource addObject:arr];
    }
    
    
    
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
//    _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 300.f)];
    [self.view addSubview:_tableview];
    
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
    return ce;
    
}
@end
