//
//  RLSRegisterViewController.m
//  GunQiuLive
//
//  Created by WQ_h on 16/1/25.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import "RLSRegisterViewController.h"
#import "MBProgressHUD.h"
#import "RLSDCHttpRequest.h"
#import "RLSJKCountDownButton.h"
#import <UMPush/UMessage.h>

#define colorBtn ColorWithRGBA(253, 186, 49, 1)
@interface RLSRegisterViewController ()<UITextFieldDelegate>
{
    float _keyboardHeight;
}
@property (nonatomic, strong) UITextField *telTextF;
@property (nonatomic, strong) UITextField *checkTextF;
@property (nonatomic, strong) UITextField *pswTextF;
@property (nonatomic, strong) UITextField *userTextF;
@property (nonatomic, strong) UITextField *invTextF; // 邀请码
@property (nonatomic, strong) RLSJKCountDownButton *checkBtn;
@property (nonatomic, strong) MBProgressHUD *prograssHud;
@property (nonatomic, strong)UIButton *btnJIZhu;
@property (nonatomic, retain)NSMutableArray *arrImgView;
@end

@implementation RLSRegisterViewController

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"bangNickName"]) {
        _userTextF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"bangNickName"];
    }
    [super viewWillAppear:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = grayColor1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordUp:) name:UIKeyboardWillShowNotification object:nil];
    _arrImgView = [[NSMutableArray alloc] initWithCapacity:0];
    _keyboardHeight = 0;
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];

    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];

    [self creatRegister];

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
#pragma mark -- setnavView
- (void)setNavView{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    
//    if (self.bangType == bangDingType) {
    
//        nav.labTitle.text = @"用户绑定";
//    }else {
    
        nav.labTitle.text = @"注册";
//    }
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    
//    if (self.bangType == bangDingType) {
    
//        [nav.btnRight setTitle:@"注册" forState:UIControlStateNormal];
//    }
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        //left
        [self dismissViewControllerAnimated:YES completion:^{
        }];
        
    }else if(index == 2){
        //right
        
//        if (self.bangType == bangDingType) {
//        
//            NSLog(@"绑定界面注册");
//        }
    }
}
- (void)creatRegister
{
    float space = 20;
    float textHeight = 50;
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 20, 59, 44);
//    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(dismissPresent) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 44, 44)];
//    back.center = CGPointMake(cancelBtn.width/2, cancelBtn.width/2);
    back.image = [UIImage imageNamed:@"back"];
    [cancelBtn addSubview:back];
//    [self.view addSubview:cancelBtn];
    
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"注册";
    title.font = font17;
    title.textColor = ColorWithRGBA(64, 64, 64, 1);
    title.frame = CGRectMake(0, 30, 40, 15);
    CGPoint titlePiont = title.center;
    titlePiont.x = self.view.center.x;
    title.center = titlePiont;
//    [self.view addSubview:title];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, Width, 1)];
    lineView.backgroundColor = grayColorBottomLine;
    [self.view  addSubview:lineView];
    
    
    UIView *registerView = [[UIView alloc] initWithFrame:CGRectMake(0, lineView.bottom, Width, textHeight*5)];
    registerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:registerView];
//手机号
    UIImageView *telImageView = [[UIImageView alloc] initWithFrame:CGRectMake(space, 5, textHeight/3.5, textHeight/2.3)];
    telImageView.center = CGPointMake(telImageView.center.x, textHeight/2);
    telImageView.image= [UIImage imageNamed:@"register0"];
    [registerView addSubview:telImageView];
    [_arrImgView addObject:telImageView];
    _telTextF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, registerView.bounds.size.width - telImageView.frame.origin.x - telImageView.bounds.size.width - space, textHeight )];
    _telTextF.center = CGPointMake(telImageView.frame.origin.x + telImageView.bounds.size.width + space + _telTextF.bounds.size.width/2, textHeight/2);
//    _telTextF.borderStyle = UITextBorderStyleRoundedRect;
    _telTextF.font = font14;
    _telTextF.placeholder = @"请输入手机号";
    _telTextF.delegate = self;
    _telTextF.keyboardType = UIKeyboardTypeDecimalPad;
    _telTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [registerView addSubview:_telTextF];
    //横线
    for (int i = 0; i<4; i++) {
        UIView *viewH = [[UIView alloc] initWithFrame:CGRectMake(0, textHeight*(i+1) - 0.5, registerView.bounds.size.width, 0.5)];
        viewH.backgroundColor = colorDD;
        [registerView addSubview:viewH];
        
        UIImageView *checkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(telImageView.frame.origin.x, telImageView.frame.origin.y + textHeight*(i+1), telImageView.bounds.size.width, textHeight/3)];
        checkImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"register%d",i+1]];
        [registerView addSubview:checkImageView];
        [_arrImgView addObject:checkImageView];

    }
   //验证码
    _checkTextF = [[UITextField alloc] initWithFrame:CGRectMake(_telTextF.frame.origin.x, _telTextF.frame.origin.y + textHeight, _telTextF.bounds.size.width - 80, _telTextF.bounds.size.height)];
//    _checkTextF.borderStyle = UITextBorderStyleRoundedRect;
    _checkTextF.font = font14;
    _checkTextF.placeholder = @"请输入验证码";
    _checkTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _checkTextF.delegate = self;
    _checkTextF.keyboardType = UIKeyboardTypeDecimalPad;
    [registerView addSubview:_checkTextF];
    
    _checkBtn = [[RLSJKCountDownButton alloc] initWithFrame:CGRectMake(_checkTextF.frame.origin.x + _checkTextF.frame.size.width - 10, textHeight + 10, 80, textHeight - 20)];
    _checkBtn.titleLabel.font = font12;
    [_checkBtn setTitleColor:grayColor34 forState:UIControlStateNormal];
    _checkBtn.layer.cornerRadius = 5;
    _checkBtn.layer.borderWidth = 1;
    [_checkBtn setBackgroundColor:[UIColor whiteColor]];
    _checkBtn.layer.borderColor = cellLineColor.CGColor;
    [_checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_checkBtn addTarget:self action:@selector(getCheckCode:) forControlEvents:UIControlEventTouchUpInside];
    [registerView addSubview:_checkBtn];
    //用户名
    _userTextF = [[UITextField alloc] initWithFrame:CGRectMake(_telTextF.frame.origin.x, _telTextF.frame.origin.y + textHeight*2, _telTextF.bounds.size.width, _telTextF.bounds.size.height)];
//    _userTextF.borderStyle = UITextBorderStyleRoundedRect;
    _userTextF.font = font14;
    _userTextF.placeholder = @"请输入昵称";
    _userTextF.delegate = self;
    _userTextF.keyboardType = UIKeyboardTypeDefault;
    _userTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [registerView addSubview:_userTextF];
    //密码
    _pswTextF = [[UITextField alloc] initWithFrame:CGRectMake(_telTextF.frame.origin.x, _telTextF.frame.origin.y + textHeight*3, _telTextF.bounds.size.width, _telTextF.bounds.size.height)];
//    _pswTextF.borderStyle = UITextBorderStyleRoundedRect;
    _pswTextF.font = font14;
    _pswTextF.placeholder = @"请输入密码";
    _pswTextF.secureTextEntry = YES;
    _pswTextF.delegate = self;
    _pswTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pswTextF.clearsOnBeginEditing = YES;
    _pswTextF.keyboardType = UIKeyboardTypeDefault;
    [registerView addSubview:_pswTextF];
    
    
    //邀请码
    _invTextF = [[UITextField alloc] initWithFrame:CGRectMake(_telTextF.frame.origin.x, _telTextF.frame.origin.y + textHeight*4, _telTextF.bounds.size.width, _telTextF.bounds.size.height)];
    //    _pswTextF.borderStyle = UITextBorderStyleRoundedRect;
    _invTextF.font = font14;
    _invTextF.placeholder = @"请输入邀请码(可不填)";
//    _invTextF.secureTextEntry = YES;
    _invTextF.delegate = self;
    _invTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _invTextF.clearsOnBeginEditing = YES;
    _invTextF.keyboardType = UIKeyboardTypeNumberPad;
    [registerView addSubview:_invTextF];
    
    
  
    
    //    忘记密码
    _btnJIZhu = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnJIZhu.frame = CGRectMake(space, registerView.bottom + 15, 18, 18);
    [_btnJIZhu setImage:[UIImage imageNamed:@"wangji"] forState:UIControlStateNormal];
    [_btnJIZhu setImage:[UIImage imageNamed:@"jizhu"] forState:UIControlStateSelected];
    [_btnJIZhu addTarget:self action:@selector(jiZhuPassword:) forControlEvents:UIControlEventTouchUpInside];
    _btnJIZhu.selected = YES;
    [self.view addSubview:_btnJIZhu];
    
    UILabel *argementlab = [[UILabel alloc] initWithFrame:CGRectMake(_telTextF.frame.origin.x, registerView.bottom + 16, 160, 15)];
    argementlab.text = @"用户服务协议";
    argementlab.textColor = redcolor;
    argementlab.font = font14;
    argementlab.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(argementlabClick)];
    [argementlab addGestureRecognizer:tapGest];
    [self.view addSubview:argementlab];
    
//注册按钮
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(10, registerView.frame.origin.y + registerView.frame.size.height + space*2.5, registerView.bounds.size.width - 20, textHeight - 10);
//    [registerBtn setTitle:@"创建账户" forState:UIControlStateNormal];
    [registerBtn setTitle:@"创建账户" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn setBackgroundColor:redcolor];
    [registerBtn.titleLabel setFont:font14];
    registerBtn.layer.cornerRadius = 3;
    [registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    UILabel *detailLab = [[UILabel alloc] initWithFrame:CGRectMake(space*2, Height - space/2 - textHeight, Width - space *4, textHeight)];
    detailLab.text = @"您将收到一条验证您身份的短信,我们承诺绝不会向您推送垃圾消息和泄露您的个人信息。";
    detailLab.font = font10;
    detailLab.numberOfLines = 2;
    detailLab.textColor = ColorWithRGBA(64, 64, 64, 1);
    detailLab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:detailLab];
}

- (void)jiZhuPassword:(UIButton *)btn{
    btn.selected = !btn.selected;
    
}
- (void)argementlabClick {

   // 用户服务协议
    
    RLSWKWebViewController *webVC = [[RLSWKWebViewController alloc] init];
    webVC.strurl = [NSString stringWithFormat:@"%@/help/agreement.html",APPDELEGATE.url_ServerAgreement];
    webVC.strtitle = @"用户服务协议";
    webVC.hidesBottomBarWhenPushed = YES;
    [self presentViewController:webVC animated:YES completion:^{
        
    }];
}

- (void)dismissPresent
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)getCheckCode:(RLSJKCountDownButton *)btn
{
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];

    _telTextF.text = [_telTextF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![RLSMethods isMobileNumber:self.telTextF.text]) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"手机号不正确"];
        return;
    }

    btn.enabled = NO;
    [btn startWithSecond:60];
    [btn didChange:^NSString *(RLSJKCountDownButton *countDownButton, int second) {
        return [NSString stringWithFormat:@"剩余%d秒",second];
    }];
    [btn didFinished:^NSString *(RLSJKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        return @"重新获取";
    }];
//    sender.enabled = NO;
    //button type要 设置成custom 否则会闪动
    [self getcheckCode];
}
//发送验证码
- (void)getcheckCode
{
    /*
     utype = 1，//操作类型（0:登录操作，1：获取手机验证码，2：用户注册，3：找回密码）
     mobile，  //手机号
     type     //验证码类型，0：注册验证码，1：找回密码验证码，2：更改手机号验证码',    
     */
    [self.view endEditing:YES];
    NSMutableDictionary *dictParameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [dictParameter setObject:@"1" forKey:@"flag"];
    [dictParameter setObject:_telTextF.text forKey:@"mobile"];
    [dictParameter setObject:@"0" forKey:@"type"];
    // 设备udid
    [dictParameter setObject:@"1" forKey:@"platform"];
    [dictParameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"] forKey:@"uuid"];
    

    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:dictParameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"验证码已发送"];
        }else{
            [_checkBtn stop];
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        if (!error) {
            
        }else{
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        }
    }];
}
- (void)registerBtnClick:(UIButton *)btn
{
//    [self.view endEditing:YES];
    [_checkBtn stop];
    
    _telTextF.text = [_telTextF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    _checkTextF.text = [_checkTextF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    _userTextF.text = [_userTextF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    _pswTextF.text= [_pswTextF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    _invTextF.text = [_invTextF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];

    
    if (isNUll(self.telTextF.text) || isNUll(self.checkTextF.text) || isNUll(self.userTextF.text) || isNUll(self.pswTextF.text)) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"应填项不能为空"];
        return;
    }
    
    if (![RLSMethods isMobileNumber:self.telTextF.text]) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"手机号不正确"];
        return;
    }
    if (!(self.userTextF.text.length >= 2 && self.userTextF.text.length <= 12)) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入2~12位的昵称"];
        return;
    }

    if (!(self.pswTextF.text.length >= 6 && self.pswTextF.text.length <=16)) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入6~16个字符密码"];
        return;
    }
    
    if (_invTextF.text.length > 0 && _invTextF.text.length < 3 ) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入3~15位邀请码"];
        return;
    }
    
    if (!self.btnJIZhu.selected) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请先同意用户协议"];
        return;
    }
    [self registerUser];
}

// 注册
- (void)registerUser
{
    [self.view endEditing:YES];
    /*
     utype = 2，//操作类型（0:登录操作，1：获取手机验证码，2：用户注册，3：找回密码）
     mobile，  //手机号
     nickname，//用户名,
     password，//密码
     authCode，//验证码
     resource， //用户注册来源，0：pc,1：ios，2：android，3：wp，4：h5     */
    NSMutableDictionary *dictPatameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [dictPatameter setObject:@"2" forKey:@"flag"];
    [dictPatameter setObject:_telTextF.text forKey:@"mobile"];
    [dictPatameter setObject:_userTextF.text forKey:@"nickname"];
    [dictPatameter setObject:[RLSMethods md5WithString:_pswTextF.text] forKey:@"password"];
    [dictPatameter setObject:_checkTextF.text forKey:@"authCode"];
    [dictPatameter setObject:@"1" forKey:@"resource"];
    // 设备udid
    [dictPatameter setObject:@"1" forKey:@"platform"];
    [dictPatameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"] forKey:@"uuid"];
    [dictPatameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"] forKey:@"token"];
    [dictPatameter setObject:PARAM_IS_NIL_ERROR(_invTextF.text) forKey:@"invitationCode"];

    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:dictPatameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] ArrayFile:nil Start:^(id requestOrignal) {
        if (!_prograssHud) {
            _prograssHud = [[MBProgressHUD alloc] initWithView:self.view];
        }
        _prograssHud.mode = MBProgressHUDModeIndeterminate;
        _prograssHud.labelText = @"正在注册";
        [_prograssHud show:YES];
        [self.view addSubview:_prograssHud];
    } End:^(id responseOrignal) {
        [_prograssHud hide:YES afterDelay:1];

    } Success:^(id responseResult, id responseOrignal) {
        
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _prograssHud.mode = MBProgressHUDModeCustomView;
            _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
            _prograssHud.labelText = @"注册成功";
            [_prograssHud hide:YES afterDelay:1];
            [[NSUserDefaults standardUserDefaults] setObject:_telTextF.text forKey:@"telTextF"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"login"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"thirdPartLogin"];

            [[NSUserDefaults standardUserDefaults] synchronize];
            RLSUserModel *model = [RLSUserModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            RLSTokenModel *tokenModel = [RLSTokenModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:tokenModel.token forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] setObject:PARAM_IS_NIL_ERROR(tokenModel.refreshToken) forKey:@"refreshToken"];
            [[NSUserDefaults standardUserDefaults] setDouble:([[responseOrignal objectForKey:@"time"] doubleValue] + RequestRefreshTokenTime) forKey:@"refreshTokentime"];
            [RLSMethods updateTokentModel:tokenModel];
            [RLSMethods updateUsetModel:model];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOpenMainTableBarTimer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"open",@"timer", nil]];
            
//            [self connectRongyunWithUserModel:model];
            
            //登陆成功之后注册推送
//            [XGPush setAccount:[NSString stringWithFormat:@"GQ%lu",(long)model.idId]];
//            [XGPush registerDevice:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenData"] successCallback:^{
//                NSLog(@"[XGPush Demo]register successBlock");
//                
//            } errorCallback:^{
//                NSLog(@"[XGPush Demo]register wrongBlock");
//                
//            }];
            
            [UMessage addAlias:[NSString stringWithFormat:@"GQ%lu",(long)model.idId] type:@"GUN_QIU" response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
                
            }];

            [self performSelector:@selector(dismissPresent) withObject:nil afterDelay:1];
        }else{
            _prograssHud.mode = MBProgressHUDModeCustomView;
            _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong"]];
            _prograssHud.labelText = [responseOrignal objectForKey:@"msg"];
            [_prograssHud hide:YES afterDelay:1];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        _prograssHud.mode = MBProgressHUDModeCustomView;
        _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong"]];
//        if (responseOrignal) {
//            _prograssHud.labelText = [responseOrignal objectForKey:@"msg"];
//        }else{
        _prograssHud.labelText = errorDict;
//        }
        [_prograssHud hide:YES afterDelay:1];
    }];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
{
    UIImageView *img = nil;
    if (textField == _checkTextF) {
        img = [_arrImgView objectAtIndex:1];
        img.image = [UIImage imageNamed:@"register1_1"];
    }else if (textField == _userTextF){
        img = [_arrImgView objectAtIndex:2];
        img.image = [UIImage imageNamed:@"register2_1"];
    }else if(textField == _pswTextF){
        img = [_arrImgView objectAtIndex:3];
        img.image = [UIImage imageNamed:@"register3_1"];
    } else if (textField == _invTextF) {
        img = [_arrImgView objectAtIndex:4];
        img.image = [UIImage imageNamed:@"register0_4"];
    } else {
        img = [_arrImgView objectAtIndex:0];
        img.image = [UIImage imageNamed:@"register0_1"];
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
{
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (_telTextF == textField)  //判断是否时我们想要限定的那个输入框
    {
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:Nunbers] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
        if ([string isEqualToString:filtered]) {
            if ([toBeString length] > 11) { //如果输入框内容大于20则弹出警告
                textField.text = [toBeString substringToIndex:11];
                return NO;
            }else{
                return YES;
            }
            
        }else{
            return NO;
        }
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
    }else if (_checkTextF == textField){
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:Nunbers] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if ([string isEqualToString:filtered]) {
            if ([toBeString length]>6) {
                textField.text = [toBeString substringToIndex:6];
                return NO;
            }else{
                return YES;
            }
        }else{
            return NO;
        }
    }else if (_userTextF == textField){
//        NSCharacterSet *cs;
//        cs = [[NSCharacterSet characterSetWithCharactersInString:LettersAndNum] invertedSet];
//        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//        if ([string isEqualToString:filtered]) {
            if ([toBeString length]>12) {
                textField.text = [toBeString substringToIndex:12];
                return NO;
            }
                else{
                return YES;
            }
//        }
//    else{
//            return NO;
//        }
    } else if (_invTextF == textField) {
        if ([toBeString length]>15) {
            textField.text = [toBeString substringToIndex:15];
            return NO;
        }
        else{
            return YES;
        }
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_checkTextF == textField) {
        if (_checkTextF.text.length == 6) {
            [_checkBtn stop];
        }
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [UIView commitAnimations];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



- (void)connectRongyunWithUserModel:(RLSUserModel *)user
{}
//{
//    [[RCIM sharedRCIM] disconnect];
//    
//    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [RLSHttpString getCommenParemeter]];
//    [parameter setObject:[NSString stringWithFormat:@"%ld",user.idId] forKey:@"userId"];
//    [parameter setObject:user.nickname forKey:@"nickname"];
//    [parameter setObject:user.pic forKey:@"pic"];
//    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_getRonyunUserToken] ArrayFile:nil Start:^(id requestOrignal) {
//        
//    } End:^(id responseOrignal) {
//        
//    } Success:^(id responseResult, id responseOrignal) {
//        
//        
//        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
//            
//            NSString *tokenRongyun = [[responseOrignal objectForKey:@"data"] objectForKey:@"token"];
//            NSString *userIdRongyun = [[responseOrignal objectForKey:@"data"] objectForKey:@"userId"];
//            [[NSUserDefaults standardUserDefaults] setObject:userIdRongyun forKey:@"userIdRongyun"];
//            [[NSUserDefaults standardUserDefaults] setObject:tokenRongyun forKey:@"tokenRongyun"];
//            
//            //
//            [[RCIM sharedRCIM] connectWithToken:tokenRongyun success:^(NSString *userId) {
//                NSLog(@"%@",userId);
//                
//            } error:^(RCConnectErrorCode status) {
//                NSLog(@"");
//                
//            } tokenIncorrect:^{
//                NSLog(@"");
//                
//            }];
//            [[RCIM sharedRCIM] clearUserInfoCache];
//            RCUserInfo *userInfo = [RCUserInfo new];
//            userInfo.name = user.nickname;
//            userInfo.userId = [NSString stringWithFormat:@"%ld",user.idId];
//            userInfo.portraitUri = user.pic;
//            
//            [[RCIM sharedRCIM] refreshUserInfoCache:userInfo withUserId:userInfo.userId];
//            [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:[NSString stringWithFormat:@"%ld",user.idId] name:user.nickname portrait:user.pic];
//
//        }
//        
//        
//        
//    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
//        
//    }];
//    
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
