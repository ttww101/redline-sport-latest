#import "RLSBuyRecordsVC.h"
#import "RLSBuyerModel.h"
@interface RLSBuyRecordsVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UITableViewCell *seleCell;
@property (nonatomic, assign)NSInteger limitStart;
@property (nonatomic, strong) MJRefreshAutoNormalFooter *footer;
@property (nonatomic, strong)NSMutableArray *arrData;
@end
@implementation RLSBuyRecordsVC
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
    self.defaultFailure = @"暂无付费用户";
    [self.view addSubview:self.tableView];
    [self setupHeader];
    [self setupFooter];
    _limitStart = 0;
    [self .tableView.mj_header beginRefreshing];
}
#pragma mark ----------请求数据
- (void)loadData
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@(_limitStart) forKey:@"limitStart"];
    [parameter setObject:@"20" forKey:@"limitNum"];
    [parameter setObject:@(self.newsID) forKey:@"newsId"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_BuyersUrl] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            NSLog(@"%@",responseOrignal);
            if (_limitStart == 0) {
                _arrData = [[NSMutableArray alloc] initWithArray:[RLSBuyerModel arrayOfEntitiesFromArray: [responseOrignal objectForKey:@"data"]]];
            }else{
                NSArray *arr = [[NSMutableArray alloc] initWithArray:[RLSBuyerModel arrayOfEntitiesFromArray: [responseOrignal objectForKey:@"data"]]];
                if (arr.count == 0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [_arrData addObjectsFromArray:arr];
                }
            }
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
        self.defaultFailure = @"暂无付费用户";
        [self.tableView reloadData];
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure = errorDict;
        [self.tableView reloadData];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
- (void)setNavView{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"付费用户";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
}
- (UITableView *)tableView{
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
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@"似乎已断开与互联网的连接。"]) {
        return [UIImage imageNamed:@"dNotnet"];
    }
    return [UIImage imageNamed:@"d1"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = self.defaultFailure;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrData.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *acell = @"acell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:acell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:acell];
    }
    [cell.contentView removeAllSubViews];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = colorF5;
    cell.backgroundColor = [UIColor whiteColor];
    RLSBuyerModel *model = self.arrData[indexPath.row];
    UIView *basView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 70)];
    basView.backgroundColor = [UIColor clearColor];
    UIImageView *imgPhoto = [[UIImageView alloc] init];
    imgPhoto.layer.cornerRadius = 20;
    imgPhoto.layer.masksToBounds = YES;
    [imgPhoto sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.extension2 ]] placeholderImage:[UIImage imageNamed:@"defaultPic"]];
    [basView addSubview:imgPhoto];
    [imgPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(basView.mas_left).offset(15);
        make.centerY.equalTo(basView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    UILabel *labName = [[UILabel alloc] init];
    labName.font = font14;
    labName.textColor = color33;
    labName.text = model.nickname;
    [basView addSubview:labName];
    [labName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgPhoto.mas_right).offset(10);
        make.centerY.equalTo(basView.mas_centerY);
    }];
    UILabel *labTime = [[UILabel alloc] init];
    labTime.font = font13;
    labTime.textColor = color99;
    labTime.text = [NSString stringWithFormat:@"%@",[RLSMethods getDateByStyle:@"MM-dd HH:mm" withDate:[NSDate dateWithTimeIntervalSince1970:[model.created doubleValue]/1000]]];;
    [basView addSubview:labTime];
    [labTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(basView.mas_right).offset(-15);
        make.centerY.equalTo(labName.mas_centerY);
    }];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 69.5, Width, 0.5)];
    lineView.backgroundColor = colorDD;
    [basView addSubview:lineView];
    [cell.contentView addSubview:basView];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RLSBuyerModel *model = self.arrData[indexPath.row];
    RLSUserViewController *userVC = [[RLSUserViewController alloc] init];
    userVC.userId = model.userId;
    userVC.userName = model.nickname;
    userVC.userPic = model.extension2;
    userVC.Number=1;
    userVC.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:userVC animated:YES];
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
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
