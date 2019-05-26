#import "RLSSignatureVC.h"
#import "RLSSucessViewOfSignatureView.h"
@interface RLSSignatureVC ()<UITextViewDelegate>
@property (nonatomic, strong)UILabel *labPlarch;
@property (nonatomic, strong)UITextView *txtView;
@property (nonatomic, weak)RLSNavView *navV;
@property (nonatomic, assign) BOOL successed;
@end
@implementation RLSSignatureVC
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = colorTableViewBackgroundColor;
    [self setNavView];
}
- (void)setNavView{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"个人签名";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
        [nav.btnRight setTitle:@"提交 " forState:UIControlStateNormal];
        [nav.btnRight setTitle:@"提交 " forState:UIControlStateHighlighted];
    _navV = nav;
    [self.view addSubview:nav];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView)];
    [nav addGestureRecognizer:tap];
    UIView *bkView = [[UIView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 10, Width, 108)];
    bkView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bkView];
    _txtView = [[UITextView alloc] initWithFrame:CGRectMake(15, 10, Width - 30, bkView.height - 20)];
    _txtView.delegate = self;
    _txtView.font = font14;
    _txtView.textColor = color33;
    _txtView.text = self.labContent;
    [bkView addSubview:_txtView];
    _labPlarch = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, Width, 20)];
    _labPlarch.font = font14;
    _labPlarch.textColor = colorCC;
    _labPlarch.text = @"写下你的个性签名，让大家认识你";
    [_txtView addSubview:_labPlarch];
    if (self.labContent.length > 0) {
        _labPlarch.hidden = YES;
    }else{
        _labPlarch.hidden = NO;
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    _labPlarch.hidden = YES;
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if (isNUll(textView.text)) {
        _labPlarch.hidden = NO;
    }else{
        _labPlarch.hidden = YES;
    }
    return YES;
}
- (void)tapScrollView
{
    [self.view endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    [self.view endEditing:YES];
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
        if (_successed ) {
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        if (_txtView.text.length > 100) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"最多输入100字哦"];
            return;
        }
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
        [parameter setObject:@"12" forKey:@"flag"];
        [parameter setObject:_txtView.text forKey:@"userinfo"];
        [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] ArrayFile:nil Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
        } Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                [_navV.btnRight setTitle:@"关闭 " forState:UIControlStateNormal];
                [_navV.btnRight setTitle:@"关闭 " forState:UIControlStateHighlighted];
                _successed = YES;
                RLSUserModel *model = [RLSMethods getUserModel];
                model.userinfo = _txtView.text;
                [RLSMethods updateUsetModel:model];
                RLSSucessViewOfSignatureView *successView = [[RLSSucessViewOfSignatureView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) ];
                successView.backgroundColor = [UIColor whiteColor];
                [self.view addSubview:successView];
                [successView sucessBack:^(BOOL sucessed) {
                    if (sucessed) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }];
            }else{
                                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
            }
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
                            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        }];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([textView isFirstResponder]) {
        if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] ||
            ![[textView textInputMode] primaryLanguage] ) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"暂不支持输入表情符号"];
            return NO;
        }
    }
    if ([textView isFirstResponder]) {
        if ([self stringContainsEmoji:text]) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"暂不支持输入表情符号"];
            return NO;
        }
    }
    return YES;
}
- (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff) {
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    return returnValue;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
