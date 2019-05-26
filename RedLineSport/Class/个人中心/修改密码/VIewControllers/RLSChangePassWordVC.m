#import "RLSChangePassWordVC.h"
@interface RLSChangePassWordVC ()
@property (nonatomic, strong)UIView *bkView;
@property (nonatomic, strong)UITextField *txtOldNum;
@property (nonatomic, strong)UITextField *txtNewNum;
@property (nonatomic, strong)UITextField *txtSourNum;
@property (nonatomic, strong)UILabel *labOld;
@property (nonatomic, strong)UILabel *labNew;
@property (nonatomic, strong)UILabel *labSore;
@end
@implementation RLSChangePassWordVC
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = colorTableViewBackgroundColor;
    [self setNavView];
    [self.view addSubview:self.bkView];
    [self.bkView addSubview:self.labOld];
    [self.bkView addSubview:self.labNew];
    [self.bkView addSubview:self.labSore];
    [self.bkView addSubview:self.txtOldNum];
    [self.bkView addSubview:self.txtNewNum];
    [self.bkView addSubview:self.txtSourNum];
    [self setAotView];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark -- setnavView
- (void)setNavView{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"修改密码";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setTitle:@"确认 " forState:UIControlStateNormal];
    [nav.btnRight setTitle:@"确认 " forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.5];
        self.txtOldNum.text = [self.txtOldNum.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.txtNewNum.text = [self.txtNewNum.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.txtSourNum.text = [self.txtSourNum.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (isNUll(self.txtOldNum.text)|| isNUll(self.txtNewNum.text) || isNUll(self.txtSourNum.text)) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"应填项不能为空"];
            return;
        }
        if (self.txtOldNum.text.length == 0) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入原密码"];
            return;
        }
        if (self.txtOldNum.text.length<6 || self.txtOldNum.text.length>16) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入6~16位的原密码"];
            return;
        }
        if (self.txtNewNum.text.length == 0) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入新密码"];
            return;
        }
        if (self.txtNewNum.text.length<6 || self.txtNewNum.text.length>16) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入6~16位的新密码"];
            return;
        }
        if ([self.txtOldNum.text isEqualToString:self.txtNewNum.text]) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"新密码与原密码相同"];
            return;
        }
        if (![self.txtSourNum.text isEqualToString:self.txtNewNum.text]) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"两次输入的密码不一致"];
            return;
        }
        [self ConfireBtnRequest];
    }
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
- (UILabel *)labOld{
    if (!_labOld) {
        _labOld = [[UILabel alloc] init];
        _labOld.textColor = color66;
        _labOld.font = font14;
        _labOld.text = @"旧密码  ";
    }
    return _labOld;
}
- (UILabel *)labNew{
    if (!_labNew) {
        _labNew = [[UILabel alloc] init];
        _labNew.font = font14;
        _labNew.textColor = color66;
        _labNew.text = @"新密码  ";
    }
    return _labNew;
}
- (UILabel *)labSore{
    if (!_labSore) {
        _labSore = [[UILabel alloc] init];
        _labSore.font = font14;
        _labSore.text = @"重新输入 ";
        _labSore.textColor = color66;
    }
    return _labSore;
}
- (UITextField *)txtOldNum{
    if (!_txtOldNum) {
        _txtOldNum = [[UITextField alloc] init];
        _txtOldNum.font = font14;
        _txtOldNum.textColor = color33;
        _txtOldNum.placeholder = @"请输入原密码";
        _txtOldNum.secureTextEntry = YES;
    }
    return _txtOldNum;
}
- (UITextField *)txtNewNum{
    if (!_txtNewNum) {
        _txtNewNum = [[UITextField alloc] init];
        _txtNewNum.font = font14;
        _txtNewNum.textColor = color33;
        _txtNewNum.placeholder = @"密码由6-20位字母，数组组成";
        _txtNewNum.secureTextEntry = YES;
    }
    return _txtNewNum;
}
- (UITextField *)txtSourNum{
    if (!_txtSourNum) {
        _txtSourNum = [[UITextField alloc] init];
        _txtSourNum.font = font14;
        _txtSourNum.textColor = color33;
        _txtSourNum.placeholder = @"请重新输入密码";
        _txtSourNum.secureTextEntry = YES;
    }
    return _txtSourNum;
}
- (void)ConfireBtnRequest
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter] ];
    [parameter setObject:@"6" forKey:@"flag"];
    [parameter setObject:[RLSMethods md5WithString:self.txtOldNum.text] forKey:@"oldpsw"];
    [parameter setObject:[RLSMethods md5WithString:self.txtNewNum.text] forKey:@"newpsw"];
    [parameter setObject:@"1" forKey:@"platform"];
    [parameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"] forKey:@"uuid"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            [RLSMethods toLogin];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:islogin];
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
- (void)setAotView{
    [self.bkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right);
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_offset(APPDELEGATE.customTabbar.height_myNavigationBar + 10);
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
        make.right.mas_equalTo(self.txtNewNum.mas_right);
        make.left.mas_equalTo(self.txtNewNum.mas_left);
        make.top.mas_equalTo(self.labSore.mas_top);
        make.height.mas_offset(44);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
