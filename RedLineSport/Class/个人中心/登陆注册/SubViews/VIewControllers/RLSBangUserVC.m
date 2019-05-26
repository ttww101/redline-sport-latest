#import "RLSBangUserVC.h"
#import "RLSRegisterViewController.h"
@interface RLSBangUserVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *telTextF;
@property (nonatomic, strong) UITextField *pswTextF;
@property (nonatomic, strong) MBProgressHUD *prograssHud;
@property (nonatomic, strong)UIImageView *imageViewTel;
@property (nonatomic, strong)UIImageView *imageViewPsw;
@end
@implementation RLSBangUserVC
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
    _telTextF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"bangNickName"];
    [super viewWillAppear:animated];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark -- setnavView
- (void)setNavView{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"用户绑定";
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
        [self presentViewController:registerVC animated:YES completion:^{
        }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = grayColor1;
    [self setNavView];
    [self creatLogin];
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
    UIButton *loginbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginbtn.bounds = CGRectMake(10, 0, logView.bounds.size.width - 20, 40);
    loginbtn.center = CGPointMake(Width/2, logView.frame.origin.y + logView.bounds.size.height + space/2 + height/2 + 15);
    loginbtn.titleLabel.font = font14;
    loginbtn.backgroundColor = redcolor;
    loginbtn.layer.cornerRadius = 3;
    [loginbtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginbtn addTarget:self action:@selector(loginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginbtn];
        _telTextF.placeholder = @"请输入手机号/用户名";
        UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        registerBtn.frame = CGRectMake(Width - 80, title.top+2, 80, 15);
        registerBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        registerBtn.titleLabel.font = font14;
        [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [registerBtn setTitleColor:ColorWithRGBA(252, 68, 72, 1) forState:UIControlStateNormal];
        [registerBtn addTarget:self action:@selector(toRegister) forControlEvents:UIControlEventTouchUpInside];
        UILabel *labText = [[UILabel alloc] init];
        labText.bounds = CGRectMake(0, 0, logoImageView.bounds.size.width, height/2);
        if (isOniPhone4) {
            labText.center = CGPointMake(Width/2, loginbtn.bottom + 100);
        }else{
            labText.center = CGPointMake(Width/2, loginbtn.bottom + 100);
        }
        _telTextF.text = _nickname;
}
- (void)loginBtn
{
    _telTextF.text = [_telTextF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    _pswTextF.text = [_pswTextF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    if (_pswTextF.text.length == 0) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入密码"];
        return;
    }
    if (!(_pswTextF.text.length >= 6 && _pswTextF.text.length <=16)) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入6~16位的字符密码"];
        return;
    }
        [self loginThirdPartWithUserName:_username nickName:_telTextF.text picUrl:_pic resource:_resource password:_pswTextF.text];
}
- (void)loginThirdPartWithUserName:(NSString *)username nickName:(NSString *)nickname picUrl:(NSString *)pic resource:(NSString *)resource password:(NSString *)password
{
    [self.view endEditing:YES];
    nickname = [[NSUserDefaults standardUserDefaults] objectForKey:@"bangNickName"];
    username = [[NSUserDefaults standardUserDefaults] objectForKey:@"bangUserName"];
    pic = [[NSUserDefaults standardUserDefaults] objectForKey:@"bangPic"];
    resource = [[NSUserDefaults standardUserDefaults] objectForKey:@"bangResource"];
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
            [[NSUserDefaults standardUserDefaults] setDouble:[[responseOrignal objectForKey:@"time"] doubleValue] + RequestRefreshTokenTime forKey:@"refreshTokentime"];
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
- (void)toRegister
{
    RLSRegisterViewController *registerVC = [[RLSRegisterViewController alloc]init];
    [self presentViewController:registerVC animated:YES completion:nil];
}
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
