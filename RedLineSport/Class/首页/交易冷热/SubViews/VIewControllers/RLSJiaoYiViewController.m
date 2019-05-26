#import "RLSJiaoYiViewController.h"
#import "RLSTitleIndexView.h"
#import "RLSPageScrollView.h"
#import "RLSJiaoYiNewTabelView.h"
#import "RLSJiaoYiModel.h"
@interface RLSJiaoYiViewController ()<PageScrollViewDateSource,PageScrollViewDelegate,TitleIndexViewDelegate>
@property (nonatomic, strong) RLSPageScrollView *scrollView;
@property (nonatomic, strong) RLSTitleIndexView *titleView;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, retain) RLSJiaoYiNewTabelView *tableView1;
@property (nonatomic, retain) RLSJiaoYiNewTabelView *tableView2;
@property (nonatomic, retain) RLSJiaoYiNewTabelView *tableView3;
@end
@implementation RLSJiaoYiViewController
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = false;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    _selectedIndex = 0;
    _titleView = [[RLSTitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 44)];
    _titleView.selectedIndex = 0;
    _titleView.nalColor = colorFFD8D6;
    _titleView.seletedColor = [UIColor whiteColor];
    _titleView.lineColor = [UIColor whiteColor];
    _titleView.backgroundColor = redcolor;
    _titleView.arrData = @[@"总交易量",@"机构盈利",@"机构亏损"];
    _titleView.delegate =self;
    [self.view addSubview:_titleView];
    _scrollView = [[RLSPageScrollView alloc] initWithFrame:CGRectMake(0, _titleView.bottom, Width, Height - _titleView.bottom)];
    _scrollView.dateSource = self;
    _scrollView.pageDelegate = self;
    _scrollView.selectedIndex = 0;
    [self.view addSubview:_scrollView];
    [_scrollView reloadData];
}
- (void)didSelectedAtIndex:(NSInteger)index
{
    [_scrollView updateSelectedIndex:index];
}
- (void)scrollToPageIndex:(NSInteger)index
{
    [_titleView updateSelectedIndex:index];
}
- (RLSJiaoYiNewTabelView *)tableView1
{
    if (!_tableView1) {
        _tableView1 = [[RLSJiaoYiNewTabelView alloc]initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
    }
    return _tableView1;
}
- (RLSJiaoYiNewTabelView *)tableView2
{
    if (!_tableView2) {
        _tableView2 = [[RLSJiaoYiNewTabelView alloc]initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
    }
    return _tableView2;
}
- (RLSJiaoYiNewTabelView *)tableView3
{
    if (!_tableView3) {
        _tableView3 = [[RLSJiaoYiNewTabelView alloc]initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
    }
    return _tableView3;
}
- (UITableView *)pageScrollView:(RLSPageScrollView *)pageScroll tableViewForIndex:(NSInteger)index
{
    if (index== 0) {
        [self.tableView1 updateWithType:3];
        return self.tableView1;
    }else if(index == 1){
        [self.tableView2 updateWithType:1];
        return self.tableView2;
    }else{
        [self.tableView3 updateWithType:2];
        return self.tableView3;
    }
    return [UITableView new];
}
- (NSInteger)numberOfIndexInPageSrollView:(RLSPageScrollView *)pageScroll
{
    return 3;
}
- (void)setNavView{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"交易冷热";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
