#import "RLSChangePhoneNumVC.h"
#import "RLSUserModel.h"
#import "RLSJKCountDownButton.h"
#import "RLSSuccessfulView.h"
@interface RLSChangePhoneNumVC ()
@property (nonatomic, strong)UILabel *labPhoneNum;
@property (nonatomic, strong)UIView *bkView;
@property (nonatomic, strong)UITextField *txtOldNum;
@property (nonatomic, strong)UITextField *txtNewNum;
@property (nonatomic, strong)UITextField *txtSourNum;
@property (nonatomic, strong)UILabel *labOld;
@property (nonatomic, strong)UILabel *labNew;
@property (nonatomic, strong)UILabel *labSore;
@property (nonatomic, strong)RLSJKCountDownButton *btn;
@property (nonatomic, strong)RLSUserModel *model;
@property (nonatomic, strong)RLSSuccessfulView *succView;
@property (nonatomic, strong)RLSNavView *nav;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)UIButton *sureBtn;
@end
@implementation RLSChangePhoneNumVC
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = colorTableViewBackgroundColor;
    _model = [RLSMethods getUserModel];
    [self setNavView];
    [self.view addSubview:self.succView];
    self.succView.hidden = YES;
    [self.view addSubview:self.labPhoneNum];
    [self.view addSubview:self.bkView];
    [self.bkView addSubview:self.labOld];
    [self.bkView addSubview:self.labNew];
    [self.bkView addSubview:self.labSore];
    [self.bkView addSubview:self.txtOldNum];
    [self.bkView addSubview:self.txtNewNum];
    [self.bkView addSubview:self.txtSourNum];
    [self.bkView addSubview:self.btn];
    [self setAotView];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark -- setnavView
- (void)setNavView{
    _nav = [[RLSNavView alloc] init];
    _nav.delegate = self;
    if (_model.mobile.length > 0) {
        _nav.labTitle.text = @"修改绑定手机";
    }else{
        _nav.labTitle.text = @"绑定手机";
    }
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    _nav.btnRight.hidden = YES;
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.frame = CGRectMake(Width - 10 - 60, APPDELEGATE.customTabbar.height_myStateBar, 60, APPDELEGATE.customTabbar.height_myNavigationBar -APPDELEGATE.customTabbar.height_myStateBar);
    [_sureBtn setTitle:@"修改绑定" forState:UIControlStateNormal];
    [_sureBtn setTitle:@"修改绑定" forState:UIControlStateHighlighted];
    _sureBtn.titleLabel.font  = font14;
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(sureBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    [_nav addSubview:_sureBtn];
    [self.view addSubview:_nav];
}
- (void)sureBtnCilck{
    self.txtOldNum.text = [self.txtOldNum.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.txtSourNum.text = [self.txtSourNum.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (isNUll(self.txtNewNum.text )|| isNUll(self.txtOldNum.text) || isNUll(self.txtSourNum.text)) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"应填项不能为空"];
        return;
    }
    if (self.txtOldNum.text.length != 11 || ![RLSMethods isMobileNumber:self.txtOldNum.text]) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"旧手机号有误"];
        return;
    }
    if (self.txtNewNum.text.length != 11 || ![RLSMethods isMobileNumber:self.txtNewNum.text]) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"新手机号有误"];
        return;
    }
    if ([self.txtNewNum.text isEqualToString:self.txtOldNum.text]) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"旧手机号和新手机号一样"];
        return;
    }
    [self ConfireBtnRequest];
}
- (RLSSuccessfulView *)succView{
    if (!_succView) {
        _succView = [[RLSSuccessfulView alloc] initWithFrame:CGRectMake(0,APPDELEGATE.customTabbar.height_myNavigationBar + 10, Width, 200)];
        _succView.img.image = [UIImage imageNamed:@"successful"];
        _succView.labSucc.text = @"新手机号绑定成功";
        _succView.labContent.text = @"3秒后返回安全中心";
    }
    return _succView;
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [_timer invalidate];
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
    }
}
- (void)ConfireBtnRequest
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter] ];
    if (_model.mobile.length == 0) {
        [parameter setObject:@"11" forKey:@"flag"];
        [parameter setObject:self.txtNewNum.text forKey:@"mobile"];
        [parameter setObject:self.txtSourNum.text forKey:@"authCode"];
    }else{
        [parameter setObject:@"8" forKey:@"flag"];
        [parameter setObject:self.txtOldNum.text forKey:@"oldmobile"];
        [parameter setObject:self.txtNewNum.text forKey:@"newmobile"];
        [parameter setObject:self.txtSourNum.text forKey:@"authCode"];
    }
    [parameter setObject:@"1" forKey:@"platform"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"] forKey:@"uuid"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(delayMethod) userInfo:nil repeats:NO];
            RLSUserModel *model = [RLSMethods getUserModel];
            model.mobile = self.txtNewNum.text;
            [RLSMethods updateUsetModel:model];
            self.labPhoneNum.hidden = YES;
            self.bkView.hidden = YES;
            self.succView.hidden = NO;
            [_sureBtn setTitle:@"" forState:UIControlStateNormal];
            _sureBtn.enabled = NO;
            [[NSUserDefaults standardUserDefaults]setObject:self.txtNewNum.text forKey:@"telTextF"];
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
- (void)delayMethod{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIView *)bkView{
    if (!_bkView) {
        _bkView = [[UIView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44, Width, 44 * 3 + 2)];
        _bkView.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, Width, 0.5)];
        lineView.backgroundColor = colorCellLine;
        [_bkView addSubview:lineView];
        UIView *lineViewTow = [[UIView alloc] initWithFrame:CGRectMake(0, 89, Width, 0.5)];
        lineViewTow.backgroundColor = colorCellLine;
        [_bkView addSubview:lineViewTow];
    }
    return _bkView;
}
- (UILabel *)labPhoneNum{
    if (!_labPhoneNum) {
        _labPhoneNum = [[UILabel alloc] init];
        _labPhoneNum.font = font14;
        _labPhoneNum.textColor = color66;
        NSString *telMM = [_model.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        _labPhoneNum.text = [NSString stringWithFormat:@"当前已绑定手机号%@",telMM];
    }
    return _labPhoneNum;
}
- (UILabel *)labOld{
    if (!_labOld) {
        _labOld = [[UILabel alloc] init];
        _labOld.textColor = color66;
        _labOld.font = font14;
        _labOld.text = @"旧手机号  ";
    }
    return _labOld;
}
- (UILabel *)labNew{
    if (!_labNew) {
        _labNew = [[UILabel alloc] init];
        _labNew.font = font14;
        _labNew.textColor = color66;
        _labNew.text = @"新手机号  ";
    }
    return _labNew;
}
- (UILabel *)labSore{
    if (!_labSore) {
        _labSore = [[UILabel alloc] init];
        _labSore.font = font14;
        _labSore.text = @"验证码   ";
        _labSore.textColor = color66;
    }
    return _labSore;
}
- (UITextField *)txtOldNum{
    if (!_txtOldNum) {
        _txtOldNum = [[UITextField alloc] init];
        _txtOldNum.font = font14;
        _txtOldNum.textColor = color33;
        _txtOldNum.placeholder = @"已绑定手机号";
    }
    return _txtOldNum;
}
- (UITextField *)txtNewNum{
    if (!_txtNewNum) {
        _txtNewNum = [[UITextField alloc] init];
        _txtNewNum.font = font14;
        _txtNewNum.textColor = color33;
        if (_model.mobile.length > 0) {
            _txtNewNum.placeholder = @"新修改手机号";
        }else{
            _txtNewNum.placeholder = @"新手机号";
        }
    }
    return _txtNewNum;
}
- (UITextField *)txtSourNum{
    if (!_txtSourNum) {
        _txtSourNum = [[UITextField alloc] init];
        _txtSourNum.font = font14;
        _txtSourNum.textColor = color33;
        _txtSourNum.placeholder = @"请输入验证码";
    }
    return _txtSourNum;
}
- (RLSJKCountDownButton *)btn{
    if (!_btn) {
        _btn = [RLSJKCountDownButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_btn setTitleColor:color33 forState:UIControlStateNormal];
        _btn.titleLabel.font = font14;
        [_btn addTarget:self action:@selector(getCheckCode:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}
- (void)getCheckCode:(RLSJKCountDownButton *)btn
{
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    self.txtNewNum.text = [self.txtNewNum.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (isNUll(self.txtNewNum.text )) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"应填项不能为空"];
        return;
    }
    if (self.txtNewNum.text.length != 11 || ![RLSMethods isMobileNumber:self.txtNewNum.text]) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"新手机号有误"];
        return;
    }
    if ([self.txtNewNum.text isEqualToString:self.txtOldNum.text]) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"旧手机号和新手机号一样"];
        return;
    }
    [self getCheckNumRequest];
    btn.enabled = NO;
    [btn startWithSecond:60];
    [btn didChange:^NSString *(RLSJKCountDownButton *countDownButton, int second) {
        return [NSString stringWithFormat:@"%ds后重发",second];
    }];
    [btn didFinished:^NSString *(RLSJKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        return @"重新获取";
    }];
}
- (void)getCheckNumRequest
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
        [parameter setObject:@"1" forKey:@"flag"];
        [parameter setObject:@"2" forKey:@"type"];
        [parameter setObject:self.txtNewNum.text forKey:@"mobile"];
    [parameter setObject:@"1" forKey:@"platform"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"] forKey:@"uuid"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"验证码已发送"];
        }else{
            [_btn stop];
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
- (void)setAotView{
    if (_model.mobile.length > 0) {
        [self.labPhoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.view.mas_right);
            make.top.mas_offset(APPDELEGATE.customTabbar.height_myNavigationBar);
            make.height.mas_offset(44);
            make.left.mas_equalTo(self.view.mas_left).offset(15);
        }];
        [self.bkView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.view.mas_right);
            make.left.mas_equalTo(self.view.mas_left);
            make.top.mas_equalTo(self.labPhoneNum.mas_bottom);
            make.height.mas_offset(134);
        }];
        [self.labOld mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bkView.mas_left).offset(15);
            make.top.mas_equalTo(self.bkView.mas_top);
            make.height.mas_offset(44);
            make.right.mas_equalTo(self.txtOldNum.mas_left);
            make.width.mas_offset(65);
        }];
        [self.txtOldNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.labOld.mas_right).offset(10);
            make.top.mas_equalTo(self.labOld.mas_top);
            make.height.mas_offset(44);
            make.right.mas_equalTo(self.bkView.mas_right);
        }];
        [self.labNew mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.labOld.mas_left);
            make.right.mas_equalTo(self.labOld.mas_right);
            make.top.mas_equalTo(self.labOld.mas_bottom).offset(1);
            make.height.mas_offset(44);
        }];
        [self.txtNewNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.txtOldNum.mas_right);
            make.left.mas_equalTo(self.txtOldNum.mas_left);
            make.top.mas_equalTo(self.labNew.mas_top);
            make.height.mas_offset(44);
        }];
        [self.labSore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.labNew.mas_left);
            make.right.mas_equalTo(self.labNew.mas_right);
            make.top.mas_equalTo(self.labNew.mas_bottom).offset(1);
            make.height.mas_offset(44);
        }];
        [self.txtSourNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.btn.mas_left);
            make.left.mas_equalTo(self.txtNewNum.mas_left);
            make.top.mas_equalTo(self.labSore.mas_top);
            make.height.mas_offset(44);
        }];
        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.txtSourNum.mas_right);
            make.right.mas_equalTo(self.bkView.mas_right).offset(-15);
            make.top.mas_equalTo(self.labSore.mas_top);
            make.height.mas_offset(44);
            make.width.mas_offset(80);
        }];
    }else{
        [self.bkView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.view.mas_right);
            make.left.mas_equalTo(self.view.mas_left);
            make.top.mas_offset(APPDELEGATE.customTabbar.height_myNavigationBar + 10);
            make.height.mas_offset(89);
        }];
        [self.labNew mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bkView.mas_left).offset(15);
            make.top.mas_equalTo(self.bkView.mas_top);
            make.height.mas_offset(44);
            make.right.mas_equalTo(self.txtOldNum.mas_left);
            make.width.mas_offset(65);
        }];
        [self.txtNewNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.labNew.mas_right).offset(10);
            make.top.mas_equalTo(self.labNew.mas_top);
            make.height.mas_offset(44);
            make.right.mas_equalTo(self.bkView.mas_right);
        }];
        [self.labSore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.labNew.mas_left);
            make.right.mas_equalTo(self.labNew.mas_right);
            make.top.mas_equalTo(self.labNew.mas_bottom).offset(1);
            make.height.mas_offset(44);
        }];
        [self.txtSourNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.btn.mas_left);
            make.left.mas_equalTo(self.txtNewNum.mas_left);
            make.top.mas_equalTo(self.labSore.mas_top);
            make.height.mas_offset(44);
        }];
        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.txtSourNum.mas_right);
            make.right.mas_equalTo(self.bkView.mas_right).offset(-15);
            make.top.mas_equalTo(self.labSore.mas_top);
            make.height.mas_offset(44);
            make.width.mas_offset(80);
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
