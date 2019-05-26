#define cellBaolengDetailVC @"cellBaolengDetailVC"
#import "RLSBaolengDetailVC.h"
#import "RLSBaolengDTHeaderView.h"
#import "RLSBaolengSwitch.h"
#import "RLSBaolengDTcell.h"
#import "RLSBaolengDTTitleView.h"
#import "RLSBaolengDetailModel.h"
@interface RLSBaolengDetailVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,BaolengSwitchDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RLSBaolengDetailModel*baolengModel;
@property (nonatomic, strong) RLSBaolengDetailModel*leaguecoldinfo;
@property (nonatomic, strong) RLSBaolengDetailModel*historycoldinfo;
@property (nonatomic, strong) RLSBaolengDetailModel*allcoldinfo;
@property (nonatomic, assign) NSInteger currentIndex;
@end
@implementation RLSBaolengDetailVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark -- setnavView
- (void)setNavView
{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = isNUll(_allcoldinfo.body.teamname)?@"统计明细": [NSString stringWithFormat:@"%@ vs %@",_allcoldinfo.body.hometeam,_allcoldinfo.body.guestteam] ;
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaultFailure = @"暂无数据";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavView];
    [self.view addSubview:self.tableView];
    [self loadBaolengDetailData];
}
#pragma mark -- UITableViewDataSource
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[RLSBaolengDTcell class] forCellReuseIdentifier:cellBaolengDetailVC];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        [self setupTableViewMJHeader];
    }
    return _tableView;
}
- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 195)];
    header.backgroundColor = [UIColor whiteColor];
    UILabel *labTitle  = [[UILabel alloc] init];
    labTitle.font = font12;
    labTitle.textColor = color33;
    [header addSubview:labTitle];
    [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left).offset(15);
        make.top.equalTo(header.mas_top).offset(12.5);
    }];
    labTitle.text =@"" ;
    UIView *viewDetail = [[UIView alloc] init];
    [header addSubview:viewDetail];
    [viewDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left);
        make.top.equalTo(labTitle.mas_bottom).offset(17.5);
        make.size.mas_equalTo(CGSizeMake(Width, 45));
    }];
    RLSBaolengDTHeaderView *baolengDT = [[RLSBaolengDTHeaderView alloc] initWithFrame:CGRectMake(0, 0, Width, 45)];
    baolengDT.model = _baolengModel.body;
    [viewDetail addSubview:baolengDT];
    UILabel *labDetail = [[UILabel alloc] init];
    labDetail.textColor = color33;
    labDetail.font = font12;
    [header addSubview:labDetail];
    [labDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left).offset(15);
        make.top.equalTo(viewDetail.mas_bottom).offset(35.5);
    }];
    labDetail.text = [NSString stringWithFormat:@"历史爆冷%ld场",_baolengModel.body.num];
    RLSBaolengSwitch *btnSwitch = [[RLSBaolengSwitch alloc] init];
    btnSwitch.delegate = self;
    [btnSwitch setSelectedIndex:_currentIndex];
    [header addSubview:btnSwitch];
    [btnSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(header.mas_right).offset(-15);
        make.centerY.equalTo(labDetail.mas_centerY);
        make.size.mas_offset(CGSizeMake(180, 29));
    }];
    UIView *viewListTitle = [[UIView alloc] init];
    [header addSubview:viewListTitle];
    [viewListTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left);
        make.top.equalTo(labDetail.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(Width, 30));
    }];
    if (_baolengModel.list.count != 0) {
        RLSBaolengDTTitleView *titleV = [[RLSBaolengDTTitleView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
        [viewListTitle addSubview:titleV];
    }
    return header;
    return nil;
}
- (void)didSelectedBaolengSwitchIndex:(NSInteger )index
{
    _currentIndex = index;
    switch (index) {
        case 0:
        {
            _baolengModel = _allcoldinfo;
        }
            break;
        case 1:
        {
            _baolengModel = _leaguecoldinfo;
        }
            break;
        case 2:
        {
            _baolengModel = _historycoldinfo;
        }
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 195;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _baolengModel.list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RLSBaolengDTcell *cell = [tableView dequeueReusableCellWithIdentifier:cellBaolengDetailVC];
    if (!cell) {
        cell = [[RLSBaolengDTcell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellBaolengDetailVC];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [_baolengModel.list objectAtIndex:indexPath.row];
    return cell;
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void)loadBaolengDetailData
{
    [[RLSDependetNetMethods sharedInstance] requestSurpriseWithType:[NSString stringWithFormat:@"%ld",_idId] Start:^(id requestOrignal) {
        [RLSLodingAnimateView showLodingView];
    } End:^(id responseOrignal) {
        [RLSLodingAnimateView dissMissLoadingView];
    } Success:^(id responseResult, id responseOrignal) {
        if ([responseOrignal objectForKey:@"code"]) {
            _leaguecoldinfo = [RLSBaolengDetailModel entityFromDictionary:[[responseOrignal objectForKey:@"data"] objectForKey:@"leaguecoldinfo"]];
            _historycoldinfo = [RLSBaolengDetailModel entityFromDictionary:[[responseOrignal objectForKey:@"data"] objectForKey:@"historycoldinfo"]];
            _allcoldinfo = [RLSBaolengDetailModel entityFromDictionary:[[responseOrignal objectForKey:@"data"] objectForKey:@"allcoldinfo"]];
            _baolengModel = _allcoldinfo;
            [self setNavView];
            [self.tableView reloadData];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
