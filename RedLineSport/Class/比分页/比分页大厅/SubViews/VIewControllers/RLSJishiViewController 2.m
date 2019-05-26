#define  cellJishiViewController @"cellJishiViewController"
#import "RLSJishiViewController.h"
#import "RLSSaiguoViewController.h"
#import "RLSSaichengViewController.h"
#import "RLSGuanzhuViewController.h"
#import "RLSHSJFoldHeaderView.h"
#import "RLSWebView.h"
#import "RLSSaiTableViewCell.h"
#import "RLSLiveScoreModel.h"
#import "RLSQiciModel.h"
#import "RLSDCJishiBIifenView.h"
#import "RLSDCPlaySound.h"
#import "RLSBIfenSelectedSaishiModel.h"
#import "RLSDCindexBtn.h"
#import "RLSJSbifenModel.h"
#import "RLSSaishiSelecterdVC.h"
static SystemSoundID shake_sound_id = 0;
@interface RLSJishiViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,DCindexBtnDelegate,FoldSectionHeaderViewDelegate, GQWebViewDelegate>
@property (nonatomic, strong) NSArray *arrDataQici;
@property (nonatomic, assign) NSInteger currentFlag;
@property (nonatomic, assign) NSInteger cellNum;
@property (nonatomic, strong) dispatch_source_t  timer;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) RLSDCJishiBIifenView *jsbfView;
@property (nonatomic, strong) RLSDCindexBtn *indexBtn;
@property (nonatomic, strong) UITableViewCell *seleCell;
@property (nonatomic, assign) BOOL timerOn;
@property (nonatomic, strong) NSMutableArray              *titleArr;
@property (nonatomic, strong) NSMutableDictionary         *foldInfo;
@property (nonatomic , strong) UIImageView *activityImageView;
@property (nonatomic , strong) RLSWebView *activityWeb;
@property (nonatomic , copy) NSDictionary *activityDic;
@property (nonatomic , strong) UIButton *cloesBtn;



@property (nonatomic, copy) NSDictionary *filterDic; // 记录筛选值 由广播发送过来


@end
@implementation RLSJishiViewController

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
    if ([dic[ParamtersTimeline] isEqualToString:@"live"]) {
        self.filterDic = dic;
        [self loadDataQiciJishiViewController];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[NSUserDefaults standardUserDefaults]setObject:dic forKey:localLive];
            [[NSUserDefaults standardUserDefaults]synchronize];
        });
    }
   
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - ************    ************

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self changeTimer]; // 刷新比分
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loadedBifenData"]) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"youjinqiu"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            });
        }
    }
    self.navigationController.navigationBarHidden = YES;
    [self loadRedBombActivity];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaultFailure = @"";
    [self.tableView.mj_header beginRefreshing];
    
    self.filterDic = [[NSUserDefaults standardUserDefaults]objectForKey:localLive];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"didSelectedbifen"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"youjinqiu"];
    [self.view addSubview:self.tableView];
    [self addObserver:self forKeyPath:@"cellNum" options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNewData) name:@"NotificationTogetAllJishibifen" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadFilterData:) name:FilterPageNotification object:nil];
    
//    [self loadDataQiciJishiViewController];
    
    [self creatArr];
   
}
- (void)creatArr {
    _foldInfo = [[NSMutableDictionary alloc] initWithDictionary:@{
                                                                  @"0":@"1",
                                                                  @"1":@"1",
                                                                  @"2":@"1",
                                                                  }];
}
- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = [NSMutableArray arrayWithObjects:@"比赛中",@"未开赛",@"已完场", nil];
    }
    return _titleArr;
}
- (void)getNewData
{
    [_arrData removeAllObjects];
    [_memeryArrAllPart removeAllObjects];
    [self loadDataQiciJishiViewController];
}
- (void)refreshDataByChangeFlag:(NSInteger)flag
{
    _currentFlag = flag;
    [self loadDataQiciJishiViewController];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark -- UITableViewDataSource
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44+60+14, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar -44 - APPDELEGATE.customTabbar.height_myTabBar-14-60) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        [_tableView registerClass:[RLSSaiTableViewCell class] forCellReuseIdentifier:cellJishiViewController];
        [self setupHeaderView];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView reloadData];
    }
    return _tableView;
}
- (void)setupHeaderView {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.font = font13;
    self.tableView.mj_header = header;
}
- (void)headerRefreshData
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"didSelectedbifen"]) {
        [self loadDataQiciJishiViewController];
    }else{
        [self.tableView.mj_header endRefreshing ];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
     if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaisaishi"]) {
         return _arrData.count;
     } else {
         return 1;
     }
    
    
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaisaishi"]) {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaisaishi"]&&(_currentFlag == 1||_currentFlag == 2||_currentFlag == 3)) {
            return 0;
        }
        return 24;
    } else {
        return  0 ;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaisaishi"]) {
        RLSJSbifenModel *model = [_arrData objectAtIndex:section];
        if (model.data.count == 0) {
            return nil;
        }else{
            UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 24)];
            header.backgroundColor = UIColorHex(#EBEBEB);
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, Width - 10, 24)];
            lab.font = font10;
            lab.text = [NSString stringWithFormat:@"%@",model.label];
            lab.textColor = [RLSMethods getColor:model.leagueColor];
            [header addSubview:lab];
            return header;
        }
    }else{
        return [UIView new];
    }
    
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaisaishi"])  {
        RLSJSbifenModel *model = [_arrData objectAtIndex:section];
        self.cellNum = model.data.count;
        return model.data.count;
    } else {
        return _arrData.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RLSSaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellJishiViewController];
    if (!cell) {
        cell = [[RLSSaiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellJishiViewController];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    RLSLiveScoreModel *model;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaisaishi"]) {
        RLSJSbifenModel *bifenModel = [_arrData objectAtIndex:indexPath.section];
       model =  [bifenModel.data objectAtIndex:indexPath.row];
       
    } else {
         model = [_arrData objectAtIndex:indexPath.row];
    }
    cell.ScoreModel = model;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = colorF5;
    cell.backgroundColor = [UIColor whiteColor];
    cell.opaque = YES;
    cell.contentView.opaque = YES;
    return cell;
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaisaishi"]) {
        RLSJSbifenModel *jsmodel = [_arrData objectAtIndex:indexPath.section];
        RLSLiveScoreModel *model = [jsmodel.data objectAtIndex:indexPath.row];
        if (model.remark!= nil && ![model.remark isEqualToString:@""]) {
            return 108;
        }
        return 80;
    } else {
        if (_arrData.count > 0) {
            RLSLiveScoreModel *model = [_arrData objectAtIndex:indexPath.row];
            if (model.remark!= nil && ![model.remark isEqualToString:@""]) {
                return 108;
            }
            return 80;
        }
    }
    return 0;
}
- (RLSDCindexBtn *)indexBtn
{
    if (!_indexBtn) {
        _indexBtn = [[RLSDCindexBtn alloc] initWithFrame:CGRectMake(Width - 50, APPDELEGATE.customTabbar.height_myNavigationBar + 44 + 29, 50, Height - (APPDELEGATE.customTabbar.height_myNavigationBar + 44 + 29 + 49))];
        _indexBtn.delegate = self;
        _indexBtn.hidden= YES;
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
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideIndexBtn) object:nil];
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.00001];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView; 
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideIndexBtn) object:nil];
    [self performSelector:@selector(hideIndexBtn) withObject:nil afterDelay:2];
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
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark - KVO -
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    if([keyPath isEqualToString:@"cellNum"]) {
        if (self.cellNum == 0 ) {
        }
    }
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
        NSString *text = default_noMatch;
        NSDictionary *attributes;
        if (self.arrData.count == 0 ) {
            self.defaultFailure = default_noMatch;
            attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
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
- (void)loadDataQiciJishiViewController {
    [self loadDataJishiViewControllerWithQici:nil];
}

- (void)loadDataJishiViewControllerWithQici:(RLSQiciModel *)model {
    NSString *sub = @"all";
    if (self.filterDic) {
         sub = self.filterDic[ParamtersSub];
    } else {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jingcaibifen"]) {
            sub = @"jc";
        }
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaisaishi"]) {
       
//        NSString *urlStage = @"http://120.55.30.173:8809/bifen/live";
        NSString *urlStage = [NSString stringWithFormat:@"%@/bifen2/live",APPDELEGATE.url_Server];
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
        [parameter setValue:@(1) forKey:@"return_fmt"];
        if (self.filterDic[ParamtersFilters]) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            NSArray *parameters = self.filterDic[ParamtersFilters];
            [dic setValue:self.filterDic[ParamtersType] forKey:@"key"];
            [dic setValue:parameters forKey:@"val"];
            NSString *json = [self getJSONMessage:dic];
            [parameter setValue:json forKey:@"filter"];
            self.filterParameters = json;
        } else {
            self.filterParameters = nil;
        }
        [parameter setValue:sub forKey:@"sub"];
        dispatch_queue_t concurrentqueue=dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);//并行线程队列
        dispatch_async(concurrentqueue, ^{
            [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:urlStage Start:^(id requestOrignal) {
              
            } End:^(id responseOrignal) {
                [self.tableView.mj_header endRefreshing];
            } Success:^(id responseResult, id responseOrignal) {
                self.defaultFailure = @"";
    
                NSMutableArray *arrLoad = [[NSMutableArray alloc] initWithArray:[RLSJSbifenModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"matchs"]]];
                
                if (_memeryArrAllPart.count > 0) {
                    if ([[[_memeryArrAllPart firstObject] class]isEqual:NSClassFromString(@"RLSLiveScoreModel")]) {
                        [_memeryArrAllPart removeAllObjects];
                    }
                }
                
                NSMutableArray *arrComplete = [NSMutableArray array];
                for (int i = 0; i<_memeryArrAllPart.count; i++) {
                    RLSJSbifenModel *jsmodel = [_memeryArrAllPart objectAtIndex:i];
                    for (int m= 0; m<jsmodel.data.count; m++) {
                        RLSLiveScoreModel *model = [jsmodel.data objectAtIndex:m];
                        if (model.matchstate != 0){
                            for (int j= 0; j<arrLoad.count; j++) {
                                RLSJSbifenModel *jsloadmodel = [arrLoad objectAtIndex:j];
                                for (int n = 0; n<jsloadmodel.data.count; n++) {
                                    RLSLiveScoreModel *loadModel = [jsloadmodel.data objectAtIndex:n];
                                    if (model.mid == loadModel.mid) {
                                        if (loadModel.matchstate != model.matchstate) {
                                            if (!(loadModel.matchstate==0 ||loadModel.matchstate==1 ||loadModel.matchstate==2 ||loadModel.matchstate==3 ||
                                                  loadModel.matchstate==4)) {
                                                [arrComplete addObject:loadModel];
                                            }
                                            loadModel.matchstate = model.matchstate;
                                        }
                                        if (loadModel.homescore < model.homescore) {
                                            loadModel.homescore = model.homescore;
                                        }
                                        if (loadModel.guestscore< model.guestscore) {
                                            loadModel.guestscore = model.guestscore;
                                        }
                                        if (loadModel.guestRed <model.guestRed) {
                                            loadModel.guestRed = model.guestRed;
                                        }
                                        if (loadModel.homeRed <model.homeRed) {
                                            loadModel.homeRed = model.homeRed;
                                        }
                                        
                                        if (loadModel.guestYellow <model.guestYellow) {
                                            loadModel.guestYellow = model.guestYellow;
                                        }
                                        if (loadModel.homeYellow <model.homeYellow) {
                                            loadModel.homeYellow = model.homeYellow;
                                        }
                                        if (![loadModel.matchtime isEqualToString:model.matchtime]) {
                                            loadModel.matchtime = model.matchtime;
                                        }
                                        if (![loadModel.matchtime2 isEqualToString:model.matchtime2]) {
                                            loadModel.matchtime2 = model.matchtime2;
                                        }
                   
                                    }
                    
                                }
                            }
                        }
                        
                    }
    }

                //重新写一个arr，防止是全部数据里面完场的比赛加到竞彩，北单，足彩里面
                NSMutableArray *arrRemove = [NSMutableArray array];
                
                for (RLSLiveScoreModel *completeModel in arrComplete) {
                    
                    for (int i = 0; i<arrLoad.count; i++) {
                        
                        RLSJSbifenModel *jsmodel = [arrLoad objectAtIndex:i];
                        
                        if ([jsmodel.data containsObject:completeModel]) {
                            [arrRemove addObject:completeModel];
                            [jsmodel.data removeObject:completeModel];
                        }
                        
                    }
                    
                }
                RLSJSbifenModel *lastModel = [arrLoad lastObject];
                [lastModel.data addObjectsFromArray:arrRemove];
                
                
                //         如果是全部的赛事，就把内存中储存的大对阵换掉
                if(0 == _currentFlag){
                    _memeryArrAllPart = [[NSMutableArray alloc] initWithArray:arrLoad];
                    
                }
            
                _arrData = [[NSMutableArray alloc] initWithArray:arrLoad];

                [self reloadTableView];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
                NSTimeInterval timerinterVal = [[NSDate date] timeIntervalSince1970] + 10;
                [[NSUserDefaults standardUserDefaults] setDouble:timerinterVal forKey:@"bifenchangeSaveTime"];
               
                
            } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
                self.defaultFailure = errorDict;
                
                [_arrData removeAllObjects];
                //        [self.tableView reloadData];
                [self reloadTableView];
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
                
                NSTimeInterval timerinterVal = [[NSDate date] timeIntervalSince1970] + 10;
                [[NSUserDefaults standardUserDefaults] setDouble:timerinterVal forKey:@"bifenchangeSaveTime"];
                
            }];
            
        });
    } else {
        //        NSString *urlStage = @"http://120.55.30.173:8809/bifen/live";
        NSString *urlStage = [NSString stringWithFormat:@"%@/bifen2/live",APPDELEGATE.url_Server];
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
        [parameter setValue:@(0) forKey:@"return_fmt"];
        
        if (self.filterDic[ParamtersFilters]) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            NSArray *parameters = self.filterDic[ParamtersFilters];
            [dic setValue:self.filterDic[ParamtersType] forKey:@"key"];
            [dic setValue:parameters forKey:@"val"];
            NSString *json = [self getJSONMessage:dic];
            [parameter setValue:json forKey:@"filter"];
            self.filterParameters = json;
        } else {
            self.filterParameters = nil;
        }
        
        [parameter setValue:sub forKey:@"sub"];
        dispatch_queue_t concurrentqueue=dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(concurrentqueue, ^{
            [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:urlStage Start:^(id requestOrignal) {
            } End:^(id responseOrignal) {
                [self.tableView.mj_header endRefreshing];
            } Success:^(id responseResult, id responseOrignal) {
                self.defaultFailure = @"";
                if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                    NSMutableArray *arrLoad = [[NSMutableArray alloc] initWithArray:[RLSLiveScoreModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"matchs"]]];
                    
                    if (_memeryArrAllPart.count > 0) {
                        if ([[[_memeryArrAllPart firstObject] class]isEqual:NSClassFromString(@"RLSJSbifenModel")]) {
                            [_memeryArrAllPart removeAllObjects];
                        }
                    }
                    
                    NSMutableArray *arrComplete = [NSMutableArray array];
                    for (int m= 0; m < _memeryArrAllPart.count; m++) {
                        RLSLiveScoreModel *model = [_memeryArrAllPart objectAtIndex:m];
                        if (model.matchstate != 0){
                            for (int n = 0; n<arrLoad.count; n++) {
                                RLSLiveScoreModel *loadModel = [arrLoad objectAtIndex:n];
                                if (model.mid == loadModel.mid) {
                                    if (loadModel.matchstate != model.matchstate) {
                                        if (!(loadModel.matchstate==0 ||loadModel.matchstate==1 ||loadModel.matchstate==2 ||loadModel.matchstate==3 ||
                                              loadModel.matchstate==4)) {
                                            [arrComplete addObject:loadModel];
                                        }
                                        loadModel.matchstate = model.matchstate;
                                    }
                                    if (loadModel.homescore < model.homescore) {
                                        loadModel.homescore = model.homescore;
                                    }
                                    if (loadModel.guestscore< model.guestscore) {
                                        loadModel.guestscore = model.guestscore;
                                    }
                                    if (loadModel.guestRed <model.guestRed) {
                                        loadModel.guestRed = model.guestRed;
                                    }
                                    if (loadModel.homeRed <model.homeRed) {
                                        loadModel.homeRed = model.homeRed;
                                    }
                                    if (loadModel.guestYellow <model.guestYellow) {
                                        loadModel.guestYellow = model.guestYellow;
                                    }
                                    if (loadModel.homeYellow <model.homeYellow) {
                                        loadModel.homeYellow = model.homeYellow;
                                    }
                                    if (![loadModel.matchtime isEqualToString:model.matchtime]) {
                                        loadModel.matchtime = model.matchtime;
                                    }
                                    if (![loadModel.matchtime2 isEqualToString:model.matchtime2]) {
                                        loadModel.matchtime2 = model.matchtime2;
                                    }
                                }
                            }
                        }
                    }
                    if(0 == _currentFlag){
                        _memeryArrAllPart = [[NSMutableArray alloc] initWithArray:arrLoad];
                    }
                    _arrData = [[NSMutableArray alloc] initWithArray:arrLoad];
                    [self reloadTableView];
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
                    NSTimeInterval timerinterVal = [[NSDate date] timeIntervalSince1970] + 10;
                    [[NSUserDefaults standardUserDefaults] setDouble:timerinterVal forKey:@"bifenchangeSaveTime"];
                }
            } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
                self.defaultFailure = errorDict;
                [_arrData removeAllObjects];
                [self reloadTableView];
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
                NSTimeInterval timerinterVal = [[NSDate date] timeIntervalSince1970] + 10;
                [[NSUserDefaults standardUserDefaults] setDouble:timerinterVal forKey:@"bifenchangeSaveTime"];
            }];
        });
    }
}

#pragma mark - FoldSectionHeaderViewDelegate -
- (void)foldHeaderInSection:(NSInteger)SectionHeader {
    NSString *key = [NSString stringWithFormat:@"%d",(int)SectionHeader];
    BOOL folded = [[_foldInfo objectForKey:key] boolValue];
    NSString *fold = folded ? @"0" : @"1";
    [_foldInfo setValue:fold forKey:key];
    [self.tableView reloadData];
}
- (void)changeTimer {
    dispatch_queue_t queue= dispatch_queue_create("timer", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 5.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self timerRun];
        });
    });
    dispatch_resume(_timer);
});
}
- (void)gcdTimer {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
    dispatch_source_set_timer(_timer, start, interval, 0);
    dispatch_source_set_event_handler(_timer, ^{
    });
    dispatch_resume(_timer);
}
- (void)timerRun
{
    if ([[NSDate date] timeIntervalSince1970] > [[NSUserDefaults standardUserDefaults] doubleForKey:@"bifenchangeSaveTime"]) {
        [self loadDataQiciJishiViewController];
    }else{
            [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:[NSString stringWithFormat:@"%@%@%@",APPDELEGATE.url_jsonHeader,@"/jsbf",url_jsbf_change] Start:^(id requestOrignal) {
            } End:^(id responseOrignal) {
            } Success:^(id responseResult, id responseOrignal) {
                NSArray *arrLiving = [RLSLivingModel arrayOfEntitiesFromArray:responseOrignal];
                NSTimeInterval timerinterVal = [[NSDate date] timeIntervalSince1970] + 10;
                [[NSUserDefaults standardUserDefaults] setDouble:timerinterVal forKey:@"bifenchangeSaveTime"];
                [self changeLivingScoreWithData:arrLiving];
            } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
                NSLog(@"%@",responseOrignal);
                NSTimeInterval timerinterVal = [[NSDate date] timeIntervalSince1970] + 10;
                [[NSUserDefaults standardUserDefaults] setDouble:timerinterVal forKey:@"bifenchangeSaveTime"];
            }];
    }
}

- (MBProgressHUD *)hud
{
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:[RLSMethods getMainWindow]];
        _hud.mode= MBProgressHUDModeCustomView;
        _hud.animationType = MBProgressHUDAnimationFade;
        _hud.margin = 0;
        _hud.minShowTime = 3;
        _hud.color = [UIColor clearColor];
        _hud.userInteractionEnabled = NO;
        UIView *basicView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
        UIView *viewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
        viewBg.backgroundColor = [UIColor blackColor];
        viewBg.alpha = 0.5;
        [basicView addSubview:viewBg];
        NSMutableArray *arrImageV = [NSMutableArray array];
        for (int i = 0; i<8; i++) {
            [arrImageV addObject:[UIImage imageNamed:[NSString stringWithFormat:@"jinqiu%d",i]]];
        }
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, Width/375*144)];
        _imageV.center = CGPointMake(Width/2, Height/2);
        _imageV.image = [UIImage imageNamed:@"jinqiu7"];
        _imageV.animationImages = arrImageV;
        _imageV.animationDuration = 1.5;
        _imageV.animationRepeatCount = 1;
        [_imageV startAnimating];
        [basicView addSubview:_imageV];
        _hud.customView = basicView;
        [[RLSMethods getMainWindow] addSubview:_hud];
    }
    return _hud;
}
- (RLSDCJishiBIifenView *)jsbfView
{
    if (!_jsbfView) {
        _jsbfView = [[RLSDCJishiBIifenView alloc] initWithFrame:CGRectMake(20, Height - 49- 30 - 66, Width - 40, 66)];
        RLSJsbfValue *value = [[RLSJsbfValue alloc] init];
        _jsbfView.model = value;
        _jsbfView.userInteractionEnabled = NO;
    }
    return _jsbfView;
}

- (void)changeLivingScoreWithData:(NSArray *)arrLiving
{
    NSArray *arr = arrLiving;
    NSMutableArray *arrlive = [[NSMutableArray alloc] init];
    NSMutableArray *arrComplete = [NSMutableArray array];
    NSMutableArray *arrSendFenxiPage = [NSMutableArray array];
    
    
    NSMutableArray *appendArray = [NSMutableArray array];
    
    BOOL timeType = true; // 判断是按时间 还是按照赛事
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kaisaisaishi"]) {
        
        if (_memeryArrAllPart.count > 0) {
            if ([[[_memeryArrAllPart firstObject] class]isEqual:[RLSLiveScoreModel class]]) {
                [self getNewData];
                return;
            }
        }
        
        appendArray = self.arrData;
        timeType = false;
        
    } else {
        
        if (_memeryArrAllPart.count > 0) {
            if ([[[_memeryArrAllPart firstObject] class] isEqual:[RLSJSbifenModel class]]) {
                [self getNewData];
                return;
            }
            
        }

        RLSJSbifenModel *model = [[RLSJSbifenModel alloc]init];
        model.data = self.arrData;
        [appendArray addObject:model];
        timeType = true;
        
       
    }
    
    if (appendArray > 0 ) {
        for (int i = 0 ; i<appendArray.count; i++) {
            RLSJSbifenModel *jsmodel = [appendArray objectAtIndex:i];
            for (int m = 0; m<jsmodel.data.count; m++) {
                RLSLiveScoreModel * scoreModel= [jsmodel.data objectAtIndex:m];
                for (int j= 0; j<arr.count; j++){
                    RLSLivingModel *livingModel = [arr objectAtIndex:j];
                    if (scoreModel.mid == livingModel.sid) {
                        if (scoreModel.matchstate != livingModel.code) {
                            if (!(livingModel.code == 0 ||livingModel.code == 1 || livingModel.code == 2 || livingModel.code == 3|| livingModel.code == 4)) {
                                [arrComplete addObject:scoreModel];
                            }
                        }
                        NSString *documentsPath = [RLSMethods getDocumentsPath];
                        NSString *arrayPath = [documentsPath stringByAppendingPathComponent:BifenPageAttentionArray];
                        NSMutableArray *arrAttention = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:arrayPath]];
                        BOOL isAttentioned = NO;
                        for (int i = 0; i<arrAttention.count; i++) {
                            NSInteger LmodelMid = [[arrAttention objectAtIndex:i] integerValue];
                            if (LmodelMid == scoreModel.mid) {
                                isAttentioned = YES;
                                break;
                            }else{
                                isAttentioned = NO;
                            }
                        }
                        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"_currentflag"] isEqualToString:@"0"]) {
                            if (scoreModel.neutrality) {
                                RLSLivingModel *change = [[RLSLivingModel alloc] init];
                                change.homeRed = livingModel.guestRed;
                                change.homeYellow = livingModel.homeYellow;
                                change.hsc = livingModel.gsc;
                                change.gsc = livingModel.hsc;
                                change.guestRed = livingModel.homeRed;
                                change.guestYellow = livingModel.homeYellow;
                                change.sid = livingModel.sid;
                                change.half = livingModel.half;
                                change.htime = livingModel.htime;
                                change.code = livingModel.code;
                                livingModel = change;
                            }
                        }
                        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"nightStop"])
                        {
                            if ([[[RLSMethods getDateByDate:[NSDate date] withWeekType:weekTypeXingqi]objectAtIndex:3] intValue]>=7 && [[[RLSMethods getDateByDate:[NSDate date] withWeekType:weekTypeXingqi]objectAtIndex:3] intValue]<=23)
                            {
                                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"attentionMe"])
                                {
                                    if (isAttentioned)
                                    {
                                        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiushengying"])
                                        {
                                            [self jinqiuShowHudWithLivingModel:livingModel NowModel:scoreModel];
                                        }
                                        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpaitishi"])
                                        {
                                            [self hongpaiShowHudLivingModel:livingModel NowModel:scoreModel];
                                        }
                                    }
                                }else{
                                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiushengying"])
                                    {
                                        [self jinqiuShowHudWithLivingModel:livingModel NowModel:scoreModel];
                                    }
                                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpaitishi"])
                                    {
                                        [self hongpaiShowHudLivingModel:livingModel NowModel:scoreModel];
                                    }
                                }
                            }
                        }else{
                            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"attentionMe"])
                            {
                                if (isAttentioned)
                                {
                                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiushengying"])
                                    {
                                        [self jinqiuShowHudWithLivingModel:livingModel NowModel:scoreModel];
                                    }
                                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpaishenying"])
                                    {
                                        [self hongpaiShowHudLivingModel:livingModel NowModel:scoreModel];
                                    }
                                }
                            }else{
                                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiushengying"])
                                {
                                    [self jinqiuShowHudWithLivingModel:livingModel NowModel:scoreModel];
                                }
                                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpaishenying"])
                                {
                                    [self hongpaiShowHudLivingModel:livingModel NowModel:scoreModel];
                                }
                            }
                        }
                        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"_currentflag"] isEqualToString:@"0"]) {
                            if (scoreModel.neutrality) {
                                if (livingModel.half != nil && ![livingModel.half isEqualToString:@""]) {
                                    NSArray *half = [livingModel.half componentsSeparatedByString:@"-"];
                                    scoreModel.homehalfscore = [[half objectAtIndex:1] intValue];
                                    scoreModel.guesthalfscore = [[half objectAtIndex:0] intValue];
                                }
                            }else{
                                if (livingModel.half != nil && ![livingModel.half isEqualToString:@""]) {
                                    NSArray *half = [livingModel.half componentsSeparatedByString:@"-"];
                                    scoreModel.homehalfscore = [[half objectAtIndex:0] intValue];
                                    scoreModel.guesthalfscore = [[half objectAtIndex:1] intValue];
                                }
                            }
                        }else{
                            if (livingModel.half != nil && ![livingModel.half isEqualToString:@""]) {
                                NSArray *half = [livingModel.half componentsSeparatedByString:@"-"];
                                scoreModel.homehalfscore = [[half objectAtIndex:0] intValue];
                                scoreModel.guesthalfscore = [[half objectAtIndex:1] intValue];
                            }
                        }
                        if (scoreModel.homescore <livingModel.hsc) {
                            scoreModel.homescore = livingModel.hsc;
                        }
                        if (scoreModel.homeRed <livingModel.homeRed) {
                            scoreModel.homeRed = livingModel.homeRed;
                        }
                        if (scoreModel.homeYellow <livingModel.homeYellow) {
                            scoreModel.homeYellow = livingModel.homeYellow;
                        }
                        if (scoreModel.guestscore <livingModel.gsc) {
                            scoreModel.guestscore = livingModel.gsc;
                        }
                        if (scoreModel.guestRed <livingModel.guestRed) {
                            scoreModel.guestRed = livingModel.guestRed;
                        }
                        if (scoreModel.guestYellow <livingModel.guestYellow) {
                            scoreModel.guestYellow = livingModel.guestYellow;
                        }
                        scoreModel.matchstate = livingModel.code;
                        if (livingModel.code == 1 ) {
                            scoreModel.matchtime2 = livingModel.htime;
                        }else if (livingModel.code == 2){
                            scoreModel.matchtime2 = livingModel.htime;
                        }else if (livingModel.code == 3){
                            scoreModel.matchtime2 = livingModel.htime;
                        }else if (livingModel.code == 4){
                            scoreModel.matchtime2 = livingModel.htime;
                        }
                        NSIndexPath *path = [NSIndexPath indexPathForRow:m inSection:i];
                        [arrlive addObject:path];
                        [arrSendFenxiPage addObject:scoreModel];
                    }
                }
            }
        }
    }
    if (arrlive.count >0) {
        [self reloadTableView];
    }
    for (int i = 0 ; i<appendArray.count; i++) {
        RLSJSbifenModel *jsmodel = [appendArray objectAtIndex:i];
        for (int m = 0; m<jsmodel.data.count; m++) {
            RLSLiveScoreModel * scoreModel= [jsmodel.data objectAtIndex:m];
            if (timeType) {
                for (int j= 0; j<_memeryArrAllPart.count; j++){
                    RLSLiveScoreModel *mmModel = [_memeryArrAllPart objectAtIndex:j];
                    if (scoreModel.mid == mmModel.mid) {
                        mmModel = scoreModel;
                    }
                }
            } else {
                for (int j= 0; j<_memeryArrAllPart.count; j++){
                    RLSJSbifenModel *jsMMmodel = [_memeryArrAllPart objectAtIndex:j];
                    for (int n = 0; n<jsMMmodel.data.count; n++) {
                        RLSLiveScoreModel *mmModel = [jsMMmodel.data objectAtIndex:n];
                        if (scoreModel.mid == mmModel.mid) {
                            mmModel = scoreModel;
                        }
                    }
                }
            }
        }
    }
    NSMutableArray *arrRemove = [NSMutableArray array];
            for (RLSLiveScoreModel *model in arrComplete) {
                for (int i = 0; i<appendArray.count; i++) {
                    RLSJSbifenModel *jsmodel = [appendArray objectAtIndex:i];
                    if ([jsmodel.data containsObject:model]) {
                        [arrRemove addObject:model];
                        [jsmodel.data removeObject:model];
                    }
                }
            }
    RLSJSbifenModel *jsmodel= [appendArray lastObject];
    [jsmodel.data addObjectsFromArray:arrRemove];
    if (arrComplete.count>0) {
        [self reloadTableView];
    }
    
    
}
- (void)jinqiuShowHudWithLivingModel:(RLSLivingModel *)livingModel NowModel:(RLSLiveScoreModel *)scoreModel
{
    if (livingModel.hsc > scoreModel.homescore) {
        scoreModel.homescore =livingModel.hsc;
        RLSJsbfValue *model = [[RLSJsbfValue alloc] init];
        model.time = [self getLivetime:scoreModel];
        model.league =scoreModel.league;
        model.home = scoreModel.hometeam;
        model.homeScore = [NSString stringWithFormat:@"%ld",(long)livingModel.hsc];
        model.guest = scoreModel.guestteam;
        model.guestScore = [NSString stringWithFormat:@"%ld",(long)livingModel.gsc];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiutanchuan"] || [[NSUserDefaults standardUserDefaults] boolForKey:@"hongpaitanchuang"]) {
                [[RLSMethods getMainWindow] addSubview:self.jsbfView];
            }
            self.jsbfView.isRed = NO;
            self.jsbfView.ishome = YES;
            self.jsbfView.model = model;
        });
        [self musicShowJinqiu];
        [self showJinqiuHud];
        [self hideJinqiuHudAfterSeconds:10];
        if (APPDELEGATE.customTabbar.selectedIndex == 1) {
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"showJinqiuAnimation"]) {
            }
        }
        scoreModel.bgIsRed = YES;
        [self reloadTableView];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"youjinqiu"];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 10*NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            scoreModel.bgIsRed = NO;
            [self.tableView reloadData];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"youjinqiu"];
        });
    }
    if (livingModel.gsc > scoreModel.guestscore) {
        scoreModel.guestscore = livingModel.gsc;
        [self musicShowJinqiu];
        RLSJsbfValue *model = [[RLSJsbfValue alloc] init];
        model.time = [self getLivetime:scoreModel];
        model.league =scoreModel.league;
        model.home = scoreModel.hometeam;
        model.homeScore = [NSString stringWithFormat:@"%ld",(long)livingModel.hsc];
        model.guest = scoreModel.guestteam;
        model.guestScore = [NSString stringWithFormat:@"%ld",(long)livingModel.gsc];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[RLSMethods getMainWindow] addSubview:self.jsbfView];
            self.jsbfView.isRed = NO;
            self.jsbfView.ishome = NO;
            self.jsbfView.model = model;
        });
        [self showJinqiuHud];
        [self hideJinqiuHudAfterSeconds:10];
        if (APPDELEGATE.customTabbar.selectedIndex == 1) {
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"showJinqiuAnimation"]) {
            }
        }
        scoreModel.bgIsRed = YES;
        [self reloadTableView];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"youjinqiu"];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 10*NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            scoreModel.bgIsRed = NO;
            [self.tableView reloadData];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"youjinqiu"];
        });
    }
}
- (void)reloadTableView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
- (void)hongpaiShowHudLivingModel:(RLSLivingModel *)livingModel NowModel:(RLSLiveScoreModel *)scoreModel
{
    if (livingModel.homeRed >scoreModel.homeRed) {
        scoreModel.homeRed = livingModel.homeRed;
        scoreModel.guestRed = livingModel.guestRed;
        [self musicShowRed];
        scoreModel.homeRed = livingModel.homeRed;
        scoreModel.guestRed = livingModel.guestRed;
        RLSJsbfValue *model = [[RLSJsbfValue alloc] init];
        model.time = [self getLivetime:scoreModel];
        model.league =scoreModel.league;
        model.RedTeam = scoreModel.hometeam;
        model.home = scoreModel.hometeam;
        model.guest = scoreModel.guestteam;
        model.redHome = [NSString stringWithFormat:@"%ld",(long)livingModel.homeRed];
        model.redGuest = [NSString stringWithFormat:@"%ld",(long)livingModel.guestRed];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[RLSMethods getMainWindow] addSubview:self.jsbfView];
            self.jsbfView.isRed = YES;
            self.jsbfView.ishome = YES;
            self.jsbfView.model = model;
        });
        [self showJinqiuHud];
        [self hideJinqiuHudAfterSeconds:10];
    }
    if (livingModel.guestRed > scoreModel.guestRed) {
        [self musicShowRed];
        scoreModel.homeRed = livingModel.homeRed;
        scoreModel.guestRed = livingModel.guestRed;
        RLSJsbfValue *model = [[RLSJsbfValue alloc] init];
        model.time = [self getLivetime:scoreModel];
        model.league =scoreModel.league;
        model.RedTeam = scoreModel.guestteam;
        model.home = scoreModel.hometeam;
        model.guest = scoreModel.guestteam;
        model.redHome = [NSString stringWithFormat:@"%ld",(long)livingModel.homeRed];
        model.redGuest = [NSString stringWithFormat:@"%ld",(long)livingModel.guestRed];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[RLSMethods getMainWindow] addSubview:self.jsbfView];
            self.jsbfView.isRed = YES;
            self.jsbfView.ishome = NO;
            self.jsbfView.model = model;
        });
        [self showJinqiuHud];
        [self hideJinqiuHudAfterSeconds:10];
    }
}
- (void)musicShowRed
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpaishenying"]) {
        NSString *path = nil;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"huanhu"]) {
            path = [[NSBundle mainBundle] pathForResource:@"music11" ofType:@"wav"];
        }else if([[NSUserDefaults standardUserDefaults] boolForKey:@"koushao"]){
            path = [[NSBundle mainBundle] pathForResource:@"music1" ofType:@"wav"];
        }
        if (path) {
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_id);
            AudioServicesPlaySystemSound(shake_sound_id);
        }
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpaizhendong"]) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   
        }
    }else{
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpaizhendong"]) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   
        }
    }
}
- (void)musicShowJinqiu
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiushengying"]) {
        NSString *path = nil;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"huanhu"]) {
            path = [[NSBundle mainBundle] pathForResource:@"music11" ofType:@"wav"];
        }else if([[NSUserDefaults standardUserDefaults] boolForKey:@"koushao"]){
            path = [[NSBundle mainBundle] pathForResource:@"music1" ofType:@"wav"];
        }
        if (path) {
             AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_id);
            AudioServicesPlaySystemSound(shake_sound_id);
        }
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiuzhendong"]) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   
        }
    }else{
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiuzhendong"]) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   
        }
    }
}
- (NSString *)getLivetime:(RLSLiveScoreModel *)scoreModel
{
    NSString *time = [RLSMethods getDateByStyle:dateStyleFormatter withDate:[NSDate date]];
    switch (scoreModel.matchstate) {
        case 0:
        {
            return @"0";
        }
            break;
        case 1:
        {
            NSString *timeCha =[RLSMethods intervalFromLastDate:scoreModel.matchtime2 toTheDate:time];
            if ([timeCha isEqualToString:@"0"]) {
                return @"1";
            }else{
                if ([timeCha intValue]>45) {
                    return @"45+";
                }else{
                    return timeCha;
                }
            }
        }
            break;
        case 2:
        {
            return  @"中场";
        }
            break;
        case 3:
        {
            NSString *timeCha = [RLSMethods intervalFromLastDateAnd45:scoreModel.matchtime2 toTheDate:time];
            if ([timeCha intValue]>90) {
                return  @"90+";
            }else if ([timeCha intValue] == 45){
                return  @"46";
            }
            else{
                return  timeCha;
            }
        }
            break;
        case 4:
        {
            return  [RLSMethods intervalFromLastDateAnd45:scoreModel.matchtime2 toTheDate:time];
        }
            break;
        default:
        {
            return  @"0";
        }
            break;
    }
}
- (void)showJinqiuHud
{
}
- (void)hideJinqiuHudAfterSeconds:(NSInteger)sec
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sec * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.jsbfView removeFromSuperview];
        self.jsbfView = nil;
    });
}
- (void)staybifen
{
}
#pragma mark -  活动入口
#pragma mark - GQWebViewDelegate
- (void)webClose:(id)data {
    if (_activityWeb) {
        [_activityWeb removeFromSuperview];
        _activityWeb = nil;
    }
}
- (void)loadRedBombActivity {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [[RLSDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_redBomb]  Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        NSString *code = responseOrignal[@"code"];
        if ([code isEqualToString:@"200"]) {
            NSDictionary *itemDic = responseOrignal[@"data"];
            if (itemDic) {
                self.activityDic = itemDic;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self addActivityWith:itemDic];
                });
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self addActivityWith:nil];
            });
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addActivityWith:nil];
        });
    }];
}
- (void)addActivityWith:(NSDictionary *)dataDic {
    if ([dataDic isKindOfClass:[NSDictionary class]]) {
        if (!_activityImageView) {
            [self.view addSubview:self.activityImageView];
            CGRect rect = self.tableView.frame;
            rect.origin.y = rect.origin.y + 66;
            rect.size.height = rect.size.height - 66;
            self.tableView.frame = rect;
        }
        [self.activityImageView sd_setImageWithURL:[NSURL URLWithString:dataDic[@"picture"]]];
    } else {
        if (_activityImageView) {
            [_activityImageView removeFromSuperview];
            _activityImageView = nil;
        }
        self.tableView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44+14+60, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar -44 - APPDELEGATE.customTabbar.height_myTabBar-14-60);
    }
}
#pragma mark - Events
- (void)redBombActivity:(UIGestureRecognizer *)tap {
    if (self.activityDic) {
        if (![RLSMethods login]) {
            [RLSMethods toLogin];
            return;
        }
        [MobClick event:@"yhb3" label:@""];
        RLSWebModel *model = [[RLSWebModel alloc]init];
        model.title = PARAM_IS_NIL_ERROR(self.activityDic[@"title"]);
        model.webUrl = PARAM_IS_NIL_ERROR(self.activityDic[@"activityUrl"]);
        model.hideNavigationBar = YES;
        RLSWebView *web = [[RLSWebView alloc]init];
        web.webDelegate = self;
        web.frame = [UIScreen mainScreen].bounds;
        web.model = model;
        web.opaque = NO;
        web.backgroundColor = [UIColor clearColor];
        web.scrollView.scrollEnabled = false;
        [[RLSMethods getMainWindow] addSubview:web];
        _activityWeb = web;
    } else {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"活动不可用"];
    }
}
- (void)closeActivity {
    [self addActivityWith:nil];
}
#pragma mark - Lazy Load
- (UIImageView *)activityImageView {
    if (_activityImageView == nil) {
        _activityImageView = [UIImageView new];
        _activityImageView.frame = CGRectMake(0, 118, Width, 66);
        _activityImageView.contentMode = UIViewContentModeScaleAspectFill;
        _activityImageView.clipsToBounds = YES;
        _activityImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(redBombActivity:)];
        [_activityImageView addGestureRecognizer:tap];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"redbombclose"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(closeActivity) forControlEvents:UIControlEventTouchUpInside];
        [_activityImageView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_activityImageView.mas_top).offset(5);
            make.right.equalTo(_activityImageView.mas_right).offset(-5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
    }
    return _activityImageView;
}
@end
