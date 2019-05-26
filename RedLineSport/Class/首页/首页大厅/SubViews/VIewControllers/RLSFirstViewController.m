#import "RLSFirstViewController.h"
#import "RLSFocusModel.h"
#import "RLSNewslistModel.h"
#import "RLSFirstPInfoListModel.h"
#import "RLSUserlistModel.h"
#import "RLSRollInfoModel.h"
#import "RLSTuijiandatingModel.h"
#import "RLSWebDetailViewController.h"
#import "RLSLoadHtmlStringVC.h"
#import "RLSTuijianDatingCell.h"
#import "RLSNewRecommandVC.h"
#import "RLSfirstHotInfoCycleView.h"
#import "RLSFirstPUserlistView.h"
#import "RLSTuijianDetailVC.h"
#define cellFirstPageTuijian @"cellFirstPageTuijian"
#import "RLSJiXianVC.h"
#import "RLSBettingVC.h"
#import "RLSPanwangZhishuVC.h"
#import "RLSJiaoYiViewController.h"
#import "RLSBaolengZhishuVC.h"
#import "RLSTongpeiTongjiVC.h"
#import "RLSPeilvYichangVC.h"
#import "RLSYapanZhoushouVC.h"
#import "RLSVierticalScrollView.h"
#import "RLSFenxiPageVC.h"
#import "RLSTuijianDTViewController.h"
#import "RLSLaunchView.h"
#import "RLSGuideView.h"
#import "RLSTodayHotSpotsCell.h"
#import "RLSRedDanCycleView.h"
#import "RLSTuijianDatingCell.h"
#import "RLSTuijiandatingModel.h"
#import "RLSRedDanModel.h"
#import "RLSMostModel.h"
#import "RLSLivingModel.h"
#import "RLSDataModelView.h"
#import "RLSTodayHotSpotsTwoCell.h"
#import "RLSModelPredictionViewController.h"
#import "RLSToolKitViewController.h"
#import "RLSLiveViewController.h"
#import "RLSToolWebViewController.h"
@interface RLSFirstViewController ()<UITableViewDelegate,UITableViewDataSource,firstHotInfoCycleViewDelegate,FirstPUserlistViewDelegate,VierticalScrollViewDelegate,SDCycleScrollViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,DataModelViewDelegate>
@property (nonatomic, strong) RLSBasicTableView *tableView;
@property (nonatomic, strong) SDCycleScrollView *cycleView;
@property (nonatomic, strong) RLSDataModelView *viewInfo;
@property (nonatomic, strong) NSArray *arrRollInfo;
@property (nonatomic, strong) NSMutableArray *arrFocus;
@property (nonatomic, strong) NSArray *arrRecommand;
@property (nonatomic, strong) NSArray *arrRedDan;
@property (nonatomic, strong) NSArray *arrInfolist;
@property (nonatomic, strong) NSArray *arrUserListBigName;
@property (nonatomic, strong) NSArray *arrUserListRedList;
@property (nonatomic, strong) NSArray *arrUserListWeekList;
@property (nonatomic, strong) NSArray *arrToHotzMost;
@property (nonatomic, strong) NSArray *arrNewslist;
@property (nonatomic, strong) RLSNewslistModel *column;
@property (nonatomic, strong)NSArray *hotRecommed;
@property (nonatomic, assign) BOOL isToFenxi;
@property (nonatomic, strong) UIView *viewBar;
@property (nonatomic, strong)UITableViewCell *seleCell;
@property (nonatomic, strong)NSMutableArray *arrBtnUser;
@property (nonatomic, assign)NSInteger btnUerBtnIndex;
@property (nonatomic, strong)RLSfirstHotInfoCycleView *firstPg;
@property (nonatomic, assign) BOOL nodata;
@property (nonatomic, assign) BOOL timerOn;
@property (nonatomic, strong) dispatch_source_t  timer;
@property (nonatomic , strong) UIImageView *liveQuizImageView;
@property (nonatomic , copy) NSDictionary *activityDic;
@end
@implementation RLSFirstViewController
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"RLSFirstViewController"];
    self.navigationController.navigationBarHidden = YES;
    [self changeTimer];
    [self loadData];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadLiveData];
    });
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.timer) {
         dispatch_source_cancel(self.timer);
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
- (void)changeTimer {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 5.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        [self timerChange];
    });
    dispatch_resume(timer);
    self.timer = timer;
}
- (void)timerChange
{
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:[RLSHttpString getCommenParemeter] PathUrlL:[NSString stringWithFormat:@"%@%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_change] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        NSArray *arrLiving = [RLSLivingModel arrayOfEntitiesFromArray:responseOrignal];
        [self.firstPg setUpData:arrLiving];
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    adjustsScrollViewInsets_NO(self.tableView, self);
    self.defaultFailure = @"暂无数据";
    _btnUerBtnIndex = 1;
    _arrBtnUser = [[NSMutableArray alloc] initWithCapacity:0];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"showGuideVC"]) {
        RLSGuideView *guideV = [[RLSGuideView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
        guideV.backgroundColor = [UIColor whiteColor];
        [[APPDELEGATE window] addSubview:guideV];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"showGuideVC"];
    }
    NSData *dataFirstPageDataLocal = [[NSUserDefaults standardUserDefaults] dataForKey:@"firstPageDataLocal"];
    if (dataFirstPageDataLocal) {
        NSDictionary *dictFirstPageDataLocal = [NSKeyedUnarchiver unarchiveObjectWithData:dataFirstPageDataLocal];
        if ([dictFirstPageDataLocal isKindOfClass:[NSDictionary class]]) {
            _arrFocus = [[NSMutableArray alloc] initWithArray:[RLSFocusModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"focusNews"]]];
            if (![[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"hotMatches"] isKindOfClass:[NSNull class]]) {
                _arrInfolist = [[NSArray alloc] initWithArray:[RLSFirstPInfoListModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"hotMatches"]]];
            }
            _arrToHotzMost = [[NSArray alloc] initWithArray:[RLSMostModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"most"]]];
            _arrUserListBigName = [[NSArray alloc] initWithArray:[RLSUserlistModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"userlist"][@"bigNameList"]]];
            _arrUserListRedList = [[NSArray alloc] initWithArray:[RLSUserlistModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"userlist"][@"redList"]]];
            _arrUserListWeekList = [[NSArray alloc] initWithArray:[RLSUserlistModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"userlist"][@"weekList"]]];
            _arrRedDan = [[NSArray alloc] initWithArray:[RLSRedDanModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"redNews"]]];
            _arrRollInfo = [[NSArray alloc] initWithArray:[RLSRollInfoModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"rollInfo"]]];
            _arrNewslist = [NSArray arrayWithArray:[RLSNewslistModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"newslist"]]];
            _hotRecommed = [NSArray arrayWithArray:[RLSTuijiandatingModel arrayOfEntitiesFromArray:[[dictFirstPageDataLocal objectForKey:@"data"] objectForKey:@"essenceRecommend"]]];
        }
    }
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"oddstypeDetail"];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"ver"];
    [self.view addSubview:self.tableView];
    NSData *launchOptionPushInfoData =[[NSUserDefaults standardUserDefaults] objectForKey:@"launchOptionPushInfo"];
    if (launchOptionPushInfoData) {
        NSDictionary *launchOptionPushInfo = [NSDictionary dictionaryWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:launchOptionPushInfoData]];
        if (launchOptionPushInfo.allValues.count>0) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"launchOptionPushInfo"];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationpushToNewsWeb object:nil userInfo:launchOptionPushInfo];
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTableViewContentOffsetZero) name:NotificationsetFirstTableViewContentOffsetZero object:nil];
    _viewBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 20)];
    _viewBar.backgroundColor = [UIColor blackColor];
    _viewBar.hidden = YES;
    [self.view addSubview:_viewBar];
    [self.tableView.mj_header beginRefreshing];
    [self.view addSubview:self.liveQuizImageView];
}
- (void)setTableViewContentOffsetZero
{
    if (_tableView.contentOffset.y != 0) {
        [self.tableView setContentOffset:CGPointZero animated:YES];
    }
}
#pragma mark -- UITableViewDataSource
- (UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = [[RLSBasicTableView alloc] initWithFrame:CGRectMake(0, 0, Width, Height - 49)];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[RLSTuijianDatingCell class] forCellReuseIdentifier:cellFirstPageTuijian];
        [self.tableView registerNib:[UINib nibWithNibName:@"FirstFHuaTiCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellfirstHuati"];
        self.tableView.defaultPage = defaultPageFirst;
        self.tableView.defaultTitle = default_isLoading;
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.delegate =self;
        self.tableView.dataSource = self;
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
        [self setTableHeader];
    }
    return _tableView;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    [self.tableView.mj_header beginRefreshing];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (_nodata) {
        return [UIImage imageNamed:@"nodataFirstP"];
    }
    return [UIImage imageNamed:@"clear"];
}
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    NSLog(@"imageAnimationForEmptyDataSet");
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    return animation;
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (Width*375/750 - 20 < scrollView.contentOffset.y) {
        _viewBar.hidden = NO;
    }else{
        _viewBar.hidden = YES;
    }
}
- (void)setTableHeader
{
    MJRefreshNormalHeader *mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    mjHeader.stateLabel.font = font13;
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    mjHeader.stateLabel.textColor = grayColor4;
    self.tableView.mj_header = mjHeader;
}
- (void)headerRefresh
{
    NSMutableArray *activityArray = [ArchiveFile getDataWithPath:Activity_Path];
    if (activityArray.count == 0) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
            [[RLSDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveQuiz] Start:^(id requestOrignal) {
            } End:^(id responseOrignal) {
            } Success:^(id responseResult, id responseOrignal) {
                NSString *code = responseOrignal[@"code"];
                if ([code isEqualToString:@"200"]) {
                    NSMutableArray *dataArray = responseOrignal[@"data"];
                    if (dataArray.count == 0) {
                        [ArchiveFile clearCachesWithFilePath:Activity_Path];
                    } else {
                        [ArchiveFile saveDataWithPath:Activity_Path data:dataArray];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadTableBarActivity" object:nil];
                    }
                }
            } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            }];
        });
    }
    [self loadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_nodata) {
        return 0;
    }
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_nodata) {
        return 0;
    }
    switch (section) {
        case 0:
        {
            return 0;
        }
            break;
        case 1:
        {
            if (_arrToHotzMost.count == 0) {
                return 0;
            }
            return 0;
        }
            break;
        case 2:
        {
            if (_arrInfolist.count == 0) {
                return 0;
            }
            return 1;
        }
            break;
        case 3:
        {
            if (_arrUserListBigName.count == 0 && _arrUserListRedList.count == 0 && _arrUserListWeekList.count == 0) {
                return 0;
            }
            return 1;
        }
            break;
        case 4:
        {
            if (_arrRedDan.count == 0) {
                return 0;
            }
            return 1;
        }
            break;
        case 5:
        {
            if (_hotRecommed.count == 0) {
                return 0;
            }
            return _hotRecommed.count;
        }
            break;
        case 6:
        {
            if (_arrNewslist.count == 0) {
                return 0;
            }
            return _arrNewslist.count;
        }
            break;
        case 7:
        {
            return 0;
        }
            break;
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_nodata) {
        return 0;
    }
    switch (indexPath.section) {
        case 0:
        {
            return 0;
        }
            break;
        case 1:
        {
            if (_arrToHotzMost.count == 0) {
                return 0;
            }
            if (indexPath.row == 3) {
                return 110;
            } else {
                return 95;
            }
        }
            break;
        case 2:
        {
            if (_arrInfolist.count == 0) {
                return 0;
            }
            return 190;
        }
            break;
        case 3:
        {
            if (_arrUserListBigName.count == 0 && _arrUserListRedList.count == 0 &&  _arrUserListWeekList.count == 0) {
                return 0;
            }
            switch (_btnUerBtnIndex) {
                case 1:{
                    if (_arrUserListBigName.count > 4) {
                        return 220;
                    }else{
                        if (_arrUserListBigName.count == 0) {
                            return 0;
                        }else{
                            return 120;
                        }
                    }
                }
                case 2:{
                    if (_arrUserListRedList.count > 4) {
                        return 220;
                    }else{
                        if (_arrUserListRedList.count == 0) {
                            return 0;
                        }else{
                            return 120;
                        }
                    }
                }
                case 3:{
                    if (_arrUserListWeekList.count > 4) {
                        return 220;
                    }else{
                        if (_arrUserListWeekList.count == 0) {
                            return 0;
                        }else{
                            return 120;
                        }
                    }
                }
                    break;
                default:
                    break;
            }
            return 220;
        }
            break;
        case 4:
        {
            if (_arrRedDan.count == 0) {
                return 0;
            }
            return 180;
        }
        case 5:
        {
            if (_hotRecommed.count == 0) {
                return 0;
            }
            return 190;
        }
            break;
        case 6:
        {
            if (_arrNewslist.count == 0) {
                return 0;
            }
            return 37;
        }
            break;
        case 7:
        {
            return 0;
        }
            break;
        default:
            break;
    }
    return 0;
}
- (RLSfirstHotInfoCycleView *)firstPg{
    if (!_firstPg) {
        _firstPg = [[RLSfirstHotInfoCycleView alloc] initWithFrame:CGRectMake(0, 0, Width,200)];
    }
    return _firstPg;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_nodata) {
        return [UITableViewCell new];
    }
    switch (indexPath.section) {
        case 0:
        {
            static NSString *cell = @"first0";
            UITableViewCell *cellNull = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
            return cellNull;
        }
            break;
        case 1:
        {
            if (_arrToHotzMost.count == 0) {
                return [UITableViewCell new];
            }
            if (indexPath.row == 0) {
                static NSString *cell = @"first1";
                RLSTodayHotSpotsCell *cellNull = [tableView dequeueReusableCellWithIdentifier:cell];
                if (!cellNull) {
                    cellNull = [[RLSTodayHotSpotsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
                }
                cellNull.selectedBackgroundView = [[UIView alloc] initWithFrame:cellNull.frame];
                cellNull.selectedBackgroundView.backgroundColor = colorF5;
                cellNull.row = indexPath.row;
                cellNull.model = _arrToHotzMost[indexPath.row];
                return cellNull;
            }else{
                static NSString *cell = @"firstTwo";
                RLSTodayHotSpotsTwoCell *cellNull = [tableView dequeueReusableCellWithIdentifier:cell];
                if (!cellNull) {
                    cellNull = [[RLSTodayHotSpotsTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
                }
                cellNull.selectedBackgroundView = [[UIView alloc] initWithFrame:cellNull.frame];
                cellNull.selectedBackgroundView.backgroundColor = colorF5;
                cellNull.row = indexPath.row;
                cellNull.model = _arrToHotzMost[indexPath.row];
                return cellNull;
            }
        }
            break;
        case 2:{
            static NSString *cell = @"first2";
            UITableViewCell *cellNull = [tableView dequeueReusableCellWithIdentifier:cell];
            if (!cellNull) {
                cellNull = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
            }
            cellNull.selectionStyle = UITableViewCellSelectionStyleNone;
            self.firstPg.arrData = _arrInfolist;
            self.firstPg.delegate = self;
            [cellNull.contentView addSubview:self.firstPg];
            return cellNull;
        }
            break;
        case 3://推荐名人
        {
            static NSString *cell = @"first3";
            UITableViewCell *cellNull = [tableView dequeueReusableCellWithIdentifier:cell];
            if (!cellNull) {
                cellNull = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
            }
            [cellNull.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj removeFromSuperview];
            }];
            cellNull.selectionStyle = UITableViewCellSelectionStyleNone;
            RLSFirstPUserlistView *subVOne = [[RLSFirstPUserlistView alloc] initWithFrame:CGRectMake(0, 0, Width, 220)];
            switch (_btnUerBtnIndex) {
                case 1:{
                    subVOne.arrData = _arrUserListBigName;
                    if (_arrUserListBigName.count > 4) {
                        subVOne.frame = CGRectMake(0, 0, Width, 220);
                    }else{
                        subVOne.frame = CGRectMake(0, 0, Width, 120);
                    }
                }
                    break;
                case 2:{
                    subVOne.arrData = _arrUserListRedList;
                    if (_arrUserListRedList.count > 4) {
                        subVOne.frame = CGRectMake(0, 0, Width, 220);
                    }else{
                        subVOne.frame = CGRectMake(0, 0, Width, 120);
                    }
                }
                    break;
                case 3:{
                    subVOne.arrData = _arrUserListWeekList;
                    if (_arrUserListWeekList.count > 4) {
                        subVOne.frame = CGRectMake(0, 0, Width, 220);
                    }else{
                        subVOne.frame = CGRectMake(0, 0, Width, 120);
                    }
                }
                    break;
                default:
                    break;
            }
            subVOne.delegate = self;
            [cellNull.contentView addSubview:subVOne];
            return cellNull;
        }
            break;
        case 4://红单播报
        {
            if (_arrRedDan.count == 0) {
                return [UITableViewCell new];
            }
            static NSString *cell = @"first4";
            UITableViewCell *cellNull = [tableView dequeueReusableCellWithIdentifier:cell];
            if (!cellNull) {
                cellNull = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
            }
            [cellNull.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj removeFromSuperview];
            }];
            RLSRedDanCycleView *redView = [[RLSRedDanCycleView alloc] initWithFrame:CGRectMake(0, 0, Width, 180)];
            redView.arrData = _arrRedDan;
            [cellNull.contentView addSubview:redView];
            return cellNull;
        }
        case 5:
        {
            static NSString *cell = @"first5";
            RLSTuijianDatingCell *cellNull = [tableView dequeueReusableCellWithIdentifier:cell];
            if (!cellNull) {
                cellNull = [[RLSTuijianDatingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
            }
            cellNull.selectedBackgroundView = [[UIView alloc] initWithFrame:cellNull.frame];
            cellNull.selectedBackgroundView.backgroundColor = colorF5;
            cellNull.type =  typeTuijianCellFirstPage;
            cellNull.model = _hotRecommed[indexPath.row];
            return cellNull;
        }
            break;
        case 6:
        {
            return 0;
        }
            break;
        case 7:
        {
            return 0;
        }
            break;
        default:
            break;
    }
    return nil;
}
- (void)dicSelectedToFenxiWithModel:(RLSFirstPInfoListModel *)model
{
    [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",(long)model.mid] toPageindex:2 toItemIndex:0];
}
- (void)selectedUserWithId:(RLSUserlistModel *)user
{
    if (user.userid == 1) {
        return;
    }
    RLSUserViewController *userVC = [[RLSUserViewController alloc] init];
    userVC.userId = user.userid;
    userVC.userName = user.nickname;
    userVC.userPic = user.pic;
    userVC.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:userVC animated:YES];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_nodata) {
        return nil;
    }
    switch (section) {
        case 0:
        {
            UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width,Width*375/750 + 0)];
            viewHeader.backgroundColor = colorTableViewBackgroundColor;
            _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Width, Width*375/750) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
            _cycleView.currentPageDotColor = redcolor;
            _cycleView.pageDotColor = [UIColor whiteColor];
            _cycleView.autoScrollTimeInterval = 5;
            _cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
            _cycleView.titleLabelHeight = 28;
            _cycleView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
            NSMutableArray *arrpics = [NSMutableArray array];
            NSMutableArray *arrtitles = [NSMutableArray array];
            for (int i = 0; i<_arrFocus.count; i++) {
                RLSFocusModel *model = [_arrFocus objectAtIndex:i];
                if (model.pic == nil) {
                    model.pic = @"";
                }
                if (model.title == nil) {
                    model.title = @"";
                }
                if (model.url2 == nil) {
                    model.url2 = @"";
                }
                [arrtitles addObject:model.title];
                [arrpics addObject:model.pic];
            }
            _cycleView.titlesGroup = arrtitles;
            _cycleView.imageURLStringsGroup = arrpics;
            [viewHeader addSubview:_cycleView];
            UIView *viewHeaderTwo = [[UIView alloc] initWithFrame:CGRectMake(0, _cycleView.bottom, Width,39+5)];
            viewHeaderTwo.backgroundColor = [UIColor whiteColor];
            UIImageView *img= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gunqiuQB"]];
            img.center = CGPointMake(img.center.x + 10, 22);
            [viewHeaderTwo addSubview:img];
            UIView *viewShu = [[UIView alloc] initWithFrame:CGRectMake(img.right - 5, 0, 1, 25)];
            viewShu.center = CGPointMake(viewShu.center.x + 15, 22);
            viewShu.backgroundColor = colorTableViewBackgroundColor;
            [viewHeaderTwo addSubview:viewShu];
            if (_arrRollInfo.count >0) {
                NSMutableArray *arrTitle = [NSMutableArray array];
                for (int i = 0; i<_arrRollInfo.count; i++) {
                    RLSRollInfoModel *roll =  [_arrRollInfo objectAtIndex:i];
                    if (roll.on_index_title == nil || [roll.on_index_title isEqualToString:@""]) {
                        roll.on_index_title = @"";
                    }
                    [arrTitle addObject:roll.on_index_title];
                }
                RLSVierticalScrollView *scroView = [RLSVierticalScrollView initWithTitleArray:arrTitle AndFrame:CGRectMake(viewShu.right + 10, 0, Width - viewShu.right - 15, 44)];
                scroView.delegate =self;
                [viewHeaderTwo addSubview:scroView];
            }
            return viewHeader;
        }
            break;
        case 1:
        {
            UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width,100)];
            viewHeader.backgroundColor = [UIColor whiteColor];
            [viewHeader addSubview:self.viewInfo];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 99.5 , Width, 0.5)];
            line.backgroundColor = colorDD;
            [viewHeader addSubview:line];
            return viewHeader;
        }
            break;
        case 2:{
            return [UIView new];
        }
            break;
        case 3:
        {
            if (_arrUserListBigName.count == 0 && _arrUserListWeekList.count == 0 && _arrUserListRedList.count == 0) {
                return [UIView new];
            }
            UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width,39+5)];
            viewHeader.backgroundColor = [UIColor whiteColor];
            UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 44)];
            labTitle.text = @"推荐名人";
            labTitle.textColor = color33;
            labTitle.font = BoldFont6(fontSize14);
            labTitle.backgroundColor = [UIColor whiteColor];
            labTitle.textAlignment = NSTextAlignmentLeft;
            [viewHeader addSubview:labTitle];
            UIButton *btnWin = [UIButton buttonWithType:UIButtonTypeCustom];
            btnWin.titleLabel.font = font14;
            [btnWin setTitle:@"" forState:UIControlStateNormal];
            [btnWin setTitleColor:color66 forState:UIControlStateNormal];
            [btnWin setTitleColor:color33 forState:UIControlStateSelected];
            btnWin.tag = 3;
            [btnWin addTarget:self action:@selector(btnUserBtn:) forControlEvents:UIControlEventTouchUpInside];
            [viewHeader addSubview:btnWin];
            [_arrBtnUser addObject:btnWin];
            [btnWin mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(viewHeader.mas_top);
                make.bottom.mas_equalTo(viewHeader.mas_bottom);
                make.right.mas_equalTo(viewHeader.mas_right).offset(-0);
                make.width.mas_equalTo(0);
            }];
            UIView *lineOne = [[UIView alloc] init];
            [viewHeader addSubview:lineOne];
            [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(btnWin.mas_left).offset(-0);
                make.centerY.mas_equalTo(viewHeader.mas_centerY);
                make.height.mas_offset(20);
                make.width.mas_offset(0.5);
            }];
            UIButton *btnRed = [UIButton buttonWithType:UIButtonTypeCustom];
            btnRed.titleLabel.font = font14;
            [btnRed setTitle:@" 连红 " forState:UIControlStateNormal];
            [btnRed setTitleColor:color66 forState:UIControlStateNormal];
            [btnRed setTitleColor:color33 forState:UIControlStateSelected];
            btnRed.tag = 2;
            [btnRed addTarget:self action:@selector(btnUserBtn:) forControlEvents:UIControlEventTouchUpInside];
            [viewHeader addSubview:btnRed];
            [_arrBtnUser addObject:btnRed];
            [btnRed mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(viewHeader.mas_top);
                make.bottom.mas_equalTo(viewHeader.mas_bottom);
                make.right.mas_equalTo(lineOne.mas_left).offset(-10);
            }];
            UIView *lineTwo = [[UIView alloc] init];
            lineTwo.backgroundColor = colorDD;
            [viewHeader addSubview:lineTwo];
            [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(btnRed.mas_left).offset(-10);
                make.centerY.mas_equalTo(viewHeader.mas_centerY);
                make.height.mas_offset(20);
                make.width.mas_offset(0.5);
            }];
            UIButton *btnBig = [UIButton buttonWithType:UIButtonTypeCustom];
            btnBig.titleLabel.font = font14;
            [btnBig setTitle:@" 大咖 " forState:UIControlStateNormal];
            [btnBig setTitleColor:color66 forState:UIControlStateNormal];
            [btnBig setTitleColor:color33 forState:UIControlStateSelected];
            btnBig.tag = 1;
            [btnBig addTarget:self action:@selector(btnUserBtn:) forControlEvents:UIControlEventTouchUpInside];
            [viewHeader addSubview:btnBig];
            [_arrBtnUser addObject:btnBig];
            [btnBig mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(viewHeader.mas_top);
                make.bottom.mas_equalTo(viewHeader.mas_bottom);
                make.right.mas_equalTo(lineTwo.mas_left).offset(-10);
            }];
            btnBig.userInteractionEnabled = YES;
            btnRed.userInteractionEnabled = YES;
            btnWin.userInteractionEnabled = YES;
            switch (_btnUerBtnIndex) {
                case 1:{
                    btnBig.titleLabel.font = BoldFont4(fontSize14);
                    btnBig.selected = YES;
                }
                    break;
                case 2:{
                    btnRed.titleLabel.font = BoldFont4(fontSize14);
                    btnRed.selected = YES;
                }
                    break;
                case 3:{
                    btnWin.titleLabel.font = BoldFont4(fontSize14);
                    btnWin.selected = YES;
                }
                    break;
                default:
                    break;
            }
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, labTitle.bottom, Width, 0.5)];
            line.backgroundColor = colorDD;
            [viewHeader addSubview:line];
            return viewHeader;
        }
            break;
        case 4:
        {
            return [UIView new];
        }
        case 5:
        {
            if (_hotRecommed.count == 0) {
                return [UIView new];
            }
            UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width,39+5)];
            UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
            labTitle.text = @"    热门推荐";
            labTitle.textColor = color33;
            labTitle.font = BoldFont6(fontSize14);
            labTitle.backgroundColor = [UIColor whiteColor];
            labTitle.textAlignment = NSTextAlignmentLeft;
            [viewHeader addSubview:labTitle];
            UIButton *btnMore = [UIButton buttonWithType:UIButtonTypeCustom];
            btnMore.frame = CGRectMake(Width - 15 - 50, 5, 45, 39);
            [btnMore setTitle:@"更多" forState:UIControlStateNormal];
            [btnMore setTitleColor:color99 forState:UIControlStateNormal];
            [btnMore.titleLabel setFont:font13];
            btnMore.tag = section;
            [btnMore addTarget:self action:@selector(toMore:) forControlEvents:UIControlEventTouchUpInside];
            [viewHeader addSubview:btnMore];
            UIImageView *imageMore = [[UIImageView alloc] initWithFrame:CGRectMake(45, 0, 7, 14)];
            imageMore.center = CGPointMake(imageMore.center.x, btnMore.height/2);
            imageMore.image = [UIImage imageNamed:@"meRight"];
            [btnMore addSubview:imageMore];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, labTitle.bottom, Width, 0.5)];
            line.backgroundColor = colorDD;
            [viewHeader addSubview:line];
            return viewHeader;
        }
            break;
        case 6:
        {
            return 0;
        }
            break;
        case 7:
        {
            return 0;
        }
            break;
        default:
            break;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (_nodata) {
        return nil;
    }
    if (section == 5 && _hotRecommed.count > 0) {
        UIView *bkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
        bkView.backgroundColor = colorF5;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"查看更多推荐" forState:UIControlStateNormal];
        [btn setTitleColor:color33 forState:UIControlStateNormal];
        btn.titleLabel.font = font14;
        btn.tag = 5;
        [bkView addSubview:btn];
        [btn addTarget:self action:@selector(toMore:) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bkView.mas_centerY).offset(-3);
            make.centerX.mas_equalTo(bkView.mas_centerX);
        }];
        UIImageView *img = [[UIImageView alloc] init];
        img.image = [UIImage imageNamed:@"moreBtn"];
        [bkView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(btn.mas_centerY);
            make.left.mas_equalTo(btn.mas_right).offset(0);
            make.width.mas_offset(16);
            make.height.mas_offset(16);
        }];
        return bkView;
    }
    return [UIView new];
}
- (void)btnUserBtn:(UIButton *)btn{
    for (int i = 0; i < _arrBtnUser.count; i ++) {
        UIButton *selebtn = _arrBtnUser[i];
        if (btn.tag == selebtn.tag ) {
            selebtn.selected = YES;
            _btnUerBtnIndex = selebtn.tag;
            selebtn.titleLabel.font = BoldFont4(fontSize14);
        }else{
            selebtn.titleLabel.font = font14;
            selebtn.selected = NO;
        }
    }
    [self.tableView reloadData];
}
- (void)toMore:(UIButton *)btn
{
    if (btn.tag ==4) {
    }else if (btn.tag == 2){
    }else if (btn.tag == 5){
        UINavigationController *nav2 = [APPDELEGATE.customTabbar.viewControllers objectAtIndex:3];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tuijianSetSize" object:nil];
        [nav2 popToRootViewControllerAnimated:YES];
        [APPDELEGATE.customTabbar setSelectedIndex:3];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_nodata) {
        return 0;
    }
    switch (section) {
        case 0:
            return Width*375/750 + 0;
            break;
        case 1:
            return 100;
            break;
        case 2:
            return 0.0001;
            break;
        case 3:
            if (_arrUserListWeekList.count == 0 && _arrUserListWeekList.count == 0 && _arrUserListBigName.count == 0) {
                return 0.0001;
            }
            return 44;
            break;
        case 4:
        {
            return 0.0001;
        }
        case 5:
        {
            if (_hotRecommed.count == 0) {
                return 0.0001;
            }
            return 39+5;
        }
            break;
        case 6:
        {
            return 39+5;
        }
            break;
        case 7:
        {
            return 0.00001;
        }
            break;
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_nodata) {
        return 0;
    }
    switch (section) {
        case 0:
            return 0.00001;
            break;
        case 1:
            return 10;
            break;
        case 2://情报
            if (_arrInfolist.count > 0) {
                return 10;
            }
            break;
        case 3:{
            if (_arrUserListWeekList.count > 0 || _arrUserListRedList.count > 0 || _arrUserListBigName.count > 0) {
                return 10;
            }
        }
            break;
        case 4:{
            if (_arrRedDan.count> 0) {
                return 10;
            }
        }
            break;
        case 5:
            if (_hotRecommed.count > 0) {
                return 44;
            }
            break;
        default:
            break;
    }
    return 0.001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 5) {
        RLSTuijianDetailVC *infoVC = [[RLSTuijianDetailVC alloc] init];
        infoVC.hidesBottomBarWhenPushed = YES;
        RLSTuijiandatingModel *model = _hotRecommed[indexPath.row];
        infoVC.modelId = model.idId;
        [APPDELEGATE.customTabbar pushToViewController:infoVC animated:YES];
    }else if(indexPath.section == 6)
    {
    }else if(indexPath.section == 1){
        switch (indexPath.row) {
            case 0:{
                RLSMostModel *modelMost = _arrToHotzMost[indexPath.row];
                [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",(long)modelMost.sid] toPageindex:0 toItemIndex:0];
            }
                break;
            case 1:{
                RLSMostModel *modelMost = _arrToHotzMost[indexPath.row];
                [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",(long)modelMost.sid] toPageindex:1 toItemIndex:4];
            }
            case 2:{
                RLSMostModel *modelMost = _arrToHotzMost[indexPath.row];
                [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",(long)modelMost.sid] toPageindex:1 toItemIndex:4];
            }
            case 3:{
                RLSMostModel *modelMost = _arrToHotzMost[indexPath.row];
                [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",(long)modelMost.sid] toPageindex:0 toItemIndex:0];
            }
            default:{
                RLSMostModel *modelMost = _arrToHotzMost[indexPath.row];
                [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",(long)modelMost.sid] toPageindex:0 toItemIndex:0];
            }
                break;
        }
    }
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    RLSFocusModel *fmodel = [_arrFocus objectAtIndex:index];
    switch (fmodel.linkType) {
        case 0:
        {
        }
            break;
        case 1:
        {
            RLSWebModel *webModel = [[RLSWebModel alloc]init];
            webModel.title = fmodel.title;
            webModel.webUrl = fmodel.url2;
            RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
            control.model = webModel;
            [self.navigationController pushViewController:control animated:YES];
        }
            break;
        case 2:
        {
            [self toFenxiWithMatchId:fmodel.url2 toPageindex:fmodel.tabType toItemIndex:0];
        }
            break;
        case 3:
        {
        }
            break;
        case 4:
        {
            RLSTuijianDetailVC *tuijianDT = [[RLSTuijianDetailVC alloc] init];
            tuijianDT.modelId =[fmodel.url2 integerValue];
            tuijianDT.typeTuijianDetailHeader = typeTuijianDetailHeaderCellDanchang;
            tuijianDT.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:tuijianDT animated:YES];
        }
            break;
        case 5:
        {
            RLSUserViewController *userVC = [[RLSUserViewController alloc] init];
            userVC.userId = [fmodel.url2 integerValue];
            userVC.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:userVC animated:YES];
        }
            break;
        case 6:
        {
            RLSLoadHtmlStringVC *htmlVC = [[RLSLoadHtmlStringVC alloc] init];
            htmlVC.urlTitle = fmodel.title;
            htmlVC.urlContent = fmodel.content;
            htmlVC.urlId = [NSString stringWithFormat:@"%ld",fmodel.idId];
            htmlVC.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:htmlVC animated:YES];
        }
            break;
        default:
            break;
    }
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
}
-(void)clickTitleButton:(UIButton *)button
{
    RLSRollInfoModel *roll = [_arrRollInfo objectAtIndex:button.tag -1];
    [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",(long)roll.match_id] toPageindex:2 toItemIndex:0];
}
- (RLSDataModelView *)viewInfo
{
    if (!_viewInfo) {
        _viewInfo = [[RLSDataModelView alloc] initWithFrame:CGRectMake(0, 0, Width, 100)];
        _viewInfo.backgroundColor= [UIColor whiteColor];
        _viewInfo.delegate = self;
    }
    return _viewInfo;
}
- (void)didSelectedDataModelViewIndex:(NSInteger)index;
{
    switch (index) {
        case 4:
        {
            RLSJiaoYiViewController * jiaoyi = [[RLSJiaoYiViewController alloc] init];
            jiaoyi.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:jiaoyi animated:YES];
        }
            break;
        case 5:
        {
            RLSBettingVC *odd = [[RLSBettingVC alloc] init];
            odd.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:odd animated:YES];
        }
            break;
        case 7:
        {
            RLSPanwangZhishuVC *record = [[RLSPanwangZhishuVC alloc] init];
            record.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:record animated:YES];
        }
            break;
        case 6:
        {
            RLSJiXianVC *jixian = [[RLSJiXianVC alloc] init];
            jixian.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:jixian animated:YES];
        }
            break;
        case 1:
        {
            RLSLiveViewController *control = [[RLSLiveViewController alloc]init];
            [self.navigationController pushViewController:control animated:YES];
        }
            break;
        case 0:
        {
            [self.tabBarController setSelectedIndex:1];
        }
            break;
        case 2:
        {
            [MobClick event:@"mxyc" label:@""];
            RLSWebModel *model = [[RLSWebModel alloc]init];
            model.title = @"模型预测";
            model.webUrl = [NSString stringWithFormat:@"%@/%@/mode.html", APPDELEGATE.url_ip,H5_Host];
            RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
            webDetailVC.model = model;
            [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
        }
            break;
        case 3:
        {
            RLSToolKitViewController *control = [[RLSToolKitViewController alloc]init];
            [self.navigationController pushViewController:control animated:YES];
        }
            break;
        default:
            break;
    }
}
- (void)loadData
{
    _nodata = NO;
    self.tableView.backgroundColor = colorTableViewBackgroundColor;
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter] ];
    [parameter setObject:@"0" forKey:@"ver"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_firstIndex] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
        [self.tableView.mj_header endRefreshing];
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:responseOrignal];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"firstPageDataLocal"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            _arrFocus = [[NSMutableArray alloc] initWithArray:[RLSFocusModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"focusNews"]]];
            if (![[[responseOrignal objectForKey:@"data"] objectForKey:@"hotMatches"] isKindOfClass:[NSNull class]]) {
                NSArray *arrinfo = [[NSArray alloc] initWithArray:[RLSFirstPInfoListModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"hotMatches"]]];
                for (int i = 0; i<arrinfo.count; i++) {
                    RLSFirstPInfoListModel *model = [arrinfo objectAtIndex:i];
                    for (int j = 0; j<_arrInfolist.count; j++) {
                        RLSFirstPInfoListModel *mModel = [_arrInfolist objectAtIndex:j];
                        if (mModel.mid == model.mid) {
                            if (model.homescore<mModel.homescore) {
                                model.homescore = mModel.homescore;
                            }
                            if (model.guestscore < mModel.guestscore) {
                                model.guestscore = mModel.guestscore;
                            }
                        }
                    }
                }
                _arrInfolist = [NSArray arrayWithArray:arrinfo];
            }
            if (_arrInfolist.count>0) {
            }
            _arrUserListBigName = [[NSArray alloc] initWithArray:[RLSUserlistModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"userlist"][@"bigNameList"]]];
            _arrUserListRedList = [[NSArray alloc] initWithArray:[RLSUserlistModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"userlist"][@"redList"]]];
            _arrUserListWeekList = [[NSArray alloc] initWithArray:[RLSUserlistModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"userlist"][@"weekList"]]];
            _arrRollInfo = [[NSArray alloc] initWithArray:[RLSRollInfoModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"rollInfo"]]];
            _arrRedDan = [[NSArray alloc] initWithArray:[RLSRedDanModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"redNews"]]];
            _arrNewslist = [NSArray arrayWithArray:[RLSNewslistModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"newslist"]]];
            _arrToHotzMost = [[NSArray alloc] initWithArray:[RLSMostModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"most"]]];
            _hotRecommed = [NSArray arrayWithArray:[RLSTuijiandatingModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"essenceRecommend"]]];
            NSString *str =[NSString stringWithFormat:@"%ld",[[[responseOrignal objectForKey:@"data"] objectForKey:@"ver"] longValue]];
            [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"ver"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            self.tableView.defaultPage = defaultPageFirst;
            self.tableView.defaultTitle = default_noMatch;
            [self.tableView reloadData];
        }else{
            self.tableView.defaultPage = defaultPageForth;
            self.tableView.defaultTitle = default_loadFailure;
            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"firstPageDataLocal"]) {
                _nodata = YES;
                self.tableView.backgroundColor = [UIColor whiteColor];
                [self.tableView reloadData];
            }
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.tableView.defaultPage = defaultPageForth;
        self.tableView.defaultTitle = default_loadFailure;
        self.defaultFailure =errorDict;
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"firstPageDataLocal"]) {
            _nodata = YES;
            self.tableView.backgroundColor = [UIColor whiteColor];
            [self.tableView reloadData];
        }
    }];
}
- (void)toFenxiWithMatchId:(NSString *)idID toPageindex:(NSInteger)pageIndex toItemIndex:(NSInteger)itemIndex;
{
    if (!_isToFenxi == YES) {
        _isToFenxi = YES;
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
        if (idID== nil) {
            idID = @"";
        }
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
                fenxiVC.segIndex = itemIndex;
                fenxiVC.currentIndex = pageIndex;
                fenxiVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:fenxiVC animated:YES];
            }
            _isToFenxi = NO;
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            _isToFenxi = NO;
        }];
    }else{
    }
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
- (UIView *)getParentViewOfTitleAndMessageFromView:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            return view;
        }else{
            UIView *resultV = [self getParentViewOfTitleAndMessageFromView:subView];
            if (resultV) return resultV;
        }
    }
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark --------- 直播答题
#pragma mark - Private Method
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    [recognizer.view.superview bringSubviewToFront:recognizer.view];
    CGPoint center = recognizer.view.center;
    CGFloat cornerRadius = recognizer.view.frame.size.width / 2;
    CGPoint translation = [recognizer translationInView:self.view];
    CGFloat centerY = center.y + translation.y;
    CGFloat centerX = center.x + translation.x;
    if (centerY > self.view.height - self.navigationController.tabBarController.tabBar.height -  recognizer.view.frame.size.width / 2) {
        centerY = self.view.height - self.navigationController.tabBarController.tabBar.height -  recognizer.view.frame.size.width / 2;
    }
    if (centerY < cornerRadius) {
        centerY = cornerRadius;
    }
    if (centerX < cornerRadius) {
        centerX = cornerRadius;
    }
    if (centerX > Width  - cornerRadius) {
        centerX = Width  - cornerRadius;
    }
    recognizer.view.center = CGPointMake(centerX, centerY);
    [recognizer setTranslation:CGPointZero inView:self.view];
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (centerX > recognizer.view.superview.width / 2) {
            centerX = recognizer.view.superview.width - cornerRadius - 5;
        } else {
            centerX = cornerRadius + 5;
        }
        CGPoint centerPoint = CGPointMake(centerX, centerY);
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            recognizer.view.center = centerPoint;
        } completion:^(BOOL finished) {
        }];
    }
}
- (void)loadLiveData {
    NSMutableArray *activityArray = [ArchiveFile getDataWithPath:Activity_Path];
    for (NSDictionary *dic in activityArray) {
        if (dic[@"home"]) {
            NSDictionary *itemDic = dic[@"home"];
            self.activityDic = itemDic;
            [self.liveQuizImageView sd_setImageWithURL:[NSURL URLWithString:itemDic[@"icon"]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.liveQuizImageView.hidden = false;
            });
            break;
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                 self.liveQuizImageView.hidden = YES;
            });
        }
    }
}
#pragma mark - Events
- (void)liveQuziAction:(UITapGestureRecognizer *)tap {
    Class targetCalss = NSClassFromString(self.activityDic[@"n"]);
    if ([targetCalss isKindOfClass:NSClassFromString(@"RLSLiveQuizViewController")]) {
        RLSWebModel *model = [[RLSWebModel alloc]init];
        NSDictionary *pDic = self.activityDic[@"v"];
        model.title = PARAM_IS_NIL_ERROR(pDic[@"title"]);
        model.webUrl = PARAM_IS_NIL_ERROR(pDic[@"url"]);
        model.hideNavigationBar = pDic[@"nav_hidden"];
        model.parameter = pDic[@"nav"];
        RLSLiveQuizViewController *controller = [[RLSLiveQuizViewController alloc]init];
        controller.model = model;
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        RLSToolWebViewController *target =[[targetCalss alloc] init];
        RLSWebModel *model = [[RLSWebModel alloc]init];
        NSDictionary *pDic = self.activityDic[@"v"];
        model.title = PARAM_IS_NIL_ERROR(pDic[@"title"]);
        model.webUrl = PARAM_IS_NIL_ERROR(pDic[@"url"]);
        model.hideNavigationBar = pDic[@"nav_hidden"];
        model.parameter = pDic[@"nav"];
        target.model = model;
        [self.navigationController pushViewController:target animated:YES];
    }
}
#pragma mark - Lazy Load
- (UIImageView *)liveQuizImageView {
    if (_liveQuizImageView == nil) {
        _liveQuizImageView = [UIImageView new];
        _liveQuizImageView.frame = CGRectMake(Width - 80, 2 * (Height / 3), 70, 70);
        _liveQuizImageView.contentMode = UIViewContentModeScaleAspectFill;
        _liveQuizImageView.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(liveQuziAction:)];
        [_liveQuizImageView addGestureRecognizer:tap];
        _liveQuizImageView.userInteractionEnabled = YES;
        _liveQuizImageView.hidden = YES;
        UIPanGestureRecognizer *panTouch = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [_liveQuizImageView addGestureRecognizer:panTouch];
    }
    return _liveQuizImageView;
}
@end
