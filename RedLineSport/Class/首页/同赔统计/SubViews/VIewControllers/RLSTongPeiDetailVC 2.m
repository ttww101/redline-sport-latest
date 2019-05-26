#define cellTongPeiDetailVC @"cellTongPeiDetailVC"
#import "RLSTongPeiDetailVC.h"
#import "RLSTongpeiDetailCell.h"
#import "RLSTongpeiDTResultView.h"
#import "RLSTongpeiDTTitileView.h"
#import "RLSTongPeiSwitch.h"
#import "RLSTitleIndexView.h"
#import "RLSTongpeiDTModel.h"
#import "RLSTongPeiPeiLvDTVC.h"
@interface RLSTongPeiDetailVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,TongPeiSwitchDelegate,TitleIndexViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RLSTitleIndexView *titleView;
@property (nonatomic, strong) RLSTongpeiDTModel *spfModel;
@property (nonatomic, strong) RLSTongpeiDTModel *yaModel;
@property (nonatomic, strong) RLSTongpeiDTModel *dxModel;
@property (nonatomic, strong) RLSTongpeiDTModel *currentModel;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIImageView *imageRedAngle;
@end
@implementation RLSTongPeiDetailVC
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
    self.defaultFailure  = @"暂无数据";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadTongpeiDetailData];
    _titleView = [[RLSTitleIndexView alloc] initWithFrame:CGRectMake(0, Height - 44, Width, 44)];
    _titleView.selectedIndex = 0;
    _titleView.seletedColor = redcolor;
    _titleView.lineColor = [UIColor whiteColor];
    _titleView.bottomLineColor = [UIColor whiteColor];
    _titleView.nalColor = color33;
    _titleView.arrData = @[@"胜平负",@"亚指",@"进球数",];
    _titleView.delegate =self;
    [self.view addSubview:_titleView];
    _imageRedAngle = [[UIImageView alloc] initWithFrame:CGRectMake(Width/3/2 - 17/2, 44 - 9, 17, 9)];
    _imageRedAngle.image = [UIImage imageNamed:@"redAngleTongpei"];
    [_titleView addSubview:_imageRedAngle];
    _imageRedAngle.frame = CGRectMake(Width/3/2 + Width/3*_pelvIndex - 17/2, 44 - 9, 17, 9);
    [_titleView updateSelectedIndex:_pelvIndex];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, Height - 44, Width, 0.5)];
    line.backgroundColor = colorCellLine;
    [self.view addSubview:line];
}
- (void)didSelectedAtIndex:(NSInteger)index
{
    _currentIndex = 0;
    switch (index) {
        case 1:
            _currentModel = _yaModel;
            break;
        case 2:
            _currentModel = _dxModel;
            break;
        case 0:
            _currentModel = _spfModel;
            break;
        default:
            break;
    }
    _pelvIndex = index;
    _imageRedAngle.frame = CGRectMake(Width/3/2 + Width/3*index - 17/2, 44 - 9, 17, 9);
    [self.tableView reloadData];
}
#pragma mark -- setnavView
- (void)setNavView
{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = isNUll(_currentModel.all.homeTeam)?@"同赔指数详情": [NSString stringWithFormat:@"%@ vs %@",_currentModel.all.homeTeam,_currentModel.all.guestTeam] ;
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
#pragma mark -- UITableViewDataSource
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[RLSTongpeiDetailCell class] forCellReuseIdentifier:cellTongPeiDetailVC];
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.backgroundColor = [UIColor whiteColor]
        ;        [self setupTableViewMJHeader];
    }
    return _tableView;
}
- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView.mj_header endRefreshing];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 185 - 40)];
    header.backgroundColor = [UIColor whiteColor];
    UILabel *labTitle  = [[UILabel alloc] init];
    labTitle.font = font12;
    labTitle.textColor = color33;
    labTitle.text = _currentIndex == 0? [NSString stringWithFormat:@"%@初赔%@%@%@,同赔指数结果",_currentModel.all.company,_currentModel.all.win,_currentModel.all.draw,_currentModel.all.lose] : [NSString stringWithFormat:@"%@初赔%@%@%@,同赔指数结果",_currentModel.same.company,_currentModel.same.win,_currentModel.same.draw,_currentModel.same.lose];
    UIView *viewDetail = [[UIView alloc] init];
    [header addSubview:viewDetail];
    [viewDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left);
        make.top.equalTo(header.mas_top).offset(12.5);
        make.size.mas_equalTo(CGSizeMake(Width, 35));
    }];
    RLSTongpeiDTResultView *resultView = [[RLSTongpeiDTResultView alloc] initWithFrame:CGRectMake(0, 0, Width, 35)];
    resultView.type = _currentIndex;
    resultView.model = _currentIndex == 0? _currentModel.all : _currentModel.same;
    [viewDetail addSubview:resultView];
    UILabel *labDetail = [[UILabel alloc] init];
    labDetail.textColor = color33;
    labDetail.font = font12;
    [header addSubview:labDetail];
    [labDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left).offset(15);
        make.top.equalTo(viewDetail.mas_bottom).offset(35.5);
    }];
    labDetail.text = @"历史样本详情";
    RLSTongPeiSwitch *btnSwitch = [[RLSTongPeiSwitch alloc] init];
    btnSwitch.delegate = self;
    [btnSwitch setSelectedIndex:_currentIndex];
    [header addSubview:btnSwitch];
    [btnSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(header.mas_right).offset(-15);
        make.centerY.equalTo(labDetail.mas_centerY);
        make.size.mas_offset(CGSizeMake(120, 29));
    }];
    UIView *viewListTitle = [[UIView alloc] init];
    [header addSubview:viewListTitle];
    [viewListTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left);
        make.top.equalTo(labDetail.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(Width, 30));
    }];
    if (_currentIndex == 0) {
        if (_currentModel.all.matchs.count == 0) {
            labTitle.text = @"同赔指数结果";
        }else{
            RLSTongpeiDTTitileView *titleView = [[RLSTongpeiDTTitileView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
            [viewListTitle addSubview:titleView];
        }
    }
    if (_currentIndex == 1) {
        if (_currentModel.same.matchs.count == 0) {
            labTitle.text = @"同赔指数结果";
        }else{
            RLSTongpeiDTTitileView *titleView = [[RLSTongpeiDTTitileView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
            [viewListTitle addSubview:titleView];
        }
    }
    return header;
    return nil;
}
- (void)didSelectedIndex:(NSInteger )index
{
    _currentIndex = index;
    [self.tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 185 - 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _currentIndex == 0? _currentModel.all.matchs.count :_currentModel.same.matchs.count  ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RLSTongpeiDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTongPeiDetailVC];
    if (!cell) {
        cell = [[RLSTongpeiDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTongPeiDetailVC];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.pelvIndex = _pelvIndex;
    cell.model =_currentIndex == 0? [_currentModel.all.matchs objectAtIndex:indexPath.row] : [_currentModel.same.matchs objectAtIndex:indexPath.row];
    return cell;
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void)loadTongpeiDetailData
{
    [[RLSDependetNetMethods sharedInstance] requestSameOdd_detailWithscheduleId:[NSString stringWithFormat:@"%ld",_scheduleId] WithsclassId:[NSString stringWithFormat:@"%ld",_sclassId] Start:^(id requestOrignal) {
        [RLSLodingAnimateView showLodingView];
    } End:^(id responseOrignal) {
        [RLSLodingAnimateView dissMissLoadingView];
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] intValue]== 200) {
            _spfModel = [RLSTongpeiDTModel entityFromDictionary:[[responseOrignal objectForKey:@"data"] objectForKey:@"spf"]];
            _dxModel = [RLSTongpeiDTModel entityFromDictionary:[[responseOrignal objectForKey:@"data"] objectForKey:@"dx"]];
            _yaModel = [RLSTongpeiDTModel entityFromDictionary:[[responseOrignal objectForKey:@"data"] objectForKey:@"ya"]];
            switch (_pelvIndex) {
                case 1:
                    _currentModel = _yaModel;
                    break;
                case 2:
                    _currentModel = _dxModel;
                    break;
                case 0:
                    _currentModel = _spfModel;
                    break;
                default:
                    break;
            }
            [self.tableView reloadData];
        }
        [self setNavView];
        [self.view addSubview:self.tableView];
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [self setNavView];
        self.defaultFailure  = errorDict;
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
