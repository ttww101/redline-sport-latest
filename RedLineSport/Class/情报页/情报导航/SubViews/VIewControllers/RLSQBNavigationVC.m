#import "RLSQBNavigationVC.h"
#import "RLSQBNavigatCell.h"
#import "RLSNavigationModel.h"
#import "RLSFenxiPageVC.h"
#import "RLSLiveScoreModel.h"
@interface RLSQBNavigationVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *arrAllDate;
@property (nonatomic, strong)UITableViewCell *seleCell;
@property (nonatomic, assign)BOOL isToFenxi;
@end
@implementation RLSQBNavigationVC
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[RLSUMStatisticsMgr sharedInstance] viewStaticsBeginWithMarkStr:@"RLSQBNavigationVC"];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.defaultFailure = @"";
    [self setNavView];
    [self.view addSubview:self.tableView];
    [self loadData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[RLSUMStatisticsMgr sharedInstance] viewStaticsEndWithMarkStr:@"RLSQBNavigationVC"];
}
#pragma mark -- setnavView
- (void)setNavView{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"比赛导航";
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
#pragma mark ----------请求数据
- (void)loadData
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,@"/mobile/news/fullList"] Start:^(id requestOrignal) {
        [RLSLodingAnimateView showLodingView];
    } End:^(id responseOrignal) {
        [RLSLodingAnimateView dissMissLoadingView];
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            NSLog(@"%@",responseOrignal);
            _arrAllDate = [[NSMutableArray alloc] initWithArray:[RLSNavigationModel arrayOfEntitiesFromArray: [responseOrignal objectForKey:@"data"]]];
        self.defaultFailure = @"暂无数据";
            [self.tableView reloadData];
        }else{
            self.defaultFailure = [responseOrignal objectForKey:@"msg"];
            [self.tableView reloadData];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure = errorDict;
        [self.tableView reloadData];
    }];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = colorTableViewBackgroundColor;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
    }
    return _tableView;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@""]) {
        return [UIImage imageNamed:@"white"];
    }
    if ([self.defaultFailure isEqualToString:@"似乎已断开与互联网的连接。"]) {
        return [UIImage imageNamed:@"dNotnet"];
    }
    return [UIImage imageNamed:@"d1"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@""]) {
        NSString *text = @"暂无数据";
        NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
    NSString *text = self.defaultFailure;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrAllDate.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *aCell = @"acell";
    RLSQBNavigatCell *cell = [tableView dequeueReusableCellWithIdentifier:aCell];
    if (!cell) {
        cell = [[RLSQBNavigatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aCell];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = colorF5;
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = _arrAllDate[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RLSNavigationModel *model = _arrAllDate[indexPath.row];
    [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",(long)model.mid] toindex:2];
}
- (void)toFenxiWithMatchId:(NSString *)idID toindex:(NSInteger)index
{
    if (!_isToFenxi == YES) {
        _isToFenxi = YES;
    }else{
        return;
    }
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@"3" forKey:@"flag"];
    [parameter setObject:idID forKey:@"sid"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveScores] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            RLSLiveScoreModel *model = [RLSLiveScoreModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            model.neutrality = NO;
            RLSFenxiPageVC *fenxiVC = [[RLSFenxiPageVC alloc] init];
            fenxiVC.model = model;
            fenxiVC.currentIndex = index;
            fenxiVC.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:fenxiVC animated:YES];
        }
        _isToFenxi = NO;
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        _isToFenxi = NO;
    }];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    CGPoint point = [scrollView.panGestureRecognizer locationInView:self.tableView];
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
    _seleCell=[self.tableView cellForRowAtIndexPath:indexPath];
    _seleCell.backgroundColor = colorF5;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _seleCell.backgroundColor = [UIColor whiteColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
