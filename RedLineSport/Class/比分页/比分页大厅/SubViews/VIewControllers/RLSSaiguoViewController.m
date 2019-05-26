#define  cellSaiguoViewController @"cellSaiguoViewController"
#import "RLSSaiTableViewCell.h"
#import "RLSLiveScoreModel.h"
#import "RLSQiciModel.h"
#import "RLSBIfenSelectedSaishiModel.h"
#import "RLSJSbifenModel.h"
#import "RLSSaiguoViewController.h"
#import "RLSSelectedDataView.h"
#import "RLSSelectedDateTitleView.h"
#import "RLSSelectedSaiGuoTitleView.h"
#import "RLSDCindexBtn.h"
#import "RLSSelectedDTitleView.h"
#import "RLSHSInfiniteScrollView.h"
#import "RLSHSDashLineView.h"


#import "RLSSaishiSelecterdVC.h"
#import "DatePickerView.h"


#define COLOR [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1]
#define NUMBER_OF_VISIBLE_VIEWS 5
@interface RLSSaiguoViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,SelecterDateViewDelegate,SelectedDateTitleViewDelegate,DCindexBtnDelegate,SelectedSaiGuoTitleViewDelegate, DatePickerViewDelegate>
@property (nonatomic, strong) NSMutableArray *arrDataQici;
@property (nonatomic, assign) NSInteger currentFlag;
@property (nonatomic, assign) NSInteger titleFlag;
@property (nonatomic, assign) NSInteger currentdate;
@property (nonatomic, assign) NSInteger titleTemFlag;
@property (nonatomic, strong) UIButton *selectedHeaderBtn;
@property (nonatomic, assign) CGFloat       seletedHeight;
@property (nonatomic, strong) RLSSelectedDateTitleView *dataTitleView;
@property (nonatomic, strong) RLSSelectedSaiGuoTitleView *saiGuoTitleView;
@property (nonatomic, assign) CGFloat                         viewSize;
@property (nonatomic, strong) RLSDCindexBtn *indexBtn;
@property (nonatomic, strong) UITableViewCell *seleCell;
@property (nonatomic, strong) UIView        *dataLineView;



@property (nonatomic, copy) NSDictionary *filterDic; // 记录筛选值 由广播发送过来


@end
@implementation RLSSaiguoViewController

#pragma mark - DatePickerViewDelegate

- (void)didSelectedDate:(NSString *)selectDate {
    _date = [selectDate copy];
    [self loadDataQiciJishiViewController];
}

- (void)RLSSelectedDateTitleViewDidAction:(NSArray *)array {
    DatePickerView *picker =  [DatePickerView showDatePicker:array title:@"近7天完场赛事"];
    picker.delegate = self;
}

- (NSString *)getJSONMessage:(NSDictionary *)messageDic {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:messageDic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}


#pragma mark - Notification

- (void)loadFilterData:(NSNotification *)notifi {
    NSDictionary *dic = notifi.userInfo[@"paramer"];
    if ([dic[ParamtersTimeline] isEqualToString:@"old"]) {
        self.filterDic = dic;
        [self loadDataQiciJishiViewController];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[NSUserDefaults standardUserDefaults]setObject:dic forKey:localNew];
            [[NSUserDefaults standardUserDefaults]synchronize];
        });
    }
}

#pragma mark - ************  以下高人所写  ************

- (id)init
{
    self = [super init];
    if (self) {
            [self.view addSubview:self.dataTitleView];
            [self.dataTitleView addSubview:self.dataLineView];
        [self.view addSubview:self.tableView];
        [self.view addSubview:self.indexBtn];
        self.view.backgroundColor = [UIColor whiteColor];
         self.filterDic = [[NSUserDefaults standardUserDefaults]objectForKey:localNew];
        [self loadDataQiciJishiViewController];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeShowType) name:@"NSNotificationchangeShowType" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ContenViewTapFresh:) name:biFenTitleChange object:@"biFenChange"];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.viewSize = CGRectGetWidth(self.view.bounds) / NUMBER_OF_VISIBLE_VIEWS;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaultFailure = @"";
    self.seletedHeight = 60;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadFilterData:) name:FilterPageNotification object:nil];
}
- (void)changeShowType
{
    if (_currentFlag == 0) {
        [self headerRefreshData];
    }
}
- (void)ContenViewTapFresh:(NSNotification *)noti {
    self.titleFlag = (long)[noti.userInfo objectForKey:@"bifenTitleFlag"];
}
- (UIView *)dataLineView {
    if (!_dataLineView) {
        _dataLineView = [[UIView alloc] initWithFrame:CGRectMake(0,0, Width, 1)];
        _dataLineView.backgroundColor = colorEEEEEE;
    }
    return _dataLineView;
}

- (RLSSelectedDateTitleView *)dataTitleView {
    if (!_dataTitleView) {
        _dataTitleView = [[RLSSelectedDateTitleView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44+60+14, Width, 39)];
        _dataTitleView.delegate = self;
    }
    return _dataTitleView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)refreshDataByChangeFlag:(NSInteger)flag
{
    _currentFlag = flag;
    [self loadDataQiciJishiViewController];
}
- (UITableView *)tableView
{
    if (!_tableView) {
         _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 60 + 44 + 39+ 14, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar -44 -  APPDELEGATE.customTabbar.height_myTabBar - 39- 14 - 60) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[RLSSaiTableViewCell class] forCellReuseIdentifier:cellSaiguoViewController];
        [self setupHeaderView];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView reloadData];
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
    if (self.arrData.count == 0 ) {
        return [UIImage imageNamed:@"d1"];
    }
    return [UIImage imageNamed:@"d1"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@""]) {
        NSString *text = @"暂无数据";
        NSDictionary *attributes;
        if (self.arrData.count == 0 ) {
            self.defaultFailure = default_noMatch;
        }else{
            attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
        }
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
    NSString *text = self.defaultFailure;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (RLSDCindexBtn *)indexBtn
{
    if (!_indexBtn) {
    }
    return _indexBtn;
}
- (void)scrollToScale:(CGFloat)scaleY
{
    [self.tableView setContentOffset:CGPointMake(0, (self.tableView.contentSize.height - self.tableView.height)*scaleY) animated:NO];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_arrData.count>0) {
        _indexBtn.hidden = NO;
    }
    CGFloat scaleY = scrollView.contentOffset.y/(scrollView.contentSize.height - self.tableView.height);
    [_indexBtn updateScrollFrame:scaleY];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView; 
{
}
- (void)hideIndexBtn
{
    _indexBtn.hidden = YES;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)setupHeaderView {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.font = font13;
    self.tableView.mj_header = header;
}
- (void)headerRefreshData
{
    if (_arrDataQici.count>0) {
        RLSQiciModel *qici = [_arrDataQici objectAtIndex:_currentdate];
        [self loadDataJishiViewControllerWithQici:qici];
    }else{
        [self loadDataQiciJishiViewController];
    }
    [self.tableView.mj_header endRefreshing];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RLSSaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellSaiguoViewController];
    if (!cell) {
        cell = [[RLSSaiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSaiguoViewController];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.ScoreModel = [_arrData objectAtIndex:indexPath.row];
    cell.contentView.backgroundColor = colorfbfafa;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = colorF5;
    cell.backgroundColor = [UIColor whiteColor];
    UIView *marginView = [UIView new];
    marginView.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:marginView];
    [marginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(cell.contentView);
        make.height.mas_equalTo(5);
    }];
    return cell;
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_arrData.count > 0) {
        RLSLiveScoreModel *model = [_arrData objectAtIndex:indexPath.row];
        if (model.remark!= nil && ![model.remark isEqualToString:@""]) {
            return 108;
        }
        return 80;
    }
    return 0;
}

- (void)loadDataQiciJishiViewController{
    [self loadDataJishiViewControllerWithQici:nil];
}

- (void)loadDataJishiViewControllerWithQici:(RLSQiciModel *)model {
//    NSString *urlStage = @"http://120.55.30.173:8809/bifen/matchs";
      NSString *urlStage = [NSString stringWithFormat:@"%@/bifen2/matchs",APPDELEGATE.url_Server];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    if (self.filterDic[ParamtersFilters]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        NSArray *parameters = self.filterDic[ParamtersFilters];
        [dic setValue:self.filterDic[ParamtersType] forKey:@"key"];
        [dic setValue:parameters forKey:@"val"];
        NSString *json = [self getJSONMessage:dic];
        [parameter setValue:json forKey:@"filter"];
        self.filterParameters = json;
    }
    [parameter setValue:@"old" forKey:@"timeline"];
    [parameter setValue:PARAM_IS_NIL_ERROR(_date) forKey:@"date"];
    
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:urlStage Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _arrData = [[NSMutableArray alloc] initWithArray:[RLSLiveScoreModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"matchs"]]];
            _arrDataQici = [[NSMutableArray alloc] initWithArray:[RLSQiciModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"dates"]]];
            if (_arrDataQici.count == 0) {
                [_arrData removeAllObjects];
                [self.tableView reloadData];
                return ;
            }
            _dataTitleView.arrData = _arrDataQici;
            [self.tableView reloadData];
            
            [_arrDataQici enumerateObjectsUsingBlock:^(RLSQiciModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.selected) {
                    _date = obj.val;
                    *stop = true;
                }
            }];
        }
       
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure = errorDict;
        [self.tableView reloadData];
        [_arrData removeAllObjects];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
