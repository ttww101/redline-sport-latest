#import "RLSBangAccountVC.h"
#import "RLSChangePhoneNumVC.h"
typedef NS_ENUM(NSInteger,BangClickType){
    ClickTypeQQ = 0,
    ClickTypeWeiXin = 1,
    ClickTypeSina = 2
};
@interface RLSBangAccountVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) MBProgressHUD *prograssHud;
@property (nonatomic, strong) UILabel *rightLabsj;
@property (nonatomic, strong) UILabel *rightLabqq;
@property (nonatomic, strong) UILabel *rightLabweixin;
@property (nonatomic, strong) UILabel *rightLabweibo;
@property (nonatomic, assign) BangClickType     bangCTyoe;
@end
@implementation RLSBangAccountVC
- (void)viewWillAppear:(BOOL)animated{
    _model = [RLSMethods getUserModel];
    [self isAccountBang];
    [self.tableView reloadData];
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
    [self.view addSubview:self.tableView];
}
#pragma mark -- setnavView
- (void)setNavView{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"账户绑定";
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
- (UITableView *)tableView {
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 80;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 80)];
        footerView.backgroundColor = colorTableViewBackgroundColor;
        UILabel *textLab = [[UILabel alloc] init];
        textLab.text = @"";
        textLab.font = font13;
        textLab.textColor = colorf86868;
        [footerView addSubview:textLab];
        [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(footerView.mas_top).offset(30);
            make.centerX.equalTo(footerView.mas_centerX);
        }];
        return footerView;
    }
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    while ([cell.contentView.subviews lastObject]!= nil) {
        [[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, Width - 40, 44)];
    lab.textColor = color33;
    lab.font = font16;
    [cell.contentView addSubview:lab];
    UIImageView *imageMore = [[UIImageView alloc] initWithFrame:CGRectMake(Width - 15 - 7, 0, 7, 14)];
    imageMore.center = CGPointMake(imageMore.center.x, lab.center.y);
    imageMore.image = [UIImage imageNamed:@"meRight"];
    [cell.contentView addSubview:imageMore];
    UIImageView *leftImage = [[UIImageView alloc] init];
    [cell.contentView addSubview:leftImage];
    [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.leading.equalTo(cell.contentView.mas_leading).offset(15);
    }];
    UILabel *labLeft = [[UILabel alloc] init];
    labLeft.font = font13;
    labLeft.textAlignment = NSTextAlignmentLeft;
    [cell.contentView addSubview:labLeft];
    [labLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(leftImage.mas_trailing).offset(10);
        make.centerY.equalTo(cell.contentView.mas_centerY);
    }];
    UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(0, 43, Width , 0.5)];
    viewline.backgroundColor = colorCellLine;
    [cell.contentView addSubview:viewline];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                leftImage.image = [UIImage imageNamed:@"shouji"];
                labLeft.text = @"绑定手机";
                self.rightLabsj = [[UILabel alloc] init];
                self.rightLabsj.text = @"未绑定";
                self.rightLabsj.font = font13;
                self.rightLabsj.textColor = colorf86868;
                self.rightLabsj.textAlignment = NSTextAlignmentRight;
                [cell.contentView addSubview:self.rightLabsj];
                [self.rightLabsj mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.trailing.equalTo(imageMore.mas_leading).offset(-10);
                    make.centerY.equalTo(imageMore.mas_centerY);
                }];
                if (_model.mobile.length > 0) {
                    imageMore.hidden = YES;
                    self.rightLabsj.text = _model.mobile;
                    [self.rightLabsj mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.trailing.equalTo(cell.contentView.mas_trailing).offset(-15);
                        make.centerY.equalTo(imageMore.mas_centerY);
                    }];
                }
            }
                break;
            default:
                break;
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                RLSChangePhoneNumVC *phoneVC = [[RLSChangePhoneNumVC alloc] init];
                phoneVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:phoneVC animated:YES];
            }
                break;
            default:
                break;
        }
    }
}
- (void)isAccountBang {
    NSMutableDictionary *dictParameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:dictParameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_hasAccountBanged] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            if ([[[responseOrignal objectForKey:@"data"] objectForKey:@"qq"] intValue] == 1) {
                self.rightLabqq.text = @"已绑定";
            }else{
                self.rightLabqq.text = @"未绑定";
            }
            if ([[[responseOrignal objectForKey:@"data"] objectForKey:@"wechat"] intValue] == 1) {
                self.rightLabweixin.text = @"已绑定";
            }else{
                self.rightLabweixin.text = @"未绑定";
            }
            if ([[[responseOrignal objectForKey:@"data"] objectForKey:@"weibo"] intValue] == 1) {
                self.rightLabweibo.text = @"已绑定";
            }else{
                self.rightLabweibo.text = @"未绑定";
            }
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
    }];
}
- (void)bangAccountWithUserName:(NSString *)username nickName:(NSString *)nickname resource:(NSString *)resource
{
    [self.view endEditing:YES];
    NSMutableDictionary *dictParameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    if (!isNUll(username)) {
        [dictParameter setObject:username forKey:@"username"];
    }
    if (!isNUll(nickname)) {
        [dictParameter setObject:nickname forKey:@"nickname"];
    }
    if (!isNUll(resource)) {
        [dictParameter setObject:resource forKey:@"resource"];
    }
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:dictParameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_bang_Account] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            [self isAccountBang];
            [self.tableView reloadData];
        }
        [SVProgressHUD showInfoWithStatus:[responseOrignal objectForKey:@"msg"]];
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showInfoWithStatus:errorDict];
    }];
}
@end
