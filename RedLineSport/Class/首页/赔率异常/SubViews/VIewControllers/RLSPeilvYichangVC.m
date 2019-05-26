#define cellPlycCell @"cellPlycCell"
#import "RLSPlycModel.h"
#import "RLSPlycCell.h"
#import "RLSPeilvYichangVC.h"
#import "RLSTitleIndexView.h"
#import "RLSPlycPeilvView.h"
#import "RLSPlycSelectedView.h"
@interface RLSPeilvYichangVC ()<TitleIndexViewDelegate,PlycPeilvViewdelegate,PlycSelectedViewdelegate,UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) RLSTitleIndexView *titleView;
@property (nonatomic, strong) UIImageView *imageMore;
@property (nonatomic, strong) RLSPlycPeilvView *peilView;
@property (nonatomic, strong) RLSPlycSelectedView *selectedView;
@property (nonatomic, assign) NSInteger currentPeilv;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger currentPlay;
@property (nonatomic, assign) NSInteger currentTime;
@property (nonatomic, strong) RLSBasicTableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrdata;
@property (nonatomic, assign) NSInteger limitStart;
@property (nonatomic, assign) NSInteger limitNum;
@end
@implementation RLSPeilvYichangVC
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
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"peilvyichangshouIndex"];
    self.view.backgroundColor = [UIColor whiteColor];
    _titleView = [[RLSTitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 48)];
    _titleView.selectedIndex = 0;
    _titleView.backgroundColor = [UIColor whiteColor];
    _titleView.seletedColor = redcolor;
    _titleView.lineColor = [UIColor whiteColor];
    _titleView.nalColor = color33;
    _titleView.bottomLineColor = colorTableViewBackgroundColor;
    _titleView.arrData = @[@"全部",@"胜赔",@"平赔",@"负赔"];
    _titleView.delegate =self;
    [self.view addSubview:_titleView];
    [self.view addSubview:self.tableView];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, _titleView.bottom, Width, 23)];
    headerView.backgroundColor = colorTableViewBackgroundColor;
    [self.view addSubview:headerView];
    _imageMore =[[UIImageView alloc] init];
    _imageMore.image = [UIImage imageNamed:@"plycXiala"];
    [headerView addSubview:_imageMore];
    [_imageMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView.mas_centerX);
        make.centerY.equalTo(headerView.mas_centerY);
    }];
    UIView *touchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 23)];
    touchView.center = CGPointMake(headerView.width/2, touchView.center.y);
    [headerView addSubview:touchView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchViewTap)];
    [touchView addGestureRecognizer:tap];
    _peilView = [[RLSPlycPeilvView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
    _peilView.delegate = self;
    _peilView.alpha = 0;
    _peilView.hidden = YES;
    [self.view addSubview:_peilView];
    _selectedView = [[RLSPlycSelectedView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
    _selectedView.delegate = self;
    _selectedView.alpha = 0;
    _selectedView.hidden = YES;
    [self.view addSubview:_selectedView];
    [self loadPeilvYichangVCDataWithType:loadDataFirst];
}
- (void)didselePlycPeilvViewWithIndex:(NSInteger)index
{
    _peilView.alpha = 0;
    _peilView.hidden = YES;
    _currentPeilv = index;
    [self loadPeilvYichangVCDataWithType:loadDataReload];
}
- (void)touchPlycPeilvViewBgView
{
    _peilView.alpha = 0;
    _peilView.hidden = YES;
}
- (void)didselectedPlycSelectedViewWithPlayIndex:(NSInteger)playIndex
{
    _selectedView.alpha = 0;
    _selectedView.hidden = YES;
    _currentPlay = playIndex;
    [[NSUserDefaults standardUserDefaults] setInteger:playIndex forKey:@"peilvyichangshouIndex"];
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
- (void)touchViewTap
{
    _peilView.alpha = 1;
    _peilView.hidden = NO;
}
- (void)setNavView
{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"指数异常";
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
    if (_currentIndex != 0) {
        [parameter setObject:[NSString stringWithFormat:@"%ld",_currentIndex] forKey:@"type"];
    }
    if (_currentPeilv != 0) {
        [parameter setObject:[NSString stringWithFormat:@"%ld",_currentPeilv] forKey:@"oddType"];
    }
    if (_currentPlay != 0) {
        [parameter setObject:[NSString stringWithFormat:@"%ld",_currentPlay] forKey:@"matchType"];
    }
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_oddsAbnormalindex] Start:^(id requestOrignal) {
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
        _tableView = [[RLSBasicTableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 48 + 23, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 48 - 23) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[RLSPlycCell class] forCellReuseIdentifier:cellPlycCell];
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
    return 139;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RLSPlycCell *cell = [tableView dequeueReusableCellWithIdentifier:cellPlycCell];
    if (!cell) {
        cell = [[RLSPlycCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellPlycCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [_arrdata objectAtIndex:indexPath.row];
    return cell;
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
