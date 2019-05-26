#import "RLSNewQingBaoViewController.h"
#import "RLSNewQingBaoCell.h"
#import "RLSFenxiPageVC.h"
#import "RLSLiveScoreModel.h"
#import "RLSQBNavigationVC.h"
#import "RLSWebModel.h"
#import "RLSToolWebViewController.h"
#import "GBPopMenuButtonView.h"
#define aCell @"cellNewQingBaoViewController"

@interface RLSNewQingBaoViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate, GBMenuButtonDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrAllDate;
@property (nonatomic, strong) MJRefreshAutoNormalFooter *footer;
@property (nonatomic, assign) NSInteger limitStart;
@property (nonatomic, strong) UITableViewCell *seleCell;
@property (nonatomic, assign) BOOL isToFenxi;
@property (nonatomic, strong) GBPopMenuButtonView *menuButtonView;
@end
@implementation RLSNewQingBaoViewController
-(void)menuButtonSelectedAtIdex:(NSInteger)index {
    NSLog(@"%ldl", index);
    if (index == 0) {
        if(![RLSMethods login]) {
            [RLSMethods toLogin];
        } else {
            RLSToolWebViewController *target =[[RLSToolWebViewController alloc] init];
            RLSWebModel *model = [[RLSWebModel alloc]init];
            model.title = PARAM_IS_NIL_ERROR(@"聊天室");
            model.webUrl = PARAM_IS_NIL_ERROR(@"https://mobile.gunqiu.com/appH5/gqpro/chat2/#/?roomId=3");
            model.hideNavigationBar = YES;
            model.parameter = nil;
            target.model = model;
            [self.navigationController pushViewController:target animated:YES];
            [MobClick event:@"syjc2" label:@""];
        }
    } else if (index == 1) {
        if(![RLSMethods login]) {
            [RLSMethods toLogin];
            return;
        }
        RLSFabuTuijianSelectedItemVC *control= [[RLSFabuTuijianSelectedItemVC alloc]init];
        [self.navigationController pushViewController:control animated:true];
    } else {}
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[RLSUMStatisticsMgr sharedInstance] viewStaticsBeginWithMarkStr:@"RLSNewQingBaoViewController"];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaultFailure = @"";
    [self setNavView];
    [self.view addSubview:self.tableView];
    [self setupHeader];
    [self setupFooter];
    _limitStart = 0;
     [self.tableView.mj_header beginRefreshing];
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTableViewContentOffsetZero) name:NotificationsetThirdTableViewContentOffsetZero object:nil];
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    _tableView.backgroundView = backgroundImage;
    
    _menuButtonView = [[GBPopMenuButtonView alloc] initWithItems:@[@"聊天", @"form_publish",@"formReload"] size:CGSizeMake(50, 50) type:GBMenuButtonTypeLineTop isMove:YES];
    _menuButtonView.delegate = self;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    _menuButtonView.frame = CGRectMake(width - 70, height - 125, 50, 50);
    [self.view addSubview:_menuButtonView];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[RLSUMStatisticsMgr sharedInstance] viewStaticsEndWithMarkStr:@"RLSNewQingBaoViewController"];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)setTableViewContentOffsetZero{
    [self.tableView setContentOffset:CGPointZero animated:YES];
}
#pragma mark -- setnavView
- (void)setNavView{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"资讯";
    [nav.btnRight setTitle:@"比赛" forState:UIControlStateNormal];
    [nav.btnRight setTitle:@"比赛" forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
}
#pragma mark ----------请求数据
- (void)loadData
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@(_limitStart) forKey:@"limitStart"];
    [parameter setObject:@"20" forKey:@"limitNum"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,@"/news/v1.2/infolist"] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            if (_limitStart == 0) {
               _arrAllDate = [[NSMutableArray alloc] initWithArray:[RLSQingBaoFPTwoModel arrayOfEntitiesFromArray: [responseOrignal objectForKey:@"data"]]];
            }else{
                NSArray *arr = [[NSMutableArray alloc] initWithArray:[RLSQingBaoFPTwoModel arrayOfEntitiesFromArray: [responseOrignal objectForKey:@"data"]]];
                if (arr.count == 0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [_arrAllDate addObjectsFromArray:arr];
                }
            }
            self.defaultFailure = @"暂无情报，你要做头条吗";
        }else{
            self.defaultFailure = [responseOrignal objectForKey:@"msg"];
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
        [self.tableView reloadData];
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure = errorDict;
        [self.tableView reloadData];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[RLSNewQingBaoCell class] forCellReuseIdentifier:aCell];
        _tableView.backgroundColor = colorTableViewBackgroundColor;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
    }
    return _tableView;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    [self.tableView.mj_header beginRefreshing];
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
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
- (void)setupHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataByHeader)];
    header.stateLabel.font = font13;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
}
- (void)setupFooter
{
    _footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataByfooter)];
}
#pragma mark ---- 下啦刷新
- (void)refreshDataByHeader{
    _limitStart = 0;
    [self loadData];
}
#pragma makr ---- 上拉加载
- (void)loadMoreDataByfooter{
     _limitStart += 20;
    [self loadData];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (tableView.contentSize.height > tableView.frame.size.height) {
        tableView.mj_footer = _footer;
    }else{
        tableView.mj_footer = nil;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.contentSize.height > tableView.frame.size.height) {
        tableView.mj_footer = _footer;
    }else{
        tableView.mj_footer = nil;
    }
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
        RLSQBNavigationVC *navigat = [[RLSQBNavigationVC alloc] init];
        navigat.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:navigat animated:YES];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_arrAllDate.count == 0) {
        return 0;
    }
    return _arrAllDate.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RLSQingBaoFPTwoModel *model = _arrAllDate[indexPath.section];
    CGFloat heiContent = [RLSMethods getTextHeightStationWidth:[NSString stringWithFormat:@"       %@",model.content] anWidthTxtt:Width - 30 anfont:14 andLineSpace:5.5 andHeaderIndent:0];
    if (heiContent > 84) {
        heiContent = 83.32;
    }
    CGFloat heiTitle = [RLSMethods getTextHeightStationWidth:model.title anWidthTxtt:Width - 30 anfont:20 andLineSpace:5 andHeaderIndent:0];
    return   heiContent + heiTitle + 74;
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RLSNewQingBaoCell *cell = [tableView dequeueReusableCellWithIdentifier:aCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[RLSNewQingBaoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aCell];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = colorF5;
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = _arrAllDate[indexPath.section];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RLSQingBaoFPTwoModel *_matchModel = [_arrAllDate objectAtIndex:indexPath.section];
    [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",(long)_matchModel.sid] toindex:2];
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
        _isToFenxi= NO;
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
