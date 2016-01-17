//
//  ViewController.m
//  HMSegmentedControlExample
//
//  Created by Hesham Abd-Elmegid on 23/12/12.
//  Copyright (c) 2012 Hesham Abd-Elmegid. All rights reserved.
//

#import "NSXCategoryController.h"
#import "NSXNewsController.h"
#import "NSXCategotyTableViewController.h"

#import "NSXCategory.h"
#import "NSXCategory+Provider.h"
#import "NSXCategoryParam.h"
#import "NSXCategoryResult.h"

#import "Config.h"
#import "NSXUser.h"

#import "UIViewController+MMDrawerController.h"
@interface NSXCategoryController ()<UISearchBarDelegate,UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UISearchBar *mySearchBar;
    UISearchDisplayController *mySearchDisplayController;
    NSMutableArray *suggestResults;
    UIView *historyView;
}

@property (nonatomic, assign) BOOL isHistoryShown;

@property (nonatomic, strong) NSMutableArray *categoryMArray;


@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) NSXCategotyTableViewController *viewVc;
@property (nonatomic, strong) NSXCategotyTableViewController *viewVc2;
@property (nonatomic, strong) NSXNewsController *viewVc3;


@property (nonatomic, strong) UITableView *tableView;
@end

@implementation NSXCategoryController

-(NSMutableArray *)categoryMArray
{
    if (_categoryMArray == nil) {
        NSXUser *user = [Config getOwnUser];
        NSXCategoryParam *param = [[NSXCategoryParam alloc] init];
        param.userid = user.userId;
        
        [NSXCategory categoryArrayWithParam:param success:^(NSXCategoryResult *result) {
            for (NSXCategory *category in result.categoryArray) {
                NSLog(@"%@-----------------======",category.categoryname);
                
            }
            _categoryMArray = result.categoryArray;
            [self initCategoryView];
           
        } failure:^(NSError *error) {
            
        }];
//        _categoryMArray  = [NSMutableArray arrayWithObjects:
//                       @"编辑标签",
//                       @"科技头条",
//                       @"股票头条",
//                       @"社会热点",
//                       @"大气污染",
//                       @"你懂的",
//                       @"五毛党",
//                       @"国防教育",
//                       @"github排名",
//                       nil];
    }
    return _categoryMArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    [self initMysearchBarAndMysearchDisPlay];
    historyView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+30, [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height, 1, 1)];
    historyView.backgroundColor = [UIColor blackColor];
    [self.navigationController.view addSubview:historyView];
    [self categoryMArray];
    
    

}
-(void)initCategoryView
{
    
    
    //    self.title = @"HMSegmentedControl Demo";
    self.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight);
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    CGFloat viewHeight = CGRectGetHeight(self.view.frame);
    
    // Tying up the segmented control to a scroll view
    self.segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, -10, viewWidth, 30)];
    NSMutableArray *categoryNameMArray = [NSMutableArray array];
    for (NSXCategory *category in self.categoryMArray) {
        NSLog(@"%@",category.categoryname);
        [categoryNameMArray addObject:category.categoryname];
    }
    self.segmentedControl.sectionTitles = categoryNameMArray;
    // @[@"本地音乐", @"收藏",@"最近听过"];
    //,@"Headlines",@"DexSinis"];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.backgroundColor = [UIColor colorWithRed:0.f/255.f green:180.f/255.f blue:255.f/255.f alpha:1.f];
    
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
    self.scrollView.contentSize = CGSizeMake(viewWidth *categoryNameMArray.count, 200);
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, viewWidth, 200) animated:NO];
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i<=self.categoryMArray.count; i++) {
            NSXCategotyTableViewController *viewVc = [[NSXCategotyTableViewController alloc] init];
            viewVc.view.frame  = CGRectMake(i*viewWidth, 0, viewWidth, viewHeight);
            //  viewVc.view.backgroundColor = [UIColor blueColor];
            //        [self setApperanceForLabel:viewVc];
            //    [self.scrollView setContentOffset:CGPointMake(0, 20)];
            [self.scrollView addSubview:viewVc.view];
            [self addChildViewController:viewVc];
    }
    
//    self.viewVc = [[NSXCategotyTableViewController alloc] init];
//    self.viewVc.view.frame  = CGRectMake(0, 0, viewWidth, viewHeight);
//    //  viewVc.view.backgroundColor = [UIColor blueColor];
//    //        [self setApperanceForLabel:viewVc];
//    //    [self.scrollView setContentOffset:CGPointMake(0, 20)];
//    [self.scrollView addSubview:self.viewVc.view];
//    [self addChildViewController:self.viewVc];
//    
//    self.viewVc2 = [[NSXCategotyTableViewController alloc] init];
//    self.viewVc2.view.frame  = CGRectMake(viewWidth, 0, viewWidth, viewHeight);
//    self.viewVc2.view.backgroundColor = [UIColor whiteColor];
//    [self.scrollView addSubview:self.viewVc2.view];
//    [self addChildViewController:self.viewVc2];
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



-(void)initNavigationBar
{
//    UIButton *moreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [moreButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
//    [moreButton addTarget:self action:@selector(handleMore:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithCustomView:moreButton];
//    
//    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [searchButton setImage:[UIImage imageNamed:@"navigationbar-search"] forState:UIControlStateNormal];
//    [searchButton addTarget:self action:@selector(startSearch:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
//    self.navigationItem.rightBarButtonItems = @[moreItem, searchItem];
    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar-sidebar"]
                                                                                        style:UIBarButtonItemStylePlain
                                                                             target:self action:@selector(leftDrawerButtonPress:)];
    
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar-search"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self action:@selector(startSearch:)];

    
  /*  UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.text = @"search";
    label.textAlignment = NSTextAlignmentRight;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(80, 0, 20, 30)];
    [button setTitle:@"^" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleHistory:) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:label];
    [titleView addSubview:button];
    self.navigationItem.titleView = titleView; */
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


- (void)handleHistory:(id)sender
{
    if (self.isHistoryShown)
    {
        CGRect rect = historyView.frame;
        
        [UIView beginAnimations:@"hideHistory" context:nil];
        [UIView setAnimationDuration:0.5f];
        rect.size = CGSizeMake(1, 1);
        historyView.frame = rect;
        [UIView commitAnimations];
        
        self.isHistoryShown = NO;
        return;
    }
    
    
    CGRect rect = historyView.frame;
    
    [UIView beginAnimations:@"showHistory" context:nil];
    [UIView setAnimationDuration:0.5f];
    rect.size = CGSizeMake(100, 100);
    historyView.frame = rect;
    [UIView commitAnimations];
    self.isHistoryShown = YES;
}

-(void)initMysearchBarAndMysearchDisPlay
{
    mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, [UIScreen mainScreen].bounds.size.width, 44)];
    mySearchBar.delegate = self;
    //    //设置选项
    mySearchBar.barTintColor =
    //[UIColor redColor];
    [UIColor colorWithRed:0.f/255.f green:180.f/255.f blue:255.f/255.f alpha:1.f];
    mySearchBar.backgroundColor = [UIColor clearColor];
    mySearchBar.searchBarStyle = UISearchBarStyleDefault;
    mySearchBar.translucent = NO;
    [mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [mySearchBar sizeToFit];
    
    mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:mySearchBar contentsController:self];
    mySearchDisplayController.delegate = self;
    mySearchDisplayController.searchResultsDataSource = self;
    mySearchDisplayController.searchResultsDelegate = self;
    
    suggestResults = [NSMutableArray arrayWithArray:@[@"此处为推荐词", @"也可以为历史记录"]];
}


#pragma mark - UITableViewDataSource & UITableViewDelegate
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == mySearchDisplayController.searchResultsTableView)
    {
        return [self numberOfRowsWithSearchResultTableView];
    }
    return 0;
}



-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == mySearchDisplayController.searchResultsTableView)
    {
        return [self searchTableView:mySearchDisplayController.searchResultsTableView cellForRowAtIndexPath:indexPath];
    }
    else
    {
        static NSString *cellID = @"search_cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        return cell;
    }
}

#pragma mark - handle button click

-(void) startSearch:(id)sender
{
    [self.navigationController.view addSubview:mySearchBar];
    [mySearchBar becomeFirstResponder];
}

-(void) handleMore:(id)sender
{
    
}

#pragma mark - Navigation
/*
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - UISearchBarDelegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [mySearchDisplayController.searchResultsTableView reloadData];
}

#pragma mark - Search Service Methods
- (void)searchForSuggestWithKeyword:(NSString *)keyword
{
    NSLog(@"%@",keyword);
    if (@"符合条件")
    {
        [mySearchDisplayController.searchResultsTableView reloadData];
    }
}

-(void)searchForInfoListWithKeyword:(NSString *)keyword
{
    
}


#pragma mark - UISearchDisplayDelegate
- (void) searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller NS_DEPRECATED_IOS(3_0,8_0)
{
    mySearchDisplayController.searchResultsTableView.contentInset = UIEdgeInsetsMake(mySearchBar.frame.size.height, 0, 0, 0);
    
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView NS_DEPRECATED_IOS(3_0,8_0)
{
    
}

- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller NS_DEPRECATED_IOS(3_0,8_0)
{
    [mySearchBar removeFromSuperview];
}


// return YES to reload table. called when search string/option changes. convenience methods on top UISearchBar delegate methods
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString NS_DEPRECATED_IOS(3_0,8_0)
{
    [self searchForSuggestWithKeyword:mySearchBar.text];
    return NO;
}

#pragma mark - UISearchDisplayController   <UITableViewDataSource> dataSource
-(NSInteger)numberOfRowsWithSearchResultTableView
{
    return suggestResults.count + 1;
}
-(UITableViewCell*)searchTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *suggestId = @"suggestCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:suggestId];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:suggestId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row == suggestResults.count)
    {
        cell.textLabel.text = [NSLocalizedString(@"Search: ", @"查找: ") stringByAppendingString:mySearchBar.text];
    }
    else
    {
        cell.textLabel.text = [suggestResults objectAtIndex:indexPath.row];
    }
    return cell;
}

#pragma mark - UISearchDisplayController <UITableViewDelegate> delegate
-(void) searchTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *keyword = nil;
    if (indexPath.row == suggestResults.count)
    {
        keyword = mySearchBar.text;
        NSLog(@"%@",keyword);
    }
    else
    {
        keyword = [suggestResults objectAtIndex:indexPath.row];
    }
    [mySearchBar resignFirstResponder];
}

@end
