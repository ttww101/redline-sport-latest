#import "RLSSettingVC.h"
#import "RLSFeedbackVC.h"
#import "RLSPushSettingVC.h"
#import "RLSAnQuanCenterVC.h"
#import "ArchiveFile.h"
@interface RLSSettingVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISwitch *switchBtn;
@end
@implementation RLSSettingVC
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
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
    [self setNavView];
    [self.view addSubview:self.tableView];
}
#pragma mark -- setnavView
- (void)setNavView
{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"更多设置";
    nav.labTitle.font = font14;
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
    }
}
#pragma mark -- UITableViewDataSource
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.backgroundColor = colorTableViewBackgroundColor;
        _tableView.delegate =self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 3;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
            break;
        default:
            break;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 1) {
        return 44;
    }else{
        if (![RLSMethods login]) {
            return  106;
        }
        return 160;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        while ([cell.contentView.subviews lastObject]!= nil) {
            [[cell.contentView.subviews lastObject] removeFromSuperview];
        }
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, Width - 40, 44)];
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
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 0:
                {
                    lab.text = @"账户与安全";
                }
                    break;
                case 1:
                {
                    lab.text = @"推送设置";
                }
                    break;
                case 2: {
                    lab.text = @"清除缓存";
                    UILabel *sizeLab = [[UILabel alloc] init];
                    sizeLab.text = [self getCashesSize];
                    sizeLab.font = font12;
                    sizeLab.textColor = color99;
                    [cell.contentView addSubview:sizeLab];
                    [sizeLab mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.equalTo(cell.contentView);
                        make.trailing.equalTo(imageMore.mas_leading).offset(-15);
                    }];
                }
                default:
                    break;
            }
        }/*else if (indexPath.section == 1){
            switch (indexPath.row) {
                case 0:
                {
                    lab.text = @"用户服务协议";
                }
                    break;
                case 1:
                {
                    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
                    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
                    lab.text = [NSString stringWithFormat:@"关于滚球体育(%@)",currentVersion];
                    viewline.backgroundColor = [UIColor clearColor];
                }
                    break;
                default:
                    break;
            }
        }*/else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            while ([cell.contentView.subviews lastObject]!= nil) {
                [[cell.contentView.subviews lastObject] removeFromSuperview];
            }
            UIView *basiceV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 160)];
            basiceV.backgroundColor = colorTableViewBackgroundColor;
            [cell.contentView addSubview:basiceV];
            UIButton *btnLogout = [UIButton buttonWithType:UIButtonTypeCustom];
            btnLogout.frame = CGRectMake(65, 90, Width - 130, 44);
            btnLogout.backgroundColor = redcolor;
            btnLogout.layer.cornerRadius = 3;
            btnLogout.layer.masksToBounds = YES;
            btnLogout.titleLabel.font = font16;
            [btnLogout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnLogout setTitle:@"退出登录" forState:UIControlStateNormal];
            [btnLogout addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
            [basiceV addSubview:btnLogout];
            if (![RLSMethods login]) {
                btnLogout.frame = CGRectMake(15, 0, Width - 30, 0);
            }
            return cell;
        }
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
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
            case 1:
            {
                if (![RLSMethods login]) {
                    [RLSMethods toLogin];
                    return;
                }
                RLSPushSettingVC *pushSetVC = [[RLSPushSettingVC alloc] init];
                pushSetVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:pushSetVC animated:YES];
            }
                break;
            case 2: {
                [self putBuffer];
            }
            default:
                break;
        }
    }/*else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
            {
                RLSWKWebViewController *webVC = [[RLSWKWebViewController alloc] init];
                webVC.strurl = [NSString stringWithFormat:@"%@/help/agreement.html",APPDELEGATE.url_ServerAgreement];
                webVC.strtitle = @"用户服务协议";
                webVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:webVC animated:YES];
            }
                break;
            case 1:
            {
                RLSWKWebViewController *webVC = [[RLSWKWebViewController alloc] init];
                webVC.strurl = [NSString stringWithFormat:@"%@/notice/about.html",APPDELEGATE.url_ServerWWW];
                webVC.strtitle = @"关于滚球体育";
                webVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:webVC animated:YES];
            }
                break;
            default:
                break;
        }
    }*/
}
- (void)loginOut
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:@"确定退出当前账号吗"];
    [hogan addAttribute:NSFontAttributeName value:font16 range:NSMakeRange(0, [[hogan string] length])];
    [hogan addAttribute:NSForegroundColorAttributeName value:color33 range:NSMakeRange(0, [[hogan string] length])];
    [alertController setValue:hogan forKey:@"attributedTitle"];
    UIAlertAction *alertOne = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"login"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOpenMainTableBarTimer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"close",@"timer", nil]];
        [self.navigationController popViewControllerAnimated:YES];
        RLSTokenModel *tokenModel = [RLSMethods getTokenModel];
        tokenModel.token = @"";
        tokenModel.refreshToken = @"";
        [RLSMethods updateTokentModel:tokenModel];
        [[NSUserDefaults standardUserDefaults] setDouble:[@"0" doubleValue] forKey:@"refreshTokentime"];
        [[NSUserDefaults standardUserDefaults] setDouble:[@"0" doubleValue] forKey:@"OutOfRefreshTokenTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    [alertOne setValue:color33 forKey:@"_titleTextColor"];
    UIAlertAction *alertTwo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertTwo setValue:color33 forKey:@"_titleTextColor"];
    [alertController addAction:alertTwo];
    [alertController addAction:alertOne];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)putBuffer
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"决定清除所有缓存吗？" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        [self.tableView reloadData];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:action];
    [alert addAction:cancel];
    [self showDetailViewController:alert sender:nil];
}
- (NSString *)getCashesSize {
    CGFloat size = [[SDImageCache sharedImageCache] getSize];
    NSString *message = @"";
    if (size > (1024 * 1024))
    {
        size = size / (1024 * 1024);
        message = [NSString stringWithFormat:@"%.1fM", size];
    }
    else if (size > 1024)
    {
        size = size / 1024;
        message = [NSString stringWithFormat:@"%.1fKB", size];
    }else{
        message = [NSString stringWithFormat:@"%.1fB", size];
    }
    return message;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
