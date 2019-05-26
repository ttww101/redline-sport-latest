#import "RLSNewRecommandVC.h"
#import "RLSTitleIndexView.h"
#import "RLSPageScrollView.h"
#import "RLSBangDanTableView.h"
#import "RLSRecommandListModel.h"
@interface RLSNewRecommandVC ()<PageScrollViewDateSource,PageScrollViewDelegate,TitleIndexViewDelegate>
@property (nonatomic, strong) RLSPageScrollView *scrollView;
@property (nonatomic, strong) RLSTitleIndexView *titleView;
@property (nonatomic, strong)RLSBangDanTableView *tableView;
@property (nonatomic, strong)RLSBangDanTableView *tableViewWeek;
@property (nonatomic, strong)RLSBangDanTableView *tableViewMon;
@property (nonatomic, strong)RLSBangDanTableView *tableViewAll;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) NSArray *arrDataTwo;
@property (nonatomic, strong) NSArray *arrDataThree;
@property (nonatomic, strong) NSArray *arrDataFour;
@property (nonatomic, assign) NSInteger ListItemWeek;
@property (nonatomic, assign)BOOL yesORno;
@property (nonatomic , strong) UIImageView *triangleImageView;
@end
@implementation RLSNewRecommandVC
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
     self.navigationController.navigationBar.hidden = NO;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaultFailure = @"";
    [self setNavView];
    _yesORno = NO;
    if(self.typeList == typeListOne){
        _ListItemWeek = 0;
        for (int i = 0; i < 4; i ++) {
            [self setNumGetData:i];
        }
    }else{
        [self setNumGetDataTwo];
    }
}
- (void)setNumGetData:(NSInteger)num{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    NSString *urlStr = url_rankingquery;
    switch (num) {
        case 0:
        {
            [parameter setObject:@"1" forKey:@"type"];
            [parameter setObject:@"1" forKey:@"ranktype"];
        }
            break;
        case 1:
        {
            [parameter setObject:@"1" forKey:@"type"];
            [parameter setObject:@"1" forKey:@"ranktype"];
            urlStr = url_rankingqueryWM;
        }
            break;
        case 2:
        {
            [parameter setObject:@"2" forKey:@"type"];
            [parameter setObject:@"1" forKey:@"ranktype"];
            urlStr = url_rankingqueryWM;
        }
            break;
        case 3:
        {
            [parameter setObject:@"3" forKey:@"type"];
            [parameter setObject:@"1" forKey:@"ranktype"];
        }
            break;
        default:
            break;
    }
    [self loadDataRecommandListParameter:parameter urlStr:urlStr num:num];
}
- (void)setNumGetDataTwo{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    NSString *urlStr = @"";
    if (self.typeList == typeListTwo){
        [parameter setObject:@"3" forKey:@"type"];
        [parameter setObject:@"2" forKey:@"ranktype"];
    }else if (self.typeList == typeListFore){
        [parameter setObject:@"3" forKey:@"type"];
        [parameter setObject:@"3" forKey:@"ranktype"];
    }else if (self.typeList == typeListThree){
    }else if (self.typeList == typeListFive){
        [parameter setObject:@"4" forKey:@"type"];
        [parameter setObject:@"1" forKey:@"ranktype"];
    }
    urlStr = url_rankingquery;
    [self loadDataRecommandListParameter:parameter urlStr:urlStr num:0];
}
- (void)didSelectedTitle:(UIButton *)sender {
    UIButton *btn = (UIButton *)sender;
    CGPoint center = _triangleImageView.center;
    center.x = btn.center.x;
    _triangleImageView.center = center;
    if (btn.tag == 0) {
        self.typeList = typeListOne;
    } else if (btn.tag == 1) {
        self.typeList = typeListFore;
    } else if (btn.tag == 2) {
        self.typeList = typeListFive;
    } else if (btn.tag == 3) {
        self.typeList = typeListTwo;
    }
    if(self.typeList == typeListOne){
        _ListItemWeek = 0;
        for (int i = 0; i < 4; i ++) {
            [self setNumGetData:i];
        }
        if (_titleView) {
            _titleView.hidden = false;
        }
        _scrollView.frame = CGRectMake(0, _titleView.bottom, Width, Height - _titleView.bottom);
    }else{
        [self setNumGetDataTwo];
        if (_titleView) {
            _titleView.hidden = YES;
        }
        _scrollView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar);
    }
}
#pragma mark -- setnavView
- (void)setNavView{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = self.titleStr;
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@"tuijianDTLeftImage"] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@"tuijianDTLeftImage"] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
    NSArray *titleArray = @[@"排行榜", @"连红榜", @"盈利榜", @"人气榜"];
    nav.labTitle.hidden = YES;
    UIView *indexView = [UIView new];
    indexView.frame = CGRectMake(nav.btnLeft.right, 0, nav.width - (nav.btnLeft.width * 2), nav.height);
    CGFloat width = indexView.width / titleArray.count;
    for (NSInteger i = 0; i < titleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(i * width, 20, width, indexView.height - 20);
        [btn addTarget:self action:@selector(didSelectedTitle:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = font15;
        btn.tag = i;
        [indexView addSubview:btn];
    }
    [nav addSubview:indexView];
    _triangleImageView = [UIImageView new];
    _triangleImageView.image = [UIImage imageNamed:@"ic_triangle"];
    _triangleImageView.frame = CGRectMake(0, indexView.height - 10, 20, 10);
    _triangleImageView.contentMode = UIViewContentModeScaleAspectFill;
    [indexView addSubview:_triangleImageView];
    CGPoint center = _triangleImageView.center;
    center.x = width / 2;
    _triangleImageView.center = center;
    self.view.backgroundColor = [UIColor whiteColor];
    _titleView = [[RLSTitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 50)];
    _titleView.selectedIndex = 0;
    _titleView.arrData = @[@"近7天",@"周榜",@"月榜",@"总榜",];
    _titleView.delegate =self;
    if (self.typeList == typeListOne) {
        [self.view addSubview:_titleView];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _titleView.bottom-1, Width, 0.5)];
        lineView.backgroundColor = colorCellLine;
        [self.view addSubview:lineView];
        _scrollView = [[RLSPageScrollView alloc] initWithFrame:CGRectMake(0, _titleView.bottom, Width, Height - _titleView.bottom)];
    }else{
        _scrollView = [[RLSPageScrollView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar)];
    }
    _scrollView.dateSource = self;
    _scrollView.pageDelegate = self;
    _scrollView.selectedIndex = 0;
    [self.view addSubview:_scrollView];
}
- (void)loadDataRecommandListParameter:(NSMutableDictionary *)parameterDic urlStr:(NSString *)url num:(NSInteger)num
{
    [RLSLodingAnimateView showLodingView];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameterDic PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url] Start:^(id requestOrignal) {
        if (self.typeList == typeListOne && !_yesORno) {
            _yesORno = YES;
            if (_ListItemWeek == 0) {
            }
        }else if (self.typeList != typeListOne){
        }
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            [RLSLodingAnimateView dissMissLoadingView];
            self.defaultFailure = @"";
            if (self.typeList == typeListOne) {
                switch (num) {
                    case 0:{
                        _arrData = [[NSArray alloc] initWithArray:[RLSRecommandListModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
                        self.defaultFailure = @"暂无数据";
                        NSLog(@"%@",responseOrignal);
                    }
                        break;
                    case 1:{
                        _arrDataTwo = [[NSArray alloc] initWithArray:[RLSRecommandListModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
                    }
                        break;
                    case 2:{
                        _arrDataThree = [[NSArray alloc] initWithArray:[RLSRecommandListModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
                    }
                        break;
                    case 3:{
                        _arrDataFour = [[NSArray alloc] initWithArray:[RLSRecommandListModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
                    }
                        break;
                    default:
                        break;
                }
                [_scrollView reloadData];
            }else{
                self.defaultFailure = @"暂无数据";
                _arrData = [[NSArray alloc] initWithArray:[RLSRecommandListModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
                [_scrollView reloadData];
            }
        }else{
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [RLSLodingAnimateView dissMissLoadingView];
    }];
}
- (void)didSelectedAtIndex:(NSInteger)index
{
    _ListItemWeek = index;
    [_scrollView updateSelectedIndex:index];
}
- (void)scrollToPageIndex:(NSInteger)index
{
    _ListItemWeek = index;
    [_titleView updateSelectedIndex:index];
}
- (UITableView *)pageScrollView:(RLSPageScrollView *)pageScroll tableViewForIndex:(NSInteger)index
{
    _tableView = [[RLSBangDanTableView alloc] initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
    [self createHeard:_tableView];
    if (self.typeList == typeListOne) {
        switch (index) {
            case 0:{
                _tableView.defaultTitle = self.defaultFailure;
                _tableView.labStr = @"盈利率";
                _tableView.labStrTwo = @"胜率";
                _tableView.typeNum = self.typeList;
                _tableView.arrData = _arrData;
                return _tableView;
            }
                break;
            case 1:{
                _tableViewWeek = [[RLSBangDanTableView alloc] initWithFrame:CGRectMake(Width * 1, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
                [self createHeard:_tableViewWeek];
                _tableViewWeek.defaultTitle = self.defaultFailure;
                _tableViewWeek.labStr = @"盈利率";
                _tableViewWeek.labStrTwo = @"胜率";
                _tableViewWeek.typeNum = self.typeList;
                _tableViewWeek.arrData = _arrDataTwo;
                return _tableViewWeek;
            }
                break;
            case 2:{
                _tableViewMon = [[RLSBangDanTableView alloc] initWithFrame:CGRectMake(Width * 2, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
                [self createHeard:_tableViewMon];
                _tableViewMon.defaultTitle = self.defaultFailure;
                _tableViewMon.labStr = @"盈利率";
                _tableViewMon.labStrTwo = @"胜率";
                _tableViewMon.typeNum = self.typeList;
                _tableViewMon.arrData = _arrDataThree;
                return _tableViewMon;
            }
                break;
            case 3:{
                _tableViewAll = [[RLSBangDanTableView alloc] initWithFrame:CGRectMake(Width * 3, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
                [self createHeard:_tableViewAll];
                _tableViewAll.defaultTitle = self.defaultFailure;
                _tableViewAll.labStr = @"盈利率";
                _tableViewAll.labStrTwo = @"胜率";
                _tableViewAll.typeNum = self.typeList;
                _tableViewAll.arrData = _arrDataFour;
                return _tableViewAll;
            }
                break;
            default:
                break;
        }
    }else if (self.typeList == typeListFore){
        _tableView.defaultTitle = self.defaultFailure;
        _tableView.labStr = @"最长连红";
        _tableView.labStrTwo = @"最近连红";
        _tableView.typeNum = self.typeList;
        _tableView.arrData = _arrData;
    }else if ( self.typeList == typeListThree){
        _tableView.defaultTitle = self.defaultFailure;
        _tableView.labStr = @"最长连黑";
        _tableView.labStrTwo = @"最近连黑";
        _tableView.typeNum = self.typeList;
        _tableView.arrData = _arrData;
    }else if (self.typeList == typeListFive){
        _tableView.defaultTitle = self.defaultFailure;
        _tableView.labStr = @"总盈利率";
        _tableView.labStrTwo = @"总盈利";
        _tableView.typeNum = self.typeList;
        _tableView.arrData = _arrData;
    }
    else{
        _tableView.defaultTitle = self.defaultFailure;
        _tableView.labStr = @"粉丝数";
        _tableView.labStrTwo = @"";
        _tableView.typeNum = self.typeList;
        _tableView.arrData = _arrData;
    }
    return _tableView;
}
- (void)createHeard:(UITableView *)tabel{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataByHeader)];
    header.stateLabel.font = font13;
    header.lastUpdatedTimeLabel.hidden = YES;
    tabel.mj_header = header;
}
#pragma mark ---- 下啦刷新
- (void)refreshDataByHeader{
    if(self.typeList == typeListOne){
        [self setNumGetData:_ListItemWeek];
    }else{
        [self setNumGetDataTwo];
    }
}
- (NSInteger)numberOfIndexInPageSrollView:(RLSPageScrollView *)pageScroll
{
    if (self.typeList == typeListOne) {
        return 4;
    }
    return 1;
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
        RLSWebVC *webV = [[RLSWebVC alloc] init];
        webV.strtitle = @"排行榜规则";
        webV.strurl=BANGDAN_API_HTML;
        webV.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:webV animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
