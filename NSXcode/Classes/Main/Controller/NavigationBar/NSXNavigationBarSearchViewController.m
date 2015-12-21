//
//  SearchViewController.m
//  iosapp
//
//  Created by chenhaoxiang on 1/22/15.
//  Copyright (c) 2015 oschina. All rights reserved.
//

#import "NSXNavigationBarSearchViewController.h"
//#import "SearchResultsViewController.h"
//#import "Utils.h"
#import "AppDelegate.h"
#import "NSXNewsController.h"
#import "MyTableViewController.h"
//#import "Config.h"

@interface NSXNavigationBarSearchViewController ()

@property (nonatomic, strong) UISearchBar *searchBar;


@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) NSXNewsController *viewVc;
@property (nonatomic, strong) NSXNewsController *viewVc2;
@property (nonatomic, strong) NSXNewsController *viewVc3;

@end

@implementation NSXNavigationBarSearchViewController

- (instancetype)init
{
//    self = [super initWithTitle:nil
//                   andSubTitles:@[@"软件", @"问答", @"博客", @"新闻"]
//                 andControllers:@[
//                                  [[SearchResultsViewController alloc] initWithType:@"software"],
//                                  [[SearchResultsViewController alloc] initWithType:@"post"],
//                                  [[SearchResultsViewController alloc] initWithType:@"blog"],
//                                  [[SearchResultsViewController alloc] initWithType:@"news"]
//                                  ]];
//    if (self) {
//        self.hidesBottomBarWhenPushed = YES;
//        
//        __weak NSXNavigationBarSearchViewController *weakSelf = self;
//        for (SearchResultsViewController *searchResultsVC in self.viewPager.childViewControllers) {
//            searchResultsVC.viewDidScroll = ^ {
//                [weakSelf.searchBar resignFirstResponder];
//            
//            };
//        }
//        
//        weakSelf.viewPager.viewDidScroll = ^{
//            [self.searchBar resignFirstResponder];
//        };
//    }
//

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setupSearchView];
    
    //    self.title = @"HMSegmentedControl Demo";
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    CGFloat viewHeight = CGRectGetHeight(self.view.frame);
    
    // Tying up the segmented control to a scroll view
    self.segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, -10, viewWidth, 30)];
    self.segmentedControl.sectionTitles =  @[@"本地音乐",@"收藏"];
    // @[@"本地音乐", @"收藏",@"最近听过"];
    //,@"Headlines",@"DexSinis"];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.backgroundColor = [UIColor clearColor];
    
    UIFont* font = [UIFont fontWithName:@"Arial-ItalicMT" size:10.0];
    NSDictionary* textAttributes = @{NSFontAttributeName:font,
                                     NSForegroundColorAttributeName:[UIColor blackColor]};
    self.segmentedControl.titleTextAttributes = textAttributes;
    
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1]};
    self.segmentedControl.selectionIndicatorColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleBox;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationUp;
    self.segmentedControl.tag = 3;
    
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(viewWidth * index, 0, viewWidth, 200) animated:YES];
    }];
    
    [self.view addSubview:self.segmentedControl];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, viewWidth, viewHeight)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(viewWidth * 2, 200);
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(viewWidth, 0, viewWidth, 200) animated:NO];
    [self.view addSubview:self.scrollView];
    
    self.viewVc = [[NSXNewsController alloc] init];
    self.viewVc.view.frame  = CGRectMake(0, 0, viewWidth, viewHeight);
    //  viewVc.view.backgroundColor = [UIColor blueColor];
//    [self setApperanceForLabel:viewVc];
    [self.scrollView addSubview:self.viewVc.view];
    [self addChildViewController:self.viewVc];
    
    self.viewVc2 = [[NSXNewsController alloc] init];
    self.viewVc2.view.frame  = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
    self.viewVc2.view.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.viewVc2.view];
    [self addChildViewController:self.viewVc2];
    

}

- (void)setApperanceForLabel:(UILabel *)label {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    label.backgroundColor = color;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:21.0f];
    label.textAlignment = NSTextAlignmentCenter;
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}

- (void)uisegmentedControlChangedValue:(UISegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld", (long)segmentedControl.selectedSegmentIndex);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}


- (void)setUpSearchBar {
    
    _searchBar = [UISearchBar new];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"请输入关键字";
//    ((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode = [Config getMode];
//    if (((AppDelegate *)[UIApplication sharedApplication].delegate).inNightMode) {
//        _searchBar.keyboardAppearance = UIKeyboardAppearanceDark;
//        _searchBar.barTintColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
//    }
//    
    self.navigationItem.titleView = _searchBar;
}

#pragma mark -- 初始化搜索框
- (void)initSearchTextField
{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 44)];
    _searchBar.delegate = self;
    _searchBar.exclusiveTouch = YES;
    [_searchBar setPlaceholder:@"输入关键字"];
    
//    resultController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
//    resultController.searchResultsDataSource = self;
//    resultController.searchResultsDelegate = self;
    
}

-(void)setupSearchView{
    [self initSearchTextField];
    self.navigationItem.titleView = _searchBar;//把搜索框放在tableview的第一行
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (_searchBar.text.length == 0) {return;}
    
    [searchBar resignFirstResponder];
    
    NSLog(@"%@",_searchBar.text);
    
//    for (SearchResultsViewController *searchResultsVC in self.viewPager.childViewControllers) {
//        searchResultsVC.keyword = searchBar.text;
//        [searchResultsVC refresh];
//    }
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.viewPager.tableView reloadData];
//    });
}





@end
