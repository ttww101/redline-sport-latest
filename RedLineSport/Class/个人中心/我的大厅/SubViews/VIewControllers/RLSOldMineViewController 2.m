#import "RLSOldMineViewController.h"
#import "RLSNoticePageVC.h"
#import "RLSUsersCell.h"
#import "RLSSettingVC.h"
#import "RLSFriendsVC.h"
#import "RLSAnQuanCenterVC.h"
#import "RLSToAnalystsVC.h"
#import "RLSUserTuijianVC.h"
#import "RLSRealNameCerVC.h"
#import "RLSTongjiVC.h"
#import "RLSFeedbackVC.h"
#import "RLSFeedbackNewVC.h"
#import "RLSMyBuyTuijianVC.h"
#import "RLSToolWebViewController.h"
#define cellMineViewControllerUserCell @"cellMineViewControllerUserCell"
#define cellMineViewController @"cellMineViewController"
@interface RLSOldMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UILabel *labUnreadNum;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RLSUserModel *userModel;
@property (nonatomic, assign) BOOL showBtnRenzheng;
@property (nonatomic, strong) NSString *unreadNoticeCount;
@end
@implementation RLSOldMineViewController
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.translucent = NO;
    if ([RLSMethods login]) {
        if (_labUnreadNum.text == nil || [_labUnreadNum.text isEqualToString:@"0"]) {
            _labUnreadNum.hidden = YES;
        }else{
            _labUnreadNum.hidden = NO;
        }
        _showBtnRenzheng = YES;
        _userModel = [RLSMethods getUserModel];
        [self loadUserInfo];
        [APPDELEGATE.customTabbar loadUreadNotificationNumInMineView];
        [self.tableView reloadData];
    }else{
        _showBtnRenzheng = NO;
        _labUnreadNum.hidden = YES;
        [self.tableView reloadData];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    [self setNavBtn];
    [self setNavView];
    [self.view addSubview:self.tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUnreadLabNum:) name:NotificationupdateUnreadLabNum object:nil];
}
#pragma mark -- setnavView
- (void)setNavView
{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"我的页面";
    nav.labTitle.font = font16;
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@"unread"] forState:UIControlStateNormal];
    if ([RLSMethods login]) {
        _labUnreadNum = [[UILabel alloc] initWithFrame:CGRectMake(nav.btnRight.width - 6 - 15, 5, 15, 15)];
        _labUnreadNum.font = font11;
        _labUnreadNum.adjustsFontSizeToFitWidth = YES;
        _labUnreadNum.textAlignment = NSTextAlignmentCenter;
        _labUnreadNum.textColor = [UIColor redColor];
        _labUnreadNum.backgroundColor = [UIColor whiteColor];
        _labUnreadNum.layer.cornerRadius = 15/2;
        _labUnreadNum.layer.masksToBounds = YES;
        _labUnreadNum.text = _unreadNoticeCount;
        if ([_unreadNoticeCount integerValue] > 9) {
            _labUnreadNum.frame = CGRectMake(nav.btnRight.width - 26, 5, 20, 15);
        }else if([_unreadNoticeCount integerValue] > 99){
            _labUnreadNum.frame = CGRectMake(nav.btnRight.width - 31, 5, 25, 15);
        }
        _labUnreadNum.layer.borderColor = [UIColor whiteColor].CGColor;
        _labUnreadNum.layer.borderWidth = 1.0;
        if (_labUnreadNum.text == nil || [_labUnreadNum.text isEqualToString:@"0"]) {
            _labUnreadNum.hidden = YES;
        }else{
            _labUnreadNum.hidden = NO;
        }
        [nav.btnRight addSubview:_labUnreadNum];
    }
    [nav.btnRight addTarget:self action:@selector(rightBarButtonItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
    }else if(index == 2){
    }
}
- (void)updateUnreadLabNum:(NSNotification *)notification
{
    if ([RLSMethods login]) {
        if ([[notification.userInfo objectForKey:@"unreadNoticeCount"] integerValue]>0) {
            _labUnreadNum.hidden = NO;
            _unreadNoticeCount = [NSString stringWithFormat:@"%@", [notification.userInfo objectForKey:@"unreadNoticeCount"] ];
            _labUnreadNum.text = _unreadNoticeCount;
        }else{
            _labUnreadNum.hidden = YES;
        }
    }else{
        _labUnreadNum.hidden = YES;
    }
}
- (void)setNavBtn
{
    if (_showBack) {
        UIImage *imageleft = [UIImage imageNamed:@"back"];
        UIImage *image = [imageleft imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItem)];
    }
}
- (void)leftBarButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightBarButtonItem
{
    if ([RLSMethods login]) {
        RLSNoticePageVC *noticeVC = [[RLSNoticePageVC alloc] init];
        noticeVC.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:noticeVC animated:YES];
    }else{
        [RLSMethods toLogin];
    }
}
#pragma mark -- UITableViewDataSource
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 45) style:UITableViewStyleGrouped]; 
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellMineViewController];
        [_tableView registerClass:[RLSUsersCell class] forCellReuseIdentifier:cellMineViewControllerUserCell];
        _tableView.backgroundColor = colorE3;
        _tableView.delegate =self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView.mj_header endRefreshing];
        if ([RLSMethods login]) {
            [self loadUserInfo];
        }
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
    }else if (section == 1){
    } else{
        return [UIView new];
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 0.001;
        }
            break;
        case 1:
        {
            if (![RLSMethods login]) {
                return 0.001;
            }
            return 0.001;
        }
            break;
        case 2:
        {
            return 10;
        }
            break;
        case 3:
        {
            return 10;
        }
            break;
        default:
            break;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        if (_userModel.autonym == 0) {
            if (_showBtnRenzheng) {
                UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
                footer.backgroundColor = colorFFFFDF;
                UILabel *title = [[UILabel alloc] init];
                title.font = font14;
                title.textColor = colorFF9900;
                title.text = @"为了您的账户安全，请立即 ";
                [footer addSubview:title];
                [title mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(footer.mas_left).offset(15);
                    make.centerY.equalTo(footer.mas_centerY);
                }];
                UIButton *title1 = [ UIButton buttonWithType:UIButtonTypeCustom];
                title1.titleLabel.font = font14;
                title1.titleLabel.textColor = colorFF9900;
                [title1 setTitleColor:colorFF9900 forState:UIControlStateNormal];
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"实名认证"];
                NSRange strRange = {0,[str length]};
                [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
                [title1 setAttributedTitle:str forState:UIControlStateNormal];
                [title1 addTarget:self action:@selector(renzheng) forControlEvents:UIControlEventTouchUpInside];
                [footer addSubview:title1];
                [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(title.mas_right).offset(5);
                    make.centerY.equalTo(footer.mas_centerY);
                }];
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(footer.width - 30, 0, 30, 30);
                [btn setBackgroundImage:[UIImage imageNamed:@"XX"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(cancelRenzhen:) forControlEvents:UIControlEventTouchUpInside];
                [footer addSubview:btn];
                return footer;
            }else{
                return [UIView new];
            }
        }
        else{
            return [UIView new];
        }
    }else{
        return [UIView new];
    }
}
- (void)btnMoneyClick
{
    NSString *strTitle = @"提款申请请联系官方客服";
    NSString *str_content = @"QQ:2811132884\n工作日：周一至周五 10：00-18：00";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:strTitle message:str_content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertTwo = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:alertTwo];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)renzheng
{
    RLSRealNameCerVC *real = [[RLSRealNameCerVC alloc] init];
    real.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:real animated:YES];
}
- (void)cancelRenzhen:(UIButton *)btn
{
    _showBtnRenzheng = NO;
    [self.tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        if (_userModel.autonym == 0) {
            if (_showBtnRenzheng) {
                return 30;
            }
        }
        return 10;
    }else{
        return 0.0000001;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 2; 
            break;
        case 3:
            return 2; 
            break;
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
                return [tableView fd_heightForCellWithIdentifier:cellMineViewControllerUserCell configuration:^(RLSUsersCell* cell) {
                    cell.model = _userModel;
                }];
        }
            break;
        case 1:
        {
            if (![RLSMethods login]) {
                return 0;
            }
            return 44;
        }
            break;
        case 2:
            return 44;
            break;
        case 3:
            return 44;
            break;
        default:
            break;
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
            RLSUsersCell *cell = [tableView dequeueReusableCellWithIdentifier:cellMineViewControllerUserCell];
            if (!cell) {
                cell = [[RLSUsersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellMineViewControllerUserCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = _userModel;
            return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellMineViewController];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellMineViewController];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            while ([cell.contentView.subviews lastObject]!= nil) {
                [[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        cell.contentView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [cell.contentView addSubview:imageLeft];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, Width - 44, 44)];
        lab.textColor = color33;
        lab.font = font14;
        [cell.contentView addSubview:lab];
        UIImageView *imageMore = [[UIImageView alloc] initWithFrame:CGRectMake(Width - 15 - 7, 0, 7, 14)];
        imageMore.center = CGPointMake(imageMore.center.x, lab.center.y);
        imageMore.image = [UIImage imageNamed:@"meRight"];
        [cell.contentView addSubview:imageMore];
        UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(0, 43, Width , 0.5)]; 
        viewline.backgroundColor = colorCellLine;
        [cell.contentView addSubview:viewline];
        switch (indexPath.section) {
            case 1:
            {
                if (![RLSMethods login]) {
                    lab.text = @"";
                    imageLeft.image = [UIImage imageNamed:@""];
                    imageMore.image = [UIImage imageNamed:@""];
                    viewline.backgroundColor = [UIColor clearColor];
                }else{
                    switch (indexPath.row) {
                        case 0:
                        {
                            lab.text = @"推荐记录";
                            imageLeft.image = [UIImage imageNamed:@"tuijianuser1"];
                        }
                            break;
                        case 1:
                        {
                            lab.text = @"推荐统计";
                            imageLeft.image = [UIImage imageNamed:@"tongjiuser1"];
                        }
                            break;
                        case 2:
                        {
                            lab.text = @"购买明细";
                            imageLeft.image = [UIImage imageNamed:@"myBuyUser1"];
                        }
                            break;
                        default:
                            break;
                    }
                }
            }
                break;
            case 2:
            {
                switch (indexPath.row) {
                    case 0:
                    {
                        lab.text = @"申请分析师";
                        imageLeft.image = [UIImage imageNamed:@"myBuyUser1"];
                    }
                        break;
                    case 1:
                    {
                        lab.text = @"安全中心";
                        imageLeft.image = [UIImage imageNamed:@"accountUser1"];
                    }
                        break;
                    default:
                        break;
                }
            }
                break;
            case 3:
            {
                switch (indexPath.row) {
                    case 0: 
                    {
                        lab.text = @"意见反馈";
                        imageLeft.image = [UIImage imageNamed:@"suggestionUser1"];
                    }
                        break;
                    case 1: 
                    {
                        lab.text = @"更多设置";
                        imageLeft.image = [UIImage imageNamed:@"moreUser1"];
                        viewline.backgroundColor = [UIColor clearColor];
                    }
                        break;
                    default:
                        break;
                }
            }
                break;
            default:
                break;
        }
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if(![RLSMethods login]) {
                [RLSMethods toLogin];
                return;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    if(![RLSMethods login]) {
                        [RLSMethods toLogin];
                        return;
                    }else{
                        RLSUserTuijianVC *tuijian = [[RLSUserTuijianVC alloc] init];
                        tuijian.userName = _userModel.nickname;
                        tuijian.userId = _userModel.idId;
                        tuijian.hidesBottomBarWhenPushed = YES;
                        [APPDELEGATE.customTabbar pushToViewController:tuijian animated:YES];
                    }
                }
                    break;
                case 1:
                {
                    if(![RLSMethods login]) {
                        [RLSMethods toLogin];
                        return;
                    }
                    RLSUserViewController *userVC = [[RLSUserViewController alloc] init];
                    userVC.userId = _userModel.idId;
                    userVC.hidesBottomBarWhenPushed = YES;
                    userVC.Number=1;
                    [APPDELEGATE.customTabbar pushToViewController:userVC animated:YES];
                }
                    break;
                case 2:
                {
                    if(![RLSMethods login]) {
                        [RLSMethods toLogin];
                        return;
                    }
                    RLSWebModel *model = [[RLSWebModel alloc]init];
                    model.title = @"购买记录";
                    model.webUrl = [NSString stringWithFormat:@"%@/%@/purchase-details.html?id=%zi", APPDELEGATE.url_ip,H5_Host,_userModel.idId];
                    RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
                    webDetailVC.model = model;
                    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
                }
                    break;
                case 3:
                {
                    if(![RLSMethods login]) {
                        [RLSMethods toLogin];
                        return;
                    }
                    RLSUserViewController *userVC = [[RLSUserViewController alloc] init];
                    userVC.userId = _userModel.idId;
                    userVC.hidesBottomBarWhenPushed = YES;
                    userVC.Number=3;
                    [APPDELEGATE.customTabbar pushToViewController:userVC animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    if(![RLSMethods login]) {
                        [RLSMethods toLogin];
                        return;
                    }
                    [[RLSDependetNetMethods sharedInstance] loadUserInfocompletion:^(RLSUserModel *userback) {
                        RLSUserModel *model = [RLSMethods getUserModel];
                        RLSToAnalystsVC *analysts = [[RLSToAnalystsVC alloc] init];
                        analysts.hidesBottomBarWhenPushed = YES;
                        analysts.type = model.analyst;
                        analysts.model = model;
                        [APPDELEGATE.customTabbar pushToViewController:analysts animated:YES];
                    } errorMessage:^(NSString *msg) {
                        RLSUserModel *model = [RLSMethods getUserModel];
                        RLSToAnalystsVC *analysts = [[RLSToAnalystsVC alloc] init];
                        analysts.hidesBottomBarWhenPushed = YES;
                        analysts.type = model.analyst;
                        analysts.model = model;
                        [APPDELEGATE.customTabbar pushToViewController:analysts animated:YES];
                    }];
                }
                    break;
                case 1:
                {
                    if(![RLSMethods login]) {
                        [RLSMethods toLogin];
                        return;
                    }
                    RLSUserModel *model = [RLSMethods getUserModel];
                    RLSAnQuanCenterVC *anquanVc = [[RLSAnQuanCenterVC alloc] init];
                    anquanVc.hidesBottomBarWhenPushed = YES;
                    anquanVc.model = model;
                    [APPDELEGATE.customTabbar pushToViewController:anquanVc animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            switch (indexPath.row) {
                case 0: 
                {
                    RLSFeedbackVC *feed = [[RLSFeedbackVC alloc] init];
                    feed.hidesBottomBarWhenPushed = YES;
                    [APPDELEGATE.customTabbar pushToViewController:feed animated:YES];
                }
                    break;
                case 1: 
                {
                    RLSSettingVC *setVC = [[RLSSettingVC alloc] init];
                    setVC.hidesBottomBarWhenPushed = YES;
                    [APPDELEGATE.customTabbar pushToViewController:setVC animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}
- (void)loadUserInfo
{
    _userModel = [RLSMethods getUserModel];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)_userModel.idId] forKey:@"id"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_userinfo] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        NSLog(@"%@",responseOrignal);
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _userModel = [RLSUserModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            [RLSMethods updateUsetModel:_userModel];
            [self.tableView reloadData];
        }else{
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
