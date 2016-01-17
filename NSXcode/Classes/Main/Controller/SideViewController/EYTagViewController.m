//
//  ViewController.m
//  EYTagView_Example
//
//  Created by ericyang on 8/9/15.
//  Copyright (c) 2015 Eric Yang. All rights reserved.
//3

#import "EYTagViewController.h"
#import "EYTagView.h"

#import "NSXCategory.h"
#import "NSXCategory+Provider.h"
#import "NSXCategoryParam.h"
#import "NSXCategoryResult.h"

#import "Config.h"
#import "NSXUser.h"

@interface EYTagViewController ()<EYTagViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UISearchBar *mySearchBar;
    UISearchDisplayController *mySearchDisplayController;
    NSMutableArray *suggestResults;
    UIView *historyView;
}
@property (nonatomic, assign) BOOL isHistoryShown;
@property (strong, nonatomic) EYTagView *tagView;

@property (nonatomic, strong) NSMutableArray *categoryMArray;

@end

@implementation EYTagViewController
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
            [self initTagView];
            
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
    [self initMysearchBarAndMysearchDisPlay];
    historyView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+30, [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height, 1, 1)];
    historyView.backgroundColor = [UIColor blackColor];
    [self.navigationController.view addSubview:historyView];
    
    [self categoryMArray];
}

-(void)initTagView
{
    _tagView=[[EYTagView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight)];
    [self.view addSubview:_tagView];
    _tagView.translatesAutoresizingMaskIntoConstraints=YES;
    _tagView.backgroundColor =[UIColor whiteColor];
    _tagView.delegate=self;
    
    _tagView.colorTag=COLORRGB(0xffffff);
    _tagView.colorTagBg=COLORRGB(0x2ab44e);
    _tagView.colorInput=COLORRGB(0x2ab44e);
    _tagView.colorInputBg=COLORRGB(0xffffff);
    _tagView.colorInputPlaceholder=COLORRGB(0x2ab44e);
    //    _tagView.backgroundColor=COLORRGB(0xffffff);
    _tagView.colorInputBoard=COLORRGB(0x2ab44e);
    //    _tagView.viewMaxHeight=20;
    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self action:@selector(dissEYTagViewController)];
    
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar-search"]
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self action:@selector(startSearch:)];
    
    NSMutableArray *categoryNameMArray = [NSMutableArray array];
    for (NSXCategory *category in self.categoryMArray) {
        [categoryNameMArray addObject:category.categoryname];
    }
    [_tagView addTags:categoryNameMArray];

}

-(void)dissEYTagViewController
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)layout:(id)sender {
    [_tagView layoutTagviews];
}

-(void)heightDidChangedTagView:(EYTagView *)tagView{
    NSLog(@"heightDidChangedTagView");
}
- (IBAction)toggleType:(UISwitch*)sender {
    _tagView.type=sender.on?EYTagView_Type_Edit:EYTagView_Type_Display;
}
- (IBAction)handlerSegmentAction:(UISegmentedControl*)sender {
    _tagView.type=(EYTagView_Type)sender.selectedSegmentIndex;
    NSLog(@"sa",_tagView.type);
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    
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
