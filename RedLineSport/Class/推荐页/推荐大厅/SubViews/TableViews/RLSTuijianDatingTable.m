#import "RLSTuijianDatingCell.h"
#import "RLSTuijianDatingTable.h"
#import "RLSTuijianSelectedItemTitleView.h"
#import "RLSTuijianSelectedItemView.h"
#import "RLSNewRecommandVC.h"
#define CellTuijianDating @"CellTuijianDating"
@interface RLSTuijianDatingTable()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,TuijianSelectedItemTitleViewDelegate,TuijianSelectedItemViewDelegate>
@property (nonatomic,strong) RLSTuijianSelectedItemView *selectedView;
@property (nonatomic,strong) RLSTuijianSelectedItemTitleView *titleView;
@property (nonatomic, assign) BOOL hideFooter;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, assign) NSInteger limitStart;
@property (nonatomic, strong) NSString *list;
@property (nonatomic, strong) NSString *play;
@property (nonatomic, strong) NSString *attentioned;
@property (nonatomic, strong) NSString *state;
@end
@implementation RLSTuijianDatingTable
#pragma mark -- UITableViewDataSource
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style playType:(NSInteger)type;
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        self.defaultTitle = @"";
        [self registerClass:[RLSTuijianDatingCell class] forCellReuseIdentifier:CellTuijianDating];
        self.delegate =self;
        self.dataSource = self;
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        [self setupTableViewMJHeader];
        _list = @"0";
        _play = @"0";
        _attentioned = @"0";
        _state = @"2";
        _playType = type;
        if (_playType == 0) {
            [self loadDataByloadDataType:loadDataFirst];
        } else {
            NSString *playTetx = nil;
            if (_playType == 0) {
                playTetx = @"全部玩法";
            } else if (_playType == 1) {
                playTetx = @"胜平负";
            } else if (_playType == 2) {
                playTetx = @"让球";
            } else if (_playType == 3) {
                playTetx = @"进球数";
            }
            [self selectedWithItem:0 WithIndex:_playType WithTitle:playTetx];
            self.selectedView.play = _playType;
        }
    }
    return self;
}
- (void)addSelectedView
{
    [self.superview addSubview:self.selectedView];
}
- (void)showOrhideMatchView
{
    if (_selectedView.hidden) {
        _selectedView.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            _selectedView.alpha = 1;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _selectedView.alpha = 0;
        }completion:^(BOOL finished) {
            _selectedView.hidden = YES;
        }];
    }
}
- (RLSTuijianSelectedItemView *)selectedView
{
    if (!_selectedView) {
        _selectedView = [[RLSTuijianSelectedItemView alloc] initWithFrame:CGRectMake(0 ,0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar)];
        _selectedView.arrSaishi = [NSArray array];
        _selectedView.hidden = YES;
        _selectedView.alpha = 0;
        _selectedView.delegate = self;
    }
    return _selectedView;
}
- (void)touchBgView
{
    [self showOrhideMatchView];
}
- (void)selectedWithItem:(NSInteger)item WithIndex:(NSInteger)index WithTitle:(NSString *)title
{
    [self showOrhideMatchView];
    [self.titleView updateSelectedIndexWithindex:item WithTitle:title];
    switch (item) {
        case 0:
        {
            _play = [NSString stringWithFormat:@"%ld",index];
        }
            break;
            case 1:
        {
            if (index == 0) {
                _state = @"2";
            }else if (index == 1){
                _state = @"-1";
            }else if (index == 2){
                _state = @"1";
            } else if (index == 3){
                _state = @"0";
            } else {
            }
        }
            break;
            case 2:
        {
            if (index == 2) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"tuijianDTShowProfit"];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"tuijianDTShowProfit"];
            }
            switch (index) {
                case 0:
                    _list = @"0";
                    break;
                case 1:
                    _list = @"1";
                    break;
                case 2:
                    _list = @"2";
                    break;
                case 3:
                    _list = @"4";
                    break;
                case 4:
                    _list = @"0";
                    break;
                case 5:
                    _list = @"0";
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    [self loadDataByloadDataType:loadDataHeaderRefesh];
}
- (void)touchWithItem:(NSInteger)item WithIndex:(NSInteger)index WithTitle:(NSString *)title
{
    if (item == 3) {
        if (![RLSMethods login]) {
            [RLSMethods toLogin];
            return;
        }
        _attentioned = [_attentioned isEqualToString:@"0"]? @"1" : @"0";
        [self.titleView attentionBtnSelected:[_attentioned isEqualToString:@"0"]? NO:YES];
        [self.selectedView updateWithIndexAttentioned:[_attentioned isEqualToString:@"0"]? NO:YES];
        [self loadDataByloadDataType:loadDataHeaderRefesh];
        [self showOrhideMatchView];
    }else{
    [self showOrhideMatchView];
    [self.titleView updateSelectedIndexWithindex:item WithTitle:title];
    }
}
- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataByloadDataType:loadDataHeaderRefesh];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadDataByloadDataType:loadDataMoredata];
    }];
    self.mj_footer = footer;
    self.mj_footer.hidden = YES;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
        [self.mj_header beginRefreshing];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultTitle isEqualToString:@""]) {
        return [UIImage imageNamed:@"white"];
    }
    if ([self.defaultTitle isEqualToString:@"似乎已断开与互联网的连接。"]) {
        return [UIImage imageNamed:@"dNotnet"];
    }
    return [UIImage imageNamed:@"d1"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultTitle isEqualToString:@""]) {
        NSString *text = @"暂无数据";
        NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
    NSString *text = self.defaultTitle;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
        return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 44 + 10)];
    header.backgroundColor = colorTableViewBackgroundColor;
    [header addSubview:self.titleView];
    return header;
}
- (void)btnClickbangDan:(UIButton *)btn
{
    RLSNewRecommandVC *recmdLVC = [[RLSNewRecommandVC alloc] init];
    if (btn.tag == 0) {
        recmdLVC.typeList = typeListOne;
    }else if(btn.tag == 1){
        recmdLVC.typeList = typeListFive;
    }else if(btn.tag == 2){
        recmdLVC.typeList = typeListFore;
    }else if (btn.tag ==3){
        recmdLVC.typeList = typeListTwo;
    }else if (btn.tag == 4){
        recmdLVC.typeList = typeListThree;
    }
    NSArray *arrStr = @[@"专家榜",@"盈利榜",@"连红榜",@"人气榜",@"明灯榜"];
    recmdLVC.titleStr = arrStr[btn.tag];
    recmdLVC.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:recmdLVC animated:YES];
}
- (RLSTuijianSelectedItemTitleView *)titleView
{
    if (!_titleView) {
        _titleView = [[RLSTuijianSelectedItemTitleView alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
        _titleView.backgroundColor = [UIColor whiteColor];
        _titleView.delegate = self;
    }
    return _titleView;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 54;
}
- (void)tapTuijianSelectedItemTitleViewAtindex:(NSInteger)index
{
    if (index ==3) {
        if (![RLSMethods login]) {
            [RLSMethods toLogin];
            return;
        }
        _attentioned = [_attentioned isEqualToString:@"0"]? @"1" : @"0";
        [self.titleView attentionBtnSelected:[_attentioned isEqualToString:@"0"]? NO:YES];
        [self.selectedView updateWithIndexAttentioned:[_attentioned isEqualToString:@"0"]? NO:YES];
        [self loadDataByloadDataType:loadDataHeaderRefesh];
    }else{
        [self showOrhideMatchView];
        [_selectedView updateWithIndex:index];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_arrData.count<=0) {
        return [UITableViewCell new];
    }
    RLSTuijianDatingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTuijianDating];
    if (!cell) {
        cell = [[RLSTuijianDatingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTuijianDating];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_arrData.count>0) {
        cell.type = typeTuijianCellDating;
        cell.model = [_arrData objectAtIndex:indexPath.row];
        if (!_hideFooter) {
            if (indexPath.row == _arrData.count -15) {
                [self.mj_footer beginRefreshing];
            }
        }
    }
    return cell;
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_arrData.count<=0) {
        return 0;
    }
    return 190;
    return 0;
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (_hideFooter) {
        tableView.mj_footer.hidden = YES;
    }else{
        if (tableView.contentSize.height > tableView.frame.size.height) {
            tableView.mj_footer.hidden = NO;
        }else{
            tableView.mj_footer.hidden = YES;
        }
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_hideFooter) {
        tableView.mj_footer.hidden = YES;
    }else{
        if (tableView.contentSize.height > tableView.frame.size.height) {
            tableView.mj_footer.hidden = NO;
        }else{
            tableView.mj_footer.hidden = YES;
        }
    }
}
- (void)loadDataByloadDataType:(loadDataType)loadType;
{
    [self.mj_footer resetNoMoreData];
    switch (loadType) {
        case loadDataFirst:
        {
            _limitStart = 0;
            self.arrData = [[NSMutableArray alloc] init];
        }
            break;
        case loadDataMoredata:
        {
            _limitStart = _limitStart + 20;
        }
            break;
        case loadDataHeaderRefesh:
        {
            _limitStart = 0;
            if (!self.arrData) {
                self.arrData = [[NSMutableArray alloc] init];
            }
            [self.arrData removeAllObjects];
        }
            break;
        default:
            break;
    }
    NSMutableDictionary *parmater = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parmater setObject:_list forKey:@"sort"];
    [parmater setObject:_play forKey:@"playtype"];
    [parmater setObject:_attentioned forKey:@"focuse"];
    if (![_state isEqualToString:@"2"]) {
        [parmater setObject:_state forKey:@"matchState"];
    }
    [parmater setObject:@"0" forKey:@"hot"];
    [parmater setObject:[NSString stringWithFormat:@"%ld",(long)_limitStart] forKey:@"limitStart"];
    [parmater setObject:@"20" forKey:@"limitNum"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parmater PathUrlL:[[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_newlistrecommend] copy] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshing];
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            self.defaultTitle = @"暂无推荐，你要做头条吗";
            NSArray *arr = [RLSTuijiandatingModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]];
            self.hideFooter = NO;
            if (arr.count == 0) {
                if (loadType != loadDataMoredata){
                    self.arrData = [[NSMutableArray alloc] initWithArray:arr];
                }else{
                    [self.mj_footer endRefreshingWithNoMoreData];
                }
                self.defaultPage = defaultPageThird;
                [self reloadData];
            }else{
                [self.arrData addObjectsFromArray:arr];
                if (loadType != loadDataMoredata){
                    [self reloadData];
                    [self setContentOffset:CGPointZero animated:NO];
                }else{
                    [self reloadData];
                }
            }
        }else{
            self.defaultTitle = [responseOrignal objectForKey:@"msg"];
            [self reloadData];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultTitle  =errorDict;
        [self reloadData];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
- (void)loadShaixuanItems
{
    NSArray *arrUrl_jsonRecommand = @[@"all.json",@"hot.json",@"jc.json",@"bd.json",@"zc.json"];
    for (int i = 0; i<arrUrl_jsonRecommand.count; i++) {
        [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:[NSString stringWithFormat:@"%@%@%@",APPDELEGATE.url_jsonHeader,@"/recommend/",[arrUrl_jsonRecommand objectAtIndex:i]] Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
        } Success:^(id responseResult, id responseOrignal) {
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        }];
    }
}
@end
