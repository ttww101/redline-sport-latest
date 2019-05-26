#import "RLSPlycModel.h"
#import "RLSYapanZhoushouVC.h"
#import "RLSTitleIndexView.h"
#import "RLSPlycSelectedView.h"
#import "RLSYpasCell.h"
#import "RLSYpasTwoCell.h"
#define  cellYpasCell @"cellYpasCell"
#define  cellYpasTwoCell @"cellYpasTwoCell"
@interface RLSYapanZhoushouVC ()<TitleIndexViewDelegate,PlycSelectedViewdelegate,UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) RLSTitleIndexView *titleView;
@property (nonatomic, strong) RLSPlycSelectedView *selectedView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger currentPlay;
@property (nonatomic, assign) NSInteger currentTime;
@property (nonatomic, strong) RLSBasicTableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrdata;
@property (nonatomic, assign) NSInteger limitStart;
@property (nonatomic, assign) NSInteger limitNum;
@end
@implementation RLSYapanZhoushouVC
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
    self.defaultFailure = @"";
    [self setNavView];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"yapanzhushouIndex"];
    self.view.backgroundColor = [UIColor whiteColor];
    _titleView = [[RLSTitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 48)];
    _titleView.selectedIndex = 0;
    _titleView.backgroundColor = [UIColor whiteColor];
    _titleView.seletedColor = redcolor;
    _titleView.lineColor = redcolor;
    _titleView.nalColor = color33;
    _titleView.bottomLineColor = colorTableViewBackgroundColor;
    _titleView.arrData = @[@"盘口监控",@"水位监控",];
    _titleView.delegate =self;
    [self.view addSubview:_titleView];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, _titleView.bottom, Width, 10)];
    headerView.backgroundColor = colorTableViewBackgroundColor;
    [self.view addSubview:headerView];
    [self.view addSubview:self.tableView];
    _selectedView = [[RLSPlycSelectedView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
    _selectedView.delegate = self;
    _selectedView.alpha = 0;
    _selectedView.hidden = YES;
    [self.view addSubview:_selectedView];
    [self loadPeilvYichangVCDataWithType:loadDataFirst];
}
- (void)didselectedPlycSelectedViewWithPlayIndex:(NSInteger)playIndex
{
    _selectedView.alpha = 0;
    _selectedView.hidden = YES;
    _currentPlay = playIndex;
    [[NSUserDefaults standardUserDefaults] setInteger:playIndex forKey:@"yapanzhushouIndex"];
    [self loadPeilvYichangVCDataWithType:loadDataReload];
}
- (void)didselectedPlycSelectedViewWithTimeIndex:(NSInteger)TimeIndex
{
    _selectedView.alpha = 0;
    _selectedView.hidden = YES;
    _currentTime = TimeIndex;
    [self loadPeilvYichangVCDataWithType:loadDataReload];
}
- (void)touchPlycSelectedViewBGView
{
    _selectedView.alpha = 0;
    _selectedView.hidden = YES;
}
- (void)setNavView
{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    if (_typeOdd == 0) {
        nav.labTitle.text = @"亚指助手";
    }else{
        nav.labTitle.text = @"深度大小";
    }
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    nav.btnRight.frame = CGRectMake(nav.btnRight.x - nav.btnRight.width, nav.btnRight.y, nav.btnRight.width*2, nav.btnRight.height);
    UIImageView *imageSL = [[UIImageView alloc] init];
    imageSL.image = [UIImage imageNamed:@"plycShaixuan"];
    [nav addSubview:imageSL];
    [imageSL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(nav.mas_right).offset(-15);
        make.centerY.equalTo(nav.labTitle.mas_centerY);
    }];
    UILabel *labSL = [[UILabel alloc] init];
    labSL.font = font16;
    labSL.textColor = [UIColor whiteColor];
    labSL.text = @"筛选 ";
    [nav addSubview:labSL];
    [labSL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imageSL.mas_left);
        make.centerY.equalTo(nav.labTitle.mas_centerY);
    }];
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
        _selectedView.alpha = 1;
        _selectedView.hidden = NO;
    }
}
- (void)didSelectedAtIndex:(NSInteger)index
{
    _currentIndex = index;
    [self loadPeilvYichangVCDataWithType:loadDataReload];
}
- (void)loadPeilvYichangVCDataWithType:(loadDataType)type
{
    [self.tableView.mj_footer resetNoMoreData];
    switch (type) {
        case loadDataFirst:
        {
            _limitStart = 0;
            _limitNum = 10;
            _arrdata = [NSMutableArray array];
        }
            break;
        case loadDataReload:
        {
            _limitStart = 0;
            _limitNum = 10;
            _arrdata = [NSMutableArray array];
        }
            break;
        case loadDataMoredata:
        {
            _limitStart = _limitStart + 10;
            _limitNum = 10 ;
        }
            break;
        default:
            break;
    }
    NSLog(@"loadPeilvYichangVCData");
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:[NSString stringWithFormat:@"%ld",_currentTime] forKey:@"timeType"];
    [parameter setObject:[NSString stringWithFormat:@"%ld",_limitStart] forKey:@"limitStart"];
    [parameter setObject:[NSString stringWithFormat:@"%ld",_limitNum] forKey:@"limitNum"];
        [parameter setObject:[NSString stringWithFormat:@"%ld",_currentIndex + 1] forKey:@"type"];
    if (_currentPlay != 0) {
        [parameter setObject:[NSString stringWithFormat:@"%ld",_currentPlay] forKey:@"matchType"];
    }
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,_typeOdd == 0? url_letgoalAbnormalindex :url_totalAbnormalindex] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] integerValue] == 200) {
            self.defaultFailure = @"暂无数据";
            NSArray *arr = [NSArray arrayWithArray:[RLSPlycModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
            [_arrdata  addObjectsFromArray: arr ];
            if (type == loadDataMoredata) {
                [self.tableView reloadData];
                if (arr.count == 0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }else{
                [self.tableView reloadData];
                [self.tableView setContentOffset:CGPointZero];
            }
        }else{
            self.defaultFailure =[responseOrignal objectForKey:@"msg"];
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure =errorDict;
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
#pragma mark -- UITableViewDataSource
- (RLSBasicTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[RLSBasicTableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 48 + 10, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 48 - 10) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[RLSYpasCell class] forCellReuseIdentifier:cellYpasCell];
        [_tableView registerClass:[RLSYpasTwoCell class] forCellReuseIdentifier:cellYpasTwoCell];
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
        [self loadPeilvYichangVCDataWithType:loadDataReload];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self loadPeilvYichangVCDataWithType:loadDataMoredata];
        }];
        self.tableView.mj_footer = footer;
        self.tableView.mj_footer.hidden = YES;
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrdata.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentIndex == 0) {
        RLSPlycModel *mod = [_arrdata objectAtIndex:indexPath.row];
        return 128 + mod.panProcess.count *20;
    }else{
        return 128;
    }
    return 125;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentIndex == 0) {
        RLSYpasCell *cell = [tableView dequeueReusableCellWithIdentifier:cellYpasCell];
        if (!cell) {
            cell = [[RLSYpasCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellYpasCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = [_arrdata objectAtIndex:indexPath.row];
        cell.typeOdd = _typeOdd;
        return cell;
    }else{
        RLSYpasTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellYpasTwoCell];
        if (!cell) {
            cell = [[RLSYpasTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellYpasTwoCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = [_arrdata objectAtIndex:indexPath.row];
        return cell;
    }
    return [UITableViewCell new];
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (tableView.contentSize.height > tableView.frame.size.height) {
        tableView.mj_footer.hidden = NO;
    }else{
        tableView.mj_footer.hidden = YES;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.contentSize.height > tableView.frame.size.height) {
        tableView.mj_footer.hidden = NO;
    }else{
        tableView.mj_footer.hidden = YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
