#import "RLSSaishiSelecterdVC.h"
#import "RLSTitleIndexView.h"
#import "RLSLiveScoreModel.h"
#import "RLSBIfenSelectedSaishiModel.h"
#import "RLSJSbifenModel.h"


NSString *const FilterPageNotification = @"FilterPageNotification";
NSString *const ParamtersTab = @"tab";
NSString *const ParamtersSub = @"sub";
NSString *const ParamtersTimeline = @"timeline";
NSString *const ParamtersFilters = @"filter";
NSString *const ParamtersType = @"Type";
NSString *const localLive = @"localLive";
NSString *const localOld = @"localOld";
NSString *const localNew = @"localNew";



@interface RLSSaishiSelecterdVC ()<ViewPagerDelegate,ViewPagerDataSource,TitleIndexViewDelegate,SelectedAllVCDelegate,SelectedJincaiVCDelegate,SelectedChupanVCDelegate,NavViewDelegate>
@property (nonatomic, strong) RLSTitleIndexView *titleView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic , strong) UIButton *saishiBtn;
@property (nonatomic , strong) UIButton *pankouBtn;
@end
@implementation RLSSaishiSelecterdVC


- (void)matchAction:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    sender.selected = !sender.selected;
    self.pankouBtn.selected = false;
    [_titleView removeFromSuperview];
    _titleView = nil;
    _titleView = [[RLSTitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 44)];
    _titleView.selectedIndex = 0;
    _titleView.bottomLineColor = colorDD;
    _titleView.arrData = @[@"全部",@"竞彩",@"足彩", @"北单"];
    _titleView.delegate =self;
    [self.view addSubview:_titleView];
    [self reloadData];
}

- (void)panjouAction:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    sender.selected = !sender.selected;
    self.saishiBtn.selected = false;
    [_titleView removeFromSuperview];
    _titleView = nil;
    _titleView = [[RLSTitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 44)];
    _titleView.selectedIndex = 0;
    _titleView.bottomLineColor = colorDD;
    _titleView.arrData = @[@"让球",@"进球数"];
    _titleView.delegate =self;
    [self.view addSubview:_titleView];
    [self reloadData];
}

#pragma mark - ************   ************

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate =self;
    self.dataSource = self;
    self.manualLoadData = NO;
    self.scrollingLocked = NO;
    [self.view addSubview:self.titleView];
    self.currentIndex = 0;
    [self setNavView];
}
- (void)didSelectedAtIndex:(NSInteger)index
{
    UIPageViewControllerNavigationDirection direction;
    if (index < _currentIndex) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }else{
        direction = UIPageViewControllerNavigationDirectionForward;
    }
    UIViewController *viewController = [self viewControllerAtIndex:index];
    if (viewController) {
        __weak typeof(self) weakself = self;
        [self.pageViewController setViewControllers:@[viewController] direction:direction animated:YES completion:^(BOOL finished) {
            weakself.currentIndex = index;
        }];
    }
}
#pragma mark -- setnavView
- (void)setNavView
{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
    
    CGFloat halfWidth = Width / 2;
    
    
    UIButton *saishiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saishiBtn setTitle:@"赛事" forState:UIControlStateNormal];
    [saishiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [saishiBtn setTitleColor:UIColorHex(#F4BCB7) forState:UIControlStateNormal];
    saishiBtn.titleLabel.font = font17;
    saishiBtn.frame = CGRectMake(halfWidth - 70, 20, 40, 44);
    [saishiBtn addTarget:self action:@selector(matchAction:) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:saishiBtn];
    self.saishiBtn = saishiBtn;
    
    UIButton *pankouBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pankouBtn setTitle:@"盘口" forState:UIControlStateNormal];
    [pankouBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [pankouBtn setTitleColor:UIColorHex(#F4BCB7) forState:UIControlStateNormal];
    pankouBtn.titleLabel.font = font17;
    pankouBtn.frame = CGRectMake(halfWidth + 30, 20, 40, 44);
    [pankouBtn addTarget:self action:@selector(panjouAction:) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:pankouBtn];
    self.pankouBtn = pankouBtn;
    [self matchAction:saishiBtn];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
    }
}
- (NSUInteger)numberOfTabsForViewPager:(RLSViewPagerController *)viewPager
{
    return _titleView.arrData.count;
}
- (UIViewController *)viewPager:(RLSViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    switch (index) {
        case 0:
        {
            if (self.saishiBtn.isSelected) {
                RLSSelectedAllVC *SelectedV  = [[RLSSelectedAllVC alloc] init];
                SelectedV.type = _type;
                SelectedV.delegate = self;
                SelectedV.playType = PlayTypeAll;
                SelectedV.sub = @"all";
                SelectedV.timeline =  self.timeline;
                SelectedV.date = self.date;
                SelectedV.filterParameters = self.filterParameters;
                return SelectedV;
            } else {
                RLSSelectedJincaiVC *SelectedV  = [[RLSSelectedJincaiVC alloc] init];
                SelectedV.type = _type;
                SelectedV.timeline =  self.timeline;
                SelectedV.tab = @"pankou_rq";
                SelectedV.delegate = self;
                SelectedV.date = self.date;
                SelectedV.filterParameters = self.filterParameters;
                return SelectedV;
            }
        }
            break;
        case 1:
        {
            if (self.saishiBtn.isSelected) {
                RLSSelectedAllVC *SelectedV  = [[RLSSelectedAllVC alloc] init];
                SelectedV.type = _type;
                SelectedV.delegate = self;
                SelectedV.playType = PlayTypejingcai;
                SelectedV.sub = @"jc";
                SelectedV.timeline =  self.timeline;
                SelectedV.date = self.date;
                SelectedV.filterParameters = self.filterParameters;
                return SelectedV;
            } else {
                RLSSelectedJincaiVC *SelectedV  = [[RLSSelectedJincaiVC alloc] init];
                SelectedV.type = _type;
                SelectedV.delegate = self;
                SelectedV.timeline =  self.timeline;
                SelectedV.tab = @"pankou_dx";
                SelectedV.date = self.date;
                SelectedV.filterParameters = self.filterParameters;
                return SelectedV;
            }
        }
            break;
        case 2:
        {
            RLSSelectedAllVC *SelectedV  = [[RLSSelectedAllVC alloc] init];
            SelectedV.type = _type;
            SelectedV.delegate = self;
            SelectedV.playType = PlayTypezucai;
            SelectedV.sub = @"zc";
            SelectedV.timeline =  self.timeline;
            SelectedV.date = self.date;
            SelectedV.filterParameters = self.filterParameters;
            return SelectedV;
        }
            break;
        case 3:
        {
            RLSSelectedAllVC *SelectedV  = [[RLSSelectedAllVC alloc] init];
            SelectedV.type = _type;
            SelectedV.delegate = self;
            SelectedV.playType = PlayTypebeidan;
            SelectedV.sub = @"bd";
            SelectedV.timeline =  self.timeline;
            SelectedV.date = self.date;
            SelectedV.filterParameters = self.filterParameters;
            return SelectedV;
        }
            break;
        default:
            break;
    }
    return nil;
}
- (void)confirmSelectedChupanWithData:(NSArray *)arrSaveData
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"loadedBifenData"];
    NSMutableArray *arrSend = [NSMutableArray array];
    if (_type == typeSaishiSelecterdVCBifen) {
        for (int i = 0; i<_arrBifenData.count; i++) {
            RLSJSbifenModel *jsmodel = [_arrBifenData objectAtIndex:i];
            RLSJSbifenModel *sendJs = [[RLSJSbifenModel alloc] init];
            sendJs.time = jsmodel.time;
            sendJs.data = [NSMutableArray array];
            [arrSend addObject:sendJs];
            for (int m = 0; m<jsmodel.data.count; m++) {
                RLSLiveScoreModel *model = [jsmodel.data objectAtIndex:m];
                NSArray *arrletgoal = [model.letgoal componentsSeparatedByString:@","];
                NSArray *arrtotal = [model.total componentsSeparatedByString:@","];
                NSArray *arrstandard = [model.standard componentsSeparatedByString:@","];
                for (int j = 0; j<arrSaveData.count; j++) {
                    RLSBIfenSelectedSaishiModel *modelSave = [arrSaveData objectAtIndex:j];
                    if (self.type == typeSaishiSelecterdVCTuijian ||  self.type == typeSaishiSelecterdVCInfo) {
                        if ([modelSave.name isEqualToString:model.letgoal]) {
                            [arrSend addObject:model];
                        }
                    }else{
                        if (arrletgoal.count == 3) {
                            if ([modelSave.name isEqualToString:[arrletgoal objectAtIndex:1]]) {
                                [sendJs.data addObject:model];
                                break;
                            }
                        }
                        if (arrtotal.count == 3) {
                            if ([modelSave.name isEqualToString:[arrtotal objectAtIndex:1]]) {
                                [sendJs.data addObject:model];
                                break;
                            }
                        }
                        if (arrstandard.count == 3) {
                            if ([modelSave.name isEqualToString:[arrstandard objectAtIndex:1]]) {
                                [sendJs.data addObject:model];
                                break;
                            }
                        }
                    }
                }
            }
        }
        NSString *documentPath = [RLSMethods getDocumentsPath];
        NSString *arrSaveBifenChuPanSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenChupanSelectedPath];
        [NSKeyedArchiver archiveRootObject:arrSaveData toFile:arrSaveBifenChuPanSelected];
        NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenAllSelectedPath];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenAllSelected];
        NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveBifenJingcaiSelectedPath];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenJingcaiSelected];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateByselectedSaishi object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:arrSend,@"arrData", nil]];
    }else if (_type == typeSaishiSelecterdVCTuijian)
    {
        for (int i = 0; i<_arrBifenData.count; i++) {
            RLSLiveScoreModel *model = [_arrBifenData objectAtIndex:i];
            NSArray *arrletgoal = [model.letgoal componentsSeparatedByString:@","];
            NSArray *arrtotal = [model.total componentsSeparatedByString:@","];
            NSArray *arrstandard = [model.standard componentsSeparatedByString:@","];
            for (int j = 0; j<arrSaveData.count; j++) {
                RLSBIfenSelectedSaishiModel *modelSave = [arrSaveData objectAtIndex:j];
                if (self.type == typeSaishiSelecterdVCTuijian ||  self.type == typeSaishiSelecterdVCInfo) {
                    if ([modelSave.name isEqualToString:model.letgoal]) {
                        [arrSend addObject:model];
                    }
                }else{
                    if (arrletgoal.count == 3) {
                        if ([modelSave.name isEqualToString:[arrletgoal objectAtIndex:1]]) {
                            [arrSend addObject:model];
                            break;
                        }
                    }
                    if (arrtotal.count == 3) {
                        if ([modelSave.name isEqualToString:[arrtotal objectAtIndex:1]]) {
                            [arrSend addObject:model];
                            break;
                        }
                    }
                    if (arrstandard.count == 3) {
                        if ([modelSave.name isEqualToString:[arrstandard objectAtIndex:1]]) {
                            [arrSend addObject:model];
                            break;
                        }
                    }
                }
            }
        }
        NSString *documentPath = [RLSMethods getDocumentsPath];
        NSString *arrSaveBifenChuPanSelected = [documentPath stringByAppendingPathComponent:arrSaveChupanSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:arrSaveData toFile:arrSaveBifenChuPanSelected];
        NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveAllSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenAllSelected];
        NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveJingcaiSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenJingcaiSelected];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateByselectedJingCaiSaishi object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:arrSend,@"arrData",@"2",@"type", nil]];
    }else if (_type == typeSaishiSelecterdVCInfo)
    {
        for (int i = 0; i<_arrBifenData.count; i++) {
            RLSLiveScoreModel *model = [_arrBifenData objectAtIndex:i];
            NSArray *arrletgoal = [model.letgoal componentsSeparatedByString:@","];
            NSArray *arrtotal = [model.total componentsSeparatedByString:@","];
            NSArray *arrstandard = [model.standard componentsSeparatedByString:@","];
            for (int j = 0; j<arrSaveData.count; j++) {
                RLSBIfenSelectedSaishiModel *modelSave = [arrSaveData objectAtIndex:j];
                if (self.type == typeSaishiSelecterdVCTuijian ||  self.type == typeSaishiSelecterdVCInfo){
                    if ([modelSave.name isEqualToString:model.letgoal]) {
                        [arrSend addObject:model];
                    }
                }else{
                    if (arrletgoal.count == 3) {
                        if ([modelSave.name isEqualToString:[arrletgoal objectAtIndex:1]]) {
                            [arrSend addObject:model];
                            break;
                        }
                    }
                    if (arrtotal.count == 3) {
                        if ([modelSave.name isEqualToString:[arrtotal objectAtIndex:1]]) {
                            [arrSend addObject:model];
                            break;
                        }
                    }
                    if (arrstandard.count == 3) {
                        if ([modelSave.name isEqualToString:[arrstandard objectAtIndex:1]]) {
                            [arrSend addObject:model];
                            break;
                        }
                    }
                }
            }
        }
        NSString *documentPath = [RLSMethods getDocumentsPath];
        NSString *arrSaveBifenChuPanSelected = [documentPath stringByAppendingPathComponent:arrSaveChupanSelectedPathinfo];
        [NSKeyedArchiver archiveRootObject:arrSaveData toFile:arrSaveBifenChuPanSelected];
        NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveAllSelectedPathinfo];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenAllSelected];
        NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveJingcaiSelectedPathinfo];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenJingcaiSelected];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateByselectedinfo object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:arrSend,@"arrData",@"2",@"type", nil]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 盘口带过来数据

- (void)confirmSelectedJincaiWithData:(NSArray *)arrSaveData
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"loadedBifenData"];
    NSMutableArray *arrSend = [NSMutableArray array];
    if (_type == typeSaishiSelecterdVCBifen) {
        NSString *str = @"";
        if (self.currentIndex == 0) {
            str = @"pankou_rq";
        } else {
            str = @"pankou_dx";
        }
        NSMutableArray *matchIDs = [NSMutableArray array];
        [arrSaveData enumerateObjectsUsingBlock:^(RLSBIfenSelectedSaishiModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [matchIDs addObject:@([obj.idId floatValue])];
        }];
        NSDictionary *dic;
        if (arrSaveData) {
            dic = @{
                    ParamtersTimeline: self.timeline,
                    ParamtersFilters:matchIDs,
                    ParamtersTab: str,
                    ParamtersType: str
                    };
        } else {
            dic = @{
                    ParamtersTimeline: self.timeline,
                    ParamtersTab: str,
                    ParamtersType: str
                    };
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:FilterPageNotification object:nil userInfo:@{@"paramer":dic}];
        
    }else if (_type == typeSaishiSelecterdVCTuijian)
    {
        for (int i = 0; i<_arrBifenData.count; i++) {
            RLSLiveScoreModel *model = [_arrBifenData objectAtIndex:i];
            for (int j = 0; j<arrSaveData.count; j++) {
                RLSBIfenSelectedSaishiModel *modelSave = [arrSaveData objectAtIndex:j];
                if (model.leagueId == modelSave.idId) {
                    [arrSend addObject:model];
                    break;
                }
            }
        }
        NSString *documentPath = [RLSMethods getDocumentsPath];
        NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveJingcaiSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:arrSaveData toFile:arrSaveBifenJingcaiSelected];
        NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveAllSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenAllSelected];
        NSString *arrSaveBifenChupanSelected = [documentPath stringByAppendingPathComponent:arrSaveChupanSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenChupanSelected];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateByselectedJingCaiSaishi object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:arrSend,@"arrData",@"1",@"type", nil]];
    }else if (_type == typeSaishiSelecterdVCInfo)
    {
        for (int i = 0; i<_arrBifenData.count; i++) {
            RLSLiveScoreModel *model = [_arrBifenData objectAtIndex:i];
            for (int j = 0; j<arrSaveData.count; j++) {
                RLSBIfenSelectedSaishiModel *modelSave = [arrSaveData objectAtIndex:j];
                if (model.leagueId == modelSave.idId) {
                    [arrSend addObject:model];
                    break;
                }
            }
        }
        NSString *documentPath = [RLSMethods getDocumentsPath];
        NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveJingcaiSelectedPathinfo];
        [NSKeyedArchiver archiveRootObject:arrSaveData toFile:arrSaveBifenJingcaiSelected];
        NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveAllSelectedPathinfo];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenAllSelected];
        NSString *arrSaveBifenChupanSelected = [documentPath stringByAppendingPathComponent:arrSaveChupanSelectedPathinfo];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenChupanSelected];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateByselectedinfo object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:arrSend,@"arrData",@"1",@"type", nil]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 赛事带过来数据

- (void)confirmSelectedAllWithData:(NSArray *)arrSaveData
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"loadedBifenData"];
    NSMutableArray *arrSend = [NSMutableArray array];
    if (_type == typeSaishiSelecterdVCBifen) {
        NSString *str = @"all";
        if (self.currentIndex == 0) {
            str = @"all";
        } else if (self.currentIndex == 1){
            str = @"jc";
        } else if (self.currentIndex == 2){
            str = @"zc";
        }  else if (self.currentIndex == 3){
            str = @"bd";
        }
        
        NSMutableArray *matchIDs = [NSMutableArray array];
        [arrSaveData enumerateObjectsUsingBlock:^(RLSBIfenSelectedSaishiModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [matchIDs addObject:@([obj.idId floatValue])];
        }];
        
        NSDictionary *dic;
        if (arrSaveData) {
            dic = @{
                    ParamtersTimeline: self.timeline,
                    ParamtersFilters:matchIDs,
                    ParamtersSub:str,
                    ParamtersType: @"sclasss"
                    };
        } else {
            dic = @{
                    ParamtersTimeline: self.timeline,
                    ParamtersSub:str,
                    ParamtersType: @"sclasss"
                    };
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:FilterPageNotification object:nil userInfo:@{@"paramer":dic}];
       
    }else if (_type == typeSaishiSelecterdVCTuijian)
    {
        for (int i = 0; i<_arrBifenData.count; i++) {
            RLSLiveScoreModel *model = [_arrBifenData objectAtIndex:i];
            for (int j = 0; j<arrSaveData.count; j++) {
                RLSBIfenSelectedSaishiModel *modelSave = [arrSaveData objectAtIndex:j];
                if (model.leagueId == modelSave.idId) {
                    [arrSend addObject:model];
                    break;
                }
            }
        }
        NSString *documentPath = [RLSMethods getDocumentsPath];
        NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveAllSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:arrSaveData toFile:arrSaveBifenAllSelected];
        NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveJingcaiSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenJingcaiSelected];
        NSString *arrSaveBifenChupanSelected = [documentPath stringByAppendingPathComponent:arrSaveChupanSelectedPathTuijianJingcai];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenChupanSelected];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateByselectedJingCaiSaishi object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:arrSend,@"arrData",@"1",@"type", nil]];
    }else if (_type == typeSaishiSelecterdVCInfo)
    {
        for (int i = 0; i<_arrBifenData.count; i++) {
            RLSLiveScoreModel *model = [_arrBifenData objectAtIndex:i];
            for (int j = 0; j<arrSaveData.count; j++) {
                RLSBIfenSelectedSaishiModel *modelSave = [arrSaveData objectAtIndex:j];
                if (model.leagueId == modelSave.idId) {
                    [arrSend addObject:model];
                    break;
                }
            }
        }
        NSString *documentPath = [RLSMethods getDocumentsPath];
        NSString *arrSaveBifenAllSelected = [documentPath stringByAppendingPathComponent:arrSaveAllSelectedPathinfo];
        [NSKeyedArchiver archiveRootObject:arrSaveData toFile:arrSaveBifenAllSelected];
        NSString *arrSaveBifenJingcaiSelected = [documentPath stringByAppendingPathComponent:arrSaveJingcaiSelectedPathinfo];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenJingcaiSelected];
        NSString *arrSaveBifenChupanSelected = [documentPath stringByAppendingPathComponent:arrSaveChupanSelectedPathinfo];
        [NSKeyedArchiver archiveRootObject:[NSArray array] toFile:arrSaveBifenChupanSelected];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateByselectedinfo object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:arrSend,@"arrData",@"1",@"type", nil]];
    }
    [self.navigationController popViewControllerAnimated:YES];
   
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    if (self.currentIndex != 0 && contentOffsetX <= Width * 2) {
        contentOffsetX += Width * self.currentIndex;
    }
}
- (void)scrollEnabled:(BOOL)enabled {
    self.scrollingLocked = !enabled;
    for (UIScrollView *view in self.pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.scrollEnabled = enabled;
            view.bounces = enabled;
        }
    }
}
- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    [self.titleView updateSelectedIndex:_currentIndex];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
