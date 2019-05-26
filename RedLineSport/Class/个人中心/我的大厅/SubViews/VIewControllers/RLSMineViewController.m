#import "RLSMineViewController.h"
#import "RLSBasicTableView.h"
#import "RLSMineTableViewCell.h"
#import "RLSMineViewModel.h"
#import "RLSMineHeaderView.h"
#import "RLSUserTuijianVC.h"
#import "RLSMyBuyTuijianVC.h"
#import "RLSFeedbackVC.h"
#import "RLSSettingVC.h"
#import "RLSFriendsVC.h"
#import "RLSToolWebViewController.h"
#import "RLSToAnalystsVC.h"
@interface RLSMineViewController () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) RLSBasicTableView *tableView;
@property (nonatomic, copy) NSArray *contentArray;
@property (nonatomic , strong) RLSMineHeaderView *headerView;
@property (nonatomic, strong) RLSUserModel *userModel;
@end
@implementation RLSMineViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    if ([RLSMethods login]) {
//        self.headerView.height = 200 + 35 + 70;
//    } else {
        self.headerView.height = 160;
//    }
    [self loadData];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark - Config UI
- (void)configUI {
    self.view.backgroundColor = UIColorFromRGBWithOX(0xebebeb);
    self.tableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height - self.tabBarController.tabBar.height);
    adjustsScrollViewInsets_NO(self.tableView, self);
    [self setupHeader];
}
- (void)setupHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    header.stateLabel.font = font13;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
}
#pragma mark - Load Data
- (void)loadData {
    _contentArray = [RLSMineViewModel getMineDataArray];
    if ([RLSMethods login]) {
        _userModel = [RLSMethods getUserModel];
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
        [parameter setObject:[NSString stringWithFormat:@"%ld",(long)_userModel.idId] forKey:@"id"];
        [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_usernewinfo] Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
            [self.tableView.mj_header endRefreshing];
        } Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                _userModel = [RLSUserModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
                [RLSMethods updateUsetModel:_userModel];
                self.headerView.model = _userModel;
                self.tableView.tableHeaderView = self.headerView;
               
                if (_userModel == nil) {
                    self.headerView.height = 160;
                }
                 [self.tableView reloadData];
                
            }else{
                _userModel = [RLSMethods getUserModel];
                self.headerView.model = _userModel;
                self.tableView.tableHeaderView = self.headerView;
                [self.tableView reloadData];
            }
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            _userModel = [RLSMethods getUserModel];
            self.headerView.model = _userModel;
            self.tableView.tableHeaderView = self.headerView;
            [self.tableView reloadData];
        }];
        
        
        
        
        
        [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_minemessagecount] Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
            
        } Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                NSString *count = [responseOrignal objectForKey:@"data"];
                NSArray *array = _contentArray[2];
                RLSMineModel *model = array[0];
                model.numbers = count;
                NSIndexPath *index = [NSIndexPath indexPathForItem:0 inSection:2];
                [self.tableView reloadRowAtIndexPath:index withRowAnimation:UITableViewRowAnimationFade];
            }else{
              
            }
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            NSLog(@"11");
        }];
        
        
        [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_vip_index] Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
            
        } Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                self.headerView.dic = responseOrignal[@"data"];
            }
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            self.headerView.dic = nil;
        }];
        
        
        
    } else {
        [self.tableView.mj_header endRefreshing];
        self.headerView.model = nil;
        self.tableView.tableHeaderView = self.headerView;
        if (_userModel == nil) {
            self.headerView.height = 160;
        }
        self.headerView.dic = nil;
        [self.tableView reloadData];
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _contentArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arrar = _contentArray[section];
    return arrar.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *dataArray = _contentArray[indexPath.section];
    RLSMineTableViewCell *cell = [RLSMineTableViewCell cellForTableView:tableView];
    [cell refreshContentData:dataArray[indexPath.row]];
    return cell;
}
#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([view isKindOfClass:[UITableViewHeaderFooterView class]]) {
        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = UIColorHex(#F3F4F6);
    }
}

- (CGFloat)tableView:(  UITableView *)tableView heightForHeaderInSection:( NSInteger )section {
    
    return 10.0 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.10 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RLSMineTableViewCell heightForCell];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            if(![RLSMethods login]) {
                [RLSMethods toLogin];
                return;
            }
            if (indexPath.row == 0) {
                [MobClick event:@"wdzh" label:@""];
                RLSWebModel *model = [[RLSWebModel alloc]init];
                model.title = @"我的账户";
                model.webUrl = [NSString stringWithFormat:@"%@/%@/account.html", APPDELEGATE.url_ip,H5_Host];
                RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
                webDetailVC.model = model;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            } else if (indexPath.row == 1) {
                 [MobClick event:@"wdjc" label:@""];
                 RLSWebModel *model = [[RLSWebModel alloc]init];
                 model.title = @"账户明细";
                 model.webUrl = [NSString stringWithFormat:@"%@/%@/account-details.html", APPDELEGATE.url_ip,H5_Host];
                 RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
                 webDetailVC.model = model;
                 [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            } else if (indexPath.row == 2) {
                RLSWebModel *model = [[RLSWebModel alloc]init];
                model.title = @"购买记录";
                model.webUrl = [NSString stringWithFormat:@"%@/%@/purchase-details.html?id=%zi", APPDELEGATE.url_ip,H5_Host,_userModel.idId];
                RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
                webDetailVC.model = model;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            } else if (indexPath.row == 3) {
                RLSWebModel *model = [[RLSWebModel alloc]init];
                model.title = @"分析师收入";
                model.hideNavigationBar = YES;
                model.webUrl = [NSString stringWithFormat:@"%@/%@/my-earnings.html", APPDELEGATE.url_ip,H5_Host];
                RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
                webDetailVC.model = model;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            } else if (indexPath.row == 4) {
                [MobClick event:@"yhq" label:@""];
                RLSWebModel *model = [[RLSWebModel alloc]init];
                model.title = @"优惠券";
                model.hideNavigationBar = true;
                model.webUrl = [NSString stringWithFormat:@"%@/%@/pay-card.html", APPDELEGATE.url_ip,H5_Host];
                RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
                webDetailVC.model = model;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            }
        }
            break;
        case 1:{
            if (indexPath.row == 0) {
                if(![RLSMethods login]) {
                    [RLSMethods toLogin];
                    return;
                }
                [RLSLodingAnimateView showLodingView];
                [[RLSDependetNetMethods sharedInstance] loadUserInfocompletion:^(RLSUserModel *userback) {
                    [RLSLodingAnimateView dissMissLoadingView];
                    RLSUserModel *model = [RLSMethods getUserModel];
                    RLSToAnalystsVC *analysts = [[RLSToAnalystsVC alloc] init];
                    analysts.hidesBottomBarWhenPushed = YES;
                    analysts.type = model.analyst;
                    analysts.model = model;
                    [APPDELEGATE.customTabbar pushToViewController:analysts animated:YES];
                } errorMessage:^(NSString *msg) {
                    [RLSLodingAnimateView dissMissLoadingView];
                    RLSUserModel *model = [RLSMethods getUserModel];
                    RLSToAnalystsVC *analysts = [[RLSToAnalystsVC alloc] init];
                    analysts.hidesBottomBarWhenPushed = YES;
                    analysts.type = model.analyst;
                    analysts.model = model;
                    [APPDELEGATE.customTabbar pushToViewController:analysts animated:YES];
                }];
                
            } else if (indexPath.row == 1) {
                if(![RLSMethods login]) {
                    [RLSMethods toLogin];
                    return;
                }
                RLSUserTuijianVC *tuijian = [[RLSUserTuijianVC alloc] init];
                tuijian.userName = self.userModel.nickname;
                tuijian.userId =  self.userModel.idId;
                tuijian.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:tuijian animated:YES];
               
            } else if (indexPath.row == 2) {
                if(![RLSMethods login]) {
                    [RLSMethods toLogin];
                    return;
                }
                RLSUserViewController *userVC = [[RLSUserViewController alloc] init];
                userVC.userId = _userModel.idId;
                userVC.hidesBottomBarWhenPushed = YES;
                userVC.Number=1;
                [APPDELEGATE.customTabbar pushToViewController:userVC animated:YES];
            } else if (indexPath.row == 3) {
                RLSWebModel *model = [[RLSWebModel alloc]init];
                model.title = @"滚球服务";
                model.webUrl = [NSString stringWithFormat:@"%@/%@/gunqiu-service.html", APPDELEGATE.url_ip,H5_Host];
                RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
                webDetailVC.model = model;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            }
        }
            break;
        case 2:{
            if (indexPath.row == 0) {
                if(![RLSMethods login]) {
                    [RLSMethods toLogin];
                    return;
                }
                RLSWebModel *model = [[RLSWebModel alloc]init];
                model.title = @"消息";
                model.webUrl = [NSString stringWithFormat:@"https://tok-fungame.github.io/message.html", APPDELEGATE.url_ip,H5_Host];
                RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
                model.hideNavigationBar = YES;
                webDetailVC.model = model;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            } /*else if (indexPath.row == 1) {
                [MobClick event:@"yqhy" label:@""];
                RLSWebModel *model = [[RLSWebModel alloc]init];
                model.title = @"邀请好友";
                model.webUrl = [NSString stringWithFormat:@"%@/%@/invite-friends.html", APPDELEGATE.url_ip,H5_Host];
                RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
                webDetailVC.model = model;
                [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
            } else if (indexPath.row == 2) {
                RLSFeedbackVC *feed = [[RLSFeedbackVC alloc] init];
                feed.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:feed animated:YES];
            }*/ else if (indexPath.row == 1) {
                RLSSettingVC *setVC = [[RLSSettingVC alloc] init];
                setVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:setVC animated:YES];
            }
        }
            break;
        default:
            break;
    }
}
#pragma mark - Lazy Load
- (RLSBasicTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[RLSBasicTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.defaultPage = defaultPageFirst;
        _tableView.defaultTitle = default_isLoading;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 10;
        _tableView.backgroundColor = UIColorHex(#f5f5f5);
        _tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
}
- (RLSMineHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[RLSMineHeaderView alloc]initWithFrame:CGRectMake(0, 0, Width, 160)];
    }
    return _headerView;
}
@end
