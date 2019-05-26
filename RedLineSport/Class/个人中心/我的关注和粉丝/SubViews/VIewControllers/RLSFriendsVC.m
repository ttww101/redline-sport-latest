#import "RLSFriendsVC.h"
#import "RLSTitleIndexView.h"
#import "RLSPageScrollView.h"
#import "RLSFansModel.h"
#import "RLSFansTable.h"
@interface RLSFriendsVC ()<PageScrollViewDateSource,PageScrollViewDelegate,TitleIndexViewDelegate>
@property (nonatomic, strong) RLSPageScrollView *scrollView;
@property (nonatomic, strong) RLSTitleIndexView *titleView;
@property (nonatomic, strong) NSArray *arrFollowers;
@property (nonatomic, strong) NSArray *arrFocus;
@end
@implementation RLSFriendsVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
    self.defaultFailure = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    _titleView = [[RLSTitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 44)];
    _titleView.selectedIndex = _selectedIndex;
    _titleView.bottomLineColor = colorDD;
    _titleView.arrData = @[@"关注",@"粉丝"];
    _titleView.delegate =self;
    [self.view addSubview:_titleView];
    _scrollView = [[RLSPageScrollView alloc] initWithFrame:CGRectMake(0, _titleView.bottom, Width, Height - _titleView.bottom)];
    _scrollView.dateSource = self;
    _scrollView.pageDelegate = self;
    _scrollView.selectedIndex = _selectedIndex;
    [self.view addSubview:_scrollView];
    [_scrollView reloadData];
    [self loadFriendsDataWithIndex:0];
    [self loadFriendsDataWithIndex:1];
}
- (void)didSelectedAtIndex:(NSInteger)index
{
    [_scrollView updateSelectedIndex:index];
}
- (void)scrollToPageIndex:(NSInteger)index
{
    [_titleView updateSelectedIndex:index];
}
- (UITableView *)pageScrollView:(RLSPageScrollView *)pageScroll tableViewForIndex:(NSInteger)index
{
    if (index== 0) {
        RLSFansTable *table = [[RLSFansTable alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.defaultTitle = self.defaultFailure;
        table.arrData = _arrFocus;
        return table;
    }else{
        RLSFansTable *table = [[RLSFansTable alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.defaultTitle = self.defaultFailure;
        table.arrData = _arrFollowers;
        return table;
    }
    return [UITableView new];
}
- (NSInteger)numberOfIndexInPageSrollView:(RLSPageScrollView *)pageScroll
{
    return 2;
}
#pragma mark -- setnavView
- (void)setNavView
{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"我的好友";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
    }
}
- (void)loadFriendsDataWithIndex:(NSInteger)index
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)_userId] forKey:@"targetId"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,index == 1? url_followerlist:url_focuslist] Start:^(id requestOrignal) {
        if (index == 0) {
            [RLSLodingAnimateView showLodingView];
        }
    } End:^(id responseOrignal) {
        if (index == 0) {
            [RLSLodingAnimateView dissMissLoadingView];
        }
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            self.defaultFailure = @"暂无好友";
            if (index == 0) {
                _arrFocus = [[NSArray alloc] initWithArray:[RLSFansModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
            }else{
                _arrFollowers = [[NSArray alloc] initWithArray:[RLSFansModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
            }
            [_scrollView reloadData];
        }else{
            self.defaultFailure = [responseOrignal objectForKey:@"msg"];
            [_scrollView reloadData];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure = errorDict;
        [_scrollView reloadData];
        if (index ==0) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
