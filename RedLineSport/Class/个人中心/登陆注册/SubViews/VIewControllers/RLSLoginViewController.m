#import "RLSLoginViewController.h"
#import "MBProgressHUD.h"
#import "RLSDCHttpRequest.h"
#import "RLSRegisterViewController.h"
#import "RLSForgetPswViewController.h"
#import "RLSUserModel.h"
#import "RLSBangUserVC.h"
#import <UMPush/UMessage.h>
@interface RLSLoginViewController ()<UITextFieldDelegate>
{
    float _keyboardHeight;
}
@property (nonatomic, strong) UITextField *telTextF;
@property (nonatomic, strong) UITextField *pswTextF;
@property (nonatomic, strong) MBProgressHUD *prograssHud;
@property (nonatomic, strong)UIButton *btnJIZhu;
@property (nonatomic, strong)UIImageView *imageViewTel;
@property (nonatomic, strong)UIImageView *imageViewPsw;
@end
@implementation RLSLoginViewController
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    if ([RLSMethods login]) {
        [self dismiss];
        return;
    }
    _pswTextF.text = nil;
    if (_type == typeLoginNormal) {
        NSInteger b = [[[NSUserDefaults standardUserDefaults]objectForKey:@"passwordBOOL"] integerValue];;
        if (b == 1) {
            _pswTextF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
            _btnJIZhu.selected = YES;
        }
        _telTextF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"telTextF"];
    }
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
    self.view.backgroundColor = grayColor1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordUp:) name:UIKeyboardWillShowNotification object:nil];
    _keyboardHeight = 0;
    [self creatLogin];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark -- setnavView
- (void)setNavView{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"登录";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setTitle:@"注册" forState:UIControlStateNormal];
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }else if(index == 2){
        RLSRegisterViewController *registerVC = [[RLSRegisterViewController alloc]init];
        [self presentViewController:registerVC animated:YES completion:nil];
    }
}
- (void)creatLogin
{
    float space = 20;
    float height = 50;
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 20, 59, 44);
    [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 44, 44)];
    back.image = [UIImage imageNamed:@"back"];
    [cancelBtn addSubview:back];
    UILabel *title = [[UILabel alloc] init];
    title.text = @"登录";
    title.font = font17;
    title.textColor = ColorWithRGBA(64, 64, 64, 1);
    title.frame = CGRectMake(0, 30, 40, 15);
    CGPoint titlePiont = title.center;
    titlePiont.x = self.view.center.x;
    title.center = titlePiont;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, Width, 0.5)];
    lineView.backgroundColor = colorDD;
    [self.view  addSubview:lineView];
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:@"logo测"];
    logoImageView.bounds = CGRectMake(0, 0, 100, 100);
    logoImageView.center = CGPointMake(Width/2, cancelBtn.frame.origin.y + cancelBtn.bounds.size.height + space + logoImageView.bounds.size.height/2);
    logoImageView.layer.cornerRadius = 15;
    logoImageView.clipsToBounds = YES;
    UIView *logView = [[UIView alloc] init];
    logView.frame = CGRectMake(0, lineView.bottom, Width, height *2);
    logView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:logView];
    _imageViewTel = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, height/3, height/3)];
    CGPoint pointImageTel = _imageViewTel.center;
    pointImageTel.y = height/2;
    _imageViewTel.center = pointImageTel;
    _imageViewTel.image = [UIImage imageNamed:@"register2"];
    [logView addSubview:_imageViewTel];
    _telTextF = [[UITextField alloc] initWithFrame:CGRectMake(_imageViewTel.frame.origin.x + _imageViewTel.bounds.size.width + space, _imageViewTel.frame.origin.y, logView.frame.size.width - (_imageViewTel.frame.origin.x + _imageViewTel.bounds.size.width + space), height - 10)];
    CGPoint pointTxtfTel = _telTextF.center;
    pointTxtfTel.y = _imageViewTel.center.y;
    _telTextF.center = pointTxtfTel;
    _telTextF.delegate = self;
    _telTextF.font = font14;
    _telTextF.textColor = color33;
    _telTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _telTextF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"telTextF"];
    [logView addSubview:_telTextF];
    UIView *viewlineH = [[UIView alloc] initWithFrame:CGRectMake(0, 0,Width, 0.5)];
    viewlineH.center = CGPointMake(logView.bounds.size.width/2, height);
    viewlineH.backgroundColor = cellLineColor;
    [logView addSubview:viewlineH];
    _imageViewPsw = [[UIImageView alloc] initWithFrame:CGRectMake(_imageViewTel.frame.origin.x, height + 5, height/3 ,height/3)];
    CGPoint pointImagePsw = _imageViewPsw.center;
    pointImagePsw.y = height + height/2;
    _imageViewPsw.center = pointImagePsw;
    _imageViewPsw.image = [UIImage imageNamed:@"register3"];
    [logView addSubview:_imageViewPsw];
    _pswTextF = [[UITextField alloc] init];
    _pswTextF.frame = CGRectMake(_telTextF.frame.origin.x, _imageViewPsw.frame.origin.y , _telTextF.bounds.size.width - 70, _telTextF.bounds.size.height);
    _pswTextF.center = CGPointMake(_pswTextF.center.x, _imageViewPsw.center.y);
    _pswTextF.font = font14;
    _pswTextF.delegate = self;
    _pswTextF.borderStyle = UITextBorderStyleNone;
    _pswTextF.placeholder = @"请输入密码";
    _pswTextF.textColor = color33;
    _pswTextF.secureTextEntry = YES;
    _pswTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pswTextF.keyboardType = UIKeyboardTypeDefault;
    _pswTextF.clearsOnBeginEditing = YES;
    [logView addSubview:_pswTextF];
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(_pswTextF.frame.origin.x + _pswTextF.frame.size.width, _pswTextF.frame.origin.y +3, 1, height - 16)];
    viewLine.backgroundColor = cellLineColor;
    _btnJIZhu = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnJIZhu.frame = CGRectMake(15, logView.bottom + 15, 18, 18);
    [_btnJIZhu setImage:[UIImage imageNamed:@"wangji"] forState:UIControlStateNormal];
    [_btnJIZhu setImage:[UIImage imageNamed:@"jizhu"] forState:UIControlStateSelected];
    [_btnJIZhu addTarget:self action:@selector(jiZhuPassword:) forControlEvents:UIControlEventTouchUpInside];
    _btnJIZhu.selected = YES;
    [self.view addSubview:_btnJIZhu];
    UILabel *labMima = [[UILabel alloc] initWithFrame:CGRectMake(_btnJIZhu.right + 10, logView.bottom + 16, 60, 15)];
    labMima.text = @"记住密码";
    labMima.textColor = ColorWithRGBA(64, 64, 64, 1);
    labMima.font = font13;
    [self.view addSubview:labMima];
    UIButton *forgetPsw = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPsw.frame = CGRectMake(Width - 80, logView.bottom + 15, 70, 20);
    [forgetPsw setTitle:@"找回密码?" forState:UIControlStateNormal];
    [forgetPsw setTitleColor:color4C8DE5 forState:UIControlStateNormal];
    [forgetPsw.titleLabel setFont: font13];
    [forgetPsw addTarget:self action:@selector(forgetPswBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *loginbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginbtn.bounds = CGRectMake(10, 0, logView.bounds.size.width - 20, 40);
    loginbtn.center = CGPointMake(Width/2, logView.frame.origin.y + logView.bounds.size.height + space/2 + height/2 + 50);
    loginbtn.titleLabel.font = font14;
    loginbtn.backgroundColor = redcolor;
    loginbtn.layer.cornerRadius = 3;
    [loginbtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginbtn addTarget:self action:@selector(loginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginbtn];
    if (_type == typeLoginNormal) {
        [self.view addSubview:forgetPsw];
        _telTextF.placeholder = @"请输入手机号/用户名";
        UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        registerBtn.frame = CGRectMake(Width - 80, title.top+2, 80, 15);
        registerBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        registerBtn.titleLabel.font = font14;
        [registerBtn setTitle:@"免费注册" forState:UIControlStateNormal];
        [registerBtn setTitleColor:ColorWithRGBA(252, 68, 72, 1) forState:UIControlStateNormal];
        [registerBtn addTarget:self action:@selector(toRegister) forControlEvents:UIControlEventTouchUpInside];
    }else if (_type == typeLoginThirdParth){
        _telTextF.text = _nickname;
    }
}
- (void)jiZhuPassword:(UIButton *)btn{
    btn.selected = !btn.selected;
    [[NSUserDefaults standardUserDefaults] setObject:@(btn.selected) forKey:@"passwordBOOL"];
    if (btn.selected) {
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"password"];
    }
}
- (void)keybordUp:(NSNotification *)notification
{
    NSValue *value = [notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect rect = [value CGRectValue];
    _keyboardHeight = rect.size.height;
    CGFloat space =Height - (_pswTextF.frame.origin.y + _pswTextF.frame.size.height) - _keyboardHeight;
    if (space < 0) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        self.view.frame = CGRectMake(0, space, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView commitAnimations];
    }
    else
    {
        return;
    }
}
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)forgetPswBtnClick
{
    RLSForgetPswViewController *forgetPswVC = [[RLSForgetPswViewController alloc] init];
    [self presentViewController:forgetPswVC animated:YES completion:nil];
}
- (void)loginBtn
{
    _telTextF.text = [_telTextF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    _pswTextF.text = [_pswTextF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    if (isNUll(self.telTextF.text) || isNUll(self.pswTextF.text)) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"应填项不能为空"];
        return;
    }
    if (_type == typeLoginNormal) {
    }else if (_type == typeLoginThirdParth){
        if (_telTextF.text.length <2 || _telTextF.text.length >8) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入2~8位的字符昵称"];
            return;
        }
    }
    if (_pswTextF.text.length < 6 || _pswTextF.text.length > 16)
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"密码错误"];
        return;
    }
    if (_type == typeLoginNormal) {
        [self login];
    }else if (_type == typeLoginThirdParth){
        [self loginThirdPartWithUserName:_username nickName:_telTextF.text picUrl:_pic resource:_resource password:_pswTextF.text];
    }
}
- (void)login
{
    [self.view endEditing:YES];
    NSMutableDictionary *dictParameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [dictParameter setObject:@"0" forKey:@"flag"];
    [dictParameter setObject:_telTextF.text forKey:@"username"];
    [dictParameter setObject:[RLSMethods md5WithString:_pswTextF.text] forKey:@"password"];
    [dictParameter setObject:@"1" forKey:@"platform"];
    [dictParameter setObject:PARAM_IS_NIL_ERROR([[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"]) forKey:@"uuid"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:dictParameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] ArrayFile:nil Start:^(id requestOrignal) {
        if (!_prograssHud) {
            _prograssHud = [[MBProgressHUD alloc] initWithView:self.view];
        }
        _prograssHud.mode = MBProgressHUDModeIndeterminate;
        _prograssHud.labelText = @"正在登录";
        [_prograssHud show:YES];
        [self.view addSubview:_prograssHud];
    } End:^(id responseOrignal) {
        [_prograssHud hide:YES afterDelay:1];
    } Success:^(id responseResult, id responseOrignal) {
        NSLog(@"登陆成功---%@",responseOrignal);
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _prograssHud.mode = MBProgressHUDModeCustomView;
            _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
            _prograssHud.labelText = @"登录成功";
            [[NSUserDefaults standardUserDefaults] setObject:@(_btnJIZhu.selected) forKey:@"passwordBOOL"];
            if (_btnJIZhu.selected == YES) {
                [[NSUserDefaults standardUserDefaults]setObject:_pswTextF.text forKey:@"password"];
            }else{
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"password"];
            }
            [[NSUserDefaults standardUserDefaults] setObject:_telTextF.text forKey:@"telTextF"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"login"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"thirdPartLogin"];
            [[NSUserDefaults standardUserDefaults] setDouble:([[responseOrignal objectForKey:@"time"] doubleValue] + RequestRefreshTokenTime) forKey:@"refreshTokentime"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            RLSUserModel *model = [RLSUserModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            RLSTokenModel *tokenModel = [RLSTokenModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            [RLSMethods updateTokentModel:tokenModel];
            [RLSMethods updateUsetModel:model];
           
            NSLog(@"NSData                  - %f",[[NSDate date] timeIntervalSince1970]*1000);
            NSLog(@"refreshTokentime        - %f",[[NSUserDefaults standardUserDefaults] doubleForKey:@"refreshTokentime"]);
            NSLog(@"OutOfRefreshTokenTime   - %f",[[NSUserDefaults standardUserDefaults] doubleForKey:@"OutOfRefreshTokenTime"]);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"userLoginNotification" object:nil userInfo:nil];
            [UMessage addAlias:[NSString stringWithFormat:@"GQ%lu",(long)model.idId] type:@"GUN_QIU" response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
            }];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOpenMainTableBarTimer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"open",@"timer", nil]];
            [self connectRongyunWithUserModel:model];
            [_prograssHud hide:YES afterDelay:1];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];
        }else{
            _prograssHud.mode = MBProgressHUDModeCustomView;
            _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong"]];
            _prograssHud.labelText = [responseOrignal objectForKey:@"msg"];
            [_prograssHud hide:YES afterDelay:1];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        _prograssHud.mode = MBProgressHUDModeCustomView;
        _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong"]];
            _prograssHud.labelText = errorDict;
        [_prograssHud hide:YES afterDelay:1];
        NSLog(@"%@",responseOrignal);
    }];
}
- (void)loginThirdPartWithUserName:(NSString *)username nickName:(NSString *)nickname picUrl:(NSString *)pic resource:(NSString *)resource password:(NSString *)password
{
    [self.view endEditing:YES];
    NSMutableDictionary *dictParameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [dictParameter setObject:@"9" forKey:@"flag"];
    [dictParameter setObject:username forKey:@"username"];
    [dictParameter setObject:nickname forKey:@"nickname"];
    [dictParameter setObject:resource forKey:@"resource"];
    [dictParameter setObject:pic forKey:@"pic"];
    [dictParameter setObject:[RLSMethods md5WithString:password] forKey:@"password"];
    [dictParameter setObject:@"1" forKey:@"platform"];
    [dictParameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"] forKey:@"uuid"];
    [dictParameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"] forKey:@"token"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:dictParameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] ArrayFile:nil Start:^(id requestOrignal) {
        if (!_prograssHud) {
            _prograssHud = [[MBProgressHUD alloc] initWithView:self.view];
        }
        _prograssHud.mode = MBProgressHUDModeIndeterminate;
        _prograssHud.labelText = @"正在登录";
        [_prograssHud show:YES];
        [self.view addSubview:_prograssHud];
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            NSLog(@"%@",responseOrignal);
            _prograssHud.mode = MBProgressHUDModeCustomView;
            _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
            _prograssHud.labelText = @"登录成功";
            [[NSUserDefaults standardUserDefaults] setObject:_telTextF.text forKey:@"telTextF"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"login"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"thirdPartLogin"];
            NSString *nowDate = [RLSMethods getDateByStyle:dateStyleFormatter withDate:[NSDate dateWithTimeIntervalSinceNow:3600*24*15]];
            [[NSUserDefaults standardUserDefaults] setObject:nowDate forKey:@"thirdPartLoginDeadline"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            RLSUserModel *model = [RLSUserModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            RLSTokenModel *tokenModel = [RLSTokenModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            [RLSMethods updateTokentModel:tokenModel];
            [RLSMethods updateUsetModel:model];
            [[NSUserDefaults standardUserDefaults] setDouble:([[responseOrignal objectForKey:@"time"] doubleValue] + RequestRefreshTokenTime) forKey:@"refreshTokentime"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOpenMainTableBarTimer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"open",@"timer", nil]];
            [_prograssHud hide:YES afterDelay:1];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];
        }else{
            _prograssHud.mode = MBProgressHUDModeCustomView;
            _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong"]];
            _prograssHud.labelText = [responseOrignal objectForKey:@"msg"];
            [_prograssHud hide:YES afterDelay:1];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        _prograssHud.mode = MBProgressHUDModeCustomView;
        _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong"]];
        _prograssHud.labelText = errorDict;
        [_prograssHud hide:YES afterDelay:1];
        NSLog(@"%@",responseOrignal);
    }];
}
- (void)everRegisterThirdPartLoginWithUsername:(NSString *)username nickName:(NSString *)nickname picUrl:(NSString *)pic resource:(NSString *)resource
{
    [self.view endEditing:YES];
    RLSBangUserVC *bangVC = [RLSBangUserVC new];
    bangVC.nickname = nickname;
    bangVC.username = username;
    bangVC.pic = pic;
    [[NSUserDefaults standardUserDefaults] setObject:nickname forKey:@"bangNickName"];
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"bangUserName"];
    [[NSUserDefaults standardUserDefaults] setObject:pic forKey:@"bangPic"];
    [[NSUserDefaults standardUserDefaults] setObject:resource forKey:@"bangResource"];
    NSMutableDictionary *dictParameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [dictParameter setObject:@"10" forKey:@"flag"];
    [dictParameter setObject:username forKey:@"username"];
    [dictParameter setObject:resource forKey:@"resource"];
    [dictParameter setObject:@"1" forKey:@"platform"];
    [dictParameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"] forKey:@"uuid"];
    [dictParameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"] forKey:@"token"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:dictParameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] ArrayFile:nil Start:^(id requestOrignal) {
        if (!_prograssHud) {
            _prograssHud = [[MBProgressHUD alloc] initWithView:self.view];
        }
        _prograssHud.mode = MBProgressHUDModeIndeterminate;
        _prograssHud.labelText = @"正在登陆";
        [_prograssHud show:YES];
        [self.view addSubview:_prograssHud];
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            if ([[responseOrignal objectForKey:@"data"] isKindOfClass:[NSDictionary class]] ) {
                _prograssHud.mode = MBProgressHUDModeCustomView;
                _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
                _prograssHud.labelText = @"登录成功";
                [[NSUserDefaults standardUserDefaults] setObject:_telTextF.text forKey:@"telTextF"];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"login"];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"thirdPartLogin"];
                NSString *nowDate = [RLSMethods getDateByStyle:dateStyleFormatter withDate:[NSDate dateWithTimeIntervalSinceNow:3600*24*15]];
                [[NSUserDefaults standardUserDefaults] setObject:nowDate forKey:@"thirdPartLoginDeadline"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                RLSUserModel *model = [RLSUserModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
                RLSTokenModel *tokenModel = [RLSTokenModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
                [RLSMethods updateTokentModel:tokenModel];
                [RLSMethods updateUsetModel:model];
                [[NSUserDefaults standardUserDefaults] setDouble:([[responseOrignal objectForKey:@"time"] doubleValue] + RequestRefreshTokenTime) forKey:@"refreshTokentime"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOpenMainTableBarTimer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"open",@"timer", nil]];
                [self connectRongyunWithUserModel:model];
                [_prograssHud hide:YES afterDelay:1];
                [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];
            }else{
                [_prograssHud hide:YES afterDelay:0];
                [self toBangUserVC];
            }
        }else{
            _prograssHud.mode = MBProgressHUDModeCustomView;
            _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong"]];
            _prograssHud.labelText = [responseOrignal objectForKey:@"msg"];
            [_prograssHud hide:YES afterDelay:1];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        _prograssHud.mode = MBProgressHUDModeCustomView;
        _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong"]];
        _prograssHud.labelText = errorDict;
        [_prograssHud hide:YES afterDelay:1];
        NSLog(@"%@",responseOrignal);
    }];
}
- (void)toBangUserVC {
    RLSBangUserVC *bangVC = [RLSBangUserVC new];
    [self presentViewController:bangVC animated:YES completion:nil];
}
- (void)toRegister
{
    RLSRegisterViewController *registerVC = [[RLSRegisterViewController alloc]init];
    [self presentViewController:registerVC animated:YES completion:nil];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        
{
    if (textField == _telTextF) {
        _imageViewTel.image = [UIImage imageNamed:@"register2_1"];
    }else if (textField == _pswTextF){
        _imageViewPsw.image = [UIImage imageNamed:@"register3_1"];
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField;           
{
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; 
    if (_telTextF == textField)  
    {
    }else if(_pswTextF == textField){
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:LettersAndNum] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if ([string isEqualToString:filtered]) {
            if ([toBeString length]>16) {
                textField.text = [toBeString substringToIndex:16];
                return NO;
            }else{
                return YES;
            }
        }else{
            return NO;
        }
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [UIView commitAnimations];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_telTextF resignFirstResponder];
    [_pswTextF resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)connectRongyunWithUserModel:(RLSUserModel *)user
{
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
@end
