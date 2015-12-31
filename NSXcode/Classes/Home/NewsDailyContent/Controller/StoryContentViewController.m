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

@interface StoryContentViewController ()<UIScrollViewDelegate>

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
    
    [self initSubViews];
}

- (void)dealloc {
    [_viewmodel removeObserver:self forKeyPath:@"storyModel"];
}

- (void)initSubViews {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-20-43)];
    _webView.scrollView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];

    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -40, kScreenWidth, 260)];
    _headerView.clipsToBounds = YES;
    [self.view addSubview:_headerView];

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
    
    [self.view addSubview:toolBar];
    
    _preView = [[PreView alloc] initWithFrame:kScreenBounds];
    [self.view addSubview:_preView];
    
    UIView *commentView  = [[UIView alloc] init];
    commentView.frame = CGRectMake(0, kScreenHeight, 375, 667);
    commentView.backgroundColor = [UIColor lightGrayColor];
    self.commentView = commentView;
    self.commentView.hidden =YES;
    [self.view addSubview:commentView];
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextStoryAction:(id)sender {
    [_viewmodel getNextStoryContent];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

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
////        [self.viewmodel getNextStoryContent];
////        self.commentView.hidden =NO;
//        UIView *commentView  = [[UIView alloc] init];
//        commentView.frame = CGRectMake(0, scrollView.contentSize.height, 375, 667);
//        commentView.backgroundColor = [UIColor lightGrayColor];
//        self.commentView = commentView;
////        self.commentView.hidden =YES;
//        [self.view addSubview:commentView];
        self.commentViewController.view.frame = CGRectMake(0,scrollView.contentSize.height, self.view.frame.size.width, self.view.frame.size.height);
        scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, scrollView.contentSize.height+1000);
        //    self.subViewController.dataArray = self.product.detailPhotos;
        //    self.subViewController.product = self.product;
        [scrollView addSubview:self.commentViewController.view];
        [self addSubPage];
    }
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
        [_imageView sd_setImageWithURL:[NSURL URLWithString:_viewmodel.imageURLString]];
        CGSize size = [_viewmodel.titleAttText boundingRectWithSize:CGSizeMake(kScreenWidth-30, 60) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
        _titleLab.frame = CGRectMake(15, _headerView.frame.size.height-20-size.height, kScreenWidth-30, size.height);
        _titleLab.attributedText = _viewmodel.titleAttText;
        _imaSourceLab.text = _viewmodel.imaSourceText;
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

@end
