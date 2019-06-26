#import "RLSTuijianDetailVC.h"
#import "RLSCommentModel.h"
#import "RLSBuyRecordsVC.h"
#import "RLSBuyerModel.h"
#import "RLSpayUserModel.h"
#import "RLSTuijianDetailHeaderView.h"
#import "RLSTuijianDTViewController.h"
#import "RLSAppleIAPService.h"
#import "RLSSelectPayMentView.h"
#import "ArchiveFile.h"
#import "XHPayKit.h"
#import "RLSToolWebViewController.h"
#import "RLSWebModel.h"
#import "NSString+XHPayKit.h"
#import "ArchiveFile.h"
@interface RLSTuijianDetailVC () <UITextViewDelegate>
@property (nonatomic, strong) RLSTuijianDetailTableView *tableView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, copy) NSString *currentTextViewText;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *payView;
@property (nonatomic, strong) UILabel *labelQiuBi;
@property (nonatomic, strong) UIButton *btnPay;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *labComment;
@property (nonatomic, strong) UILabel *labCommentNum;
@property (nonatomic, strong) UIButton *labComment1;
@property (nonatomic, strong) UILabel *labCommentNum1;
@property (nonatomic, strong) RLSTuijiandatingModel *model;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, assign) NSInteger sendCommentTag;
@property (nonatomic, strong) NSDictionary *notifComment;
@property (nonatomic, assign) NSInteger payTime;
@property (nonatomic, strong) NSArray *buyerArr;
@property (nonatomic, strong) NSString *appIdStr;
@end
@implementation RLSTuijianDetailVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[RLSUMStatisticsMgr sharedInstance] viewStaticsBeginWithMarkStr:@"RLSTuijianDetailVC"];
    self.navigationController.navigationBarHidden = YES;
    [self viewdatanew];
    [self zhucetongzhi];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewdatanew {
    self.view.backgroundColor = [UIColor whiteColor];
    if (_status == 0) {
        _status = 1;
    }
    [self payViewpayl];

    if (_tableView) {
        [_tableView removeFromSuperview];
        _tableView = nil;
    }

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.payView];
    [self.view addSubview:self.bottomView];
    [self addAutoLayout];

    [self loadDataWhetherFirst:YES];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addComment:) name:@"TuijianDetailVCAddComment" object:nil];
    [self setNavView];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[RLSUMStatisticsMgr sharedInstance] viewStaticsEndWithMarkStr:@"RLSTuijianDetailVC"];
}
- (void)addComment:(NSNotification *)notification {
    NSLog(@"%@", notification.userInfo);
    [self.textView becomeFirstResponder];
    _sendCommentTag = [[notification.userInfo objectForKey:@"commentTag"] integerValue];
    _notifComment = notification.userInfo;
}
#pragma mark-- setnavView
- (void)setNavView {
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"推荐详情";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index {
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (index == 2) {
    }
}
- (void)addAutoLayout {
    [self.payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(55);
        make.width.equalTo(self.view.mas_width);
    }];
    [self.labelQiuBi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.payView).offset(2);
        make.left.mas_equalTo(15);
    }];
    [self.btnPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.payView.mas_centerY);
        make.right.equalTo(self.payView.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(94, 28));
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableView.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(Width);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_top);
        make.left.equalTo(self.bottomView.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_top);
        make.right.equalTo(self.bottomView.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left).offset(10);
        make.bottom.equalTo(self.bottomView.mas_bottom).offset(-6);
        make.top.equalTo(self.cancelBtn.mas_bottom).offset(6);
        make.size.mas_equalTo(CGSizeMake(Width - 88 - 20, 32));
    }];
    [self.labComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textView.mas_centerY);
        make.left.equalTo(self.textView.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    [self.labCommentNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textView.mas_right).offset(35);
        make.centerY.equalTo(self.textView.mas_centerY);
    }];
    [self.labComment1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textView.mas_centerY);
        make.left.equalTo(self.textView.mas_right).offset(44);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    [self.labCommentNum1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textView.mas_right).offset(80);
        make.centerY.equalTo(self.textView.mas_centerY);
    }];
}
- (RLSTuijianDetailTableView *)tableView {
    if (!_tableView) {
        _tableView = [[RLSTuijianDetailTableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, _status == 1 ? (Height - APPDELEGATE.customTabbar.height_myNavigationBar - 49) : (Height - APPDELEGATE.customTabbar.height_myNavigationBar - self.bottomView.height)) style:UITableViewStylePlain];
        _tableView.typeTuijianDetailHeader = _typeTuijianDetailHeader;
        _tableView.hidden = YES;
    }
    return _tableView;
}
- (NSString *)appIdStr {
    if (!_appIdStr) {
        _appIdStr = [NSString string];
    }
    return _appIdStr;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = colorFA;
        _bottomView.layer.borderColor = colorDD.CGColor;
        _bottomView.layer.borderWidth = 0.6;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addComment)];
        [_bottomView addGestureRecognizer:tap];
        [_bottomView addSubview:self.labComment];
        [_bottomView addSubview:self.labCommentNum];
        [_bottomView addSubview:self.labComment1];
        [_bottomView addSubview:self.labCommentNum1];
        [_bottomView addSubview:self.textView];
        [_bottomView addSubview:self.sendBtn];
        [_bottomView addSubview:self.cancelBtn];
        _bottomView.hidden = YES;
    }
    return _bottomView;
}
- (void)payViewpayl {
    if (!_payView) {
        _payView = [[UIView alloc] init];
        _payView.backgroundColor = [UIColor whiteColor];
        _payView.layer.borderColor = colorDD.CGColor;
        _payView.layer.borderWidth = 0.6;
        _payView.userInteractionEnabled = YES;
        [_payView addSubview:self.labelQiuBi];
        [_payView addSubview:self.btnPay];
        _payView.hidden = YES;
    }
}
- (void)addComment {
    if ([self.textView isFirstResponder]) {
        [self.view endEditing:YES];
    } else {
        [self.textView becomeFirstResponder];
        _sendCommentTag = 0;
    }
}
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.delegate = self;
        _textView.font = font13;
        _textView.text = @" 说说您对比赛的看法";
        _textView.scrollEnabled = YES;
        _textView.layer.borderColor = colorDD.CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.layer.cornerRadius = 3;
        _textView.textColor = colorCC;
        _textView.userInteractionEnabled = YES;
        _textView.returnKeyType = UIReturnKeySend;
    }
    return _textView;
}
- (UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:color33 forState:UIControlStateNormal];
        [_sendBtn.titleLabel setFont:font14];
        [_sendBtn addTarget:self action:@selector(sendComment:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:color33 forState:UIControlStateNormal];
        [_cancelBtn.titleLabel setFont:font14];
        [_cancelBtn addTarget:self action:@selector(cancelComment) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (void)cancelComment {
    [self.view endEditing:YES];
}
- (void)sendComment:(UIButton *)btn {
    _sendBtn.enabled = NO;
    [self sendCommentWithCommentTag:_sendCommentTag withDict:_notifComment];
}
- (UIButton *)labComment {
    if (!_labComment) {
        _labComment = [UIButton buttonWithType:UIButtonTypeCustom];
        [_labComment setBackgroundImage:[UIImage imageNamed:@"agreeDetail"] forState:UIControlStateNormal];
        [_labComment setBackgroundImage:[UIImage imageNamed:@"red-agreeDetail"] forState:UIControlStateSelected];
        _labComment.selected = _model.liked;
        _labComment.tag = 1;
        [_labComment addTarget:self action:@selector(addLiked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _labComment;
}
- (UILabel *)labCommentNum {
    if (!_labCommentNum) {
        _labCommentNum = [[UILabel alloc] init];
        _labCommentNum.font = font10;
        _labCommentNum.textColor = color33;
        _labCommentNum.text = [NSString stringWithFormat:@"%ld", (long)_model.like_count];
    }
    return _labCommentNum;
}
- (UIButton *)labComment1 {
    if (!_labComment1) {
        _labComment1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_labComment1 setBackgroundImage:[UIImage imageNamed:@"noagreeDetail"] forState:UIControlStateNormal];
        [_labComment1 setBackgroundImage:[UIImage imageNamed:@"red-noagreeDetail"] forState:UIControlStateSelected];
        _labComment1.selected = _model.hated;
        _labComment1.tag = 2;
        [_labComment1 addTarget:self action:@selector(addLiked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _labComment1;
}
- (UILabel *)labCommentNum1 {
    if (!_labCommentNum1) {
        _labCommentNum1 = [[UILabel alloc] init];
        _labCommentNum1.font = font10;
        _labCommentNum1.textColor = color33;
        _labCommentNum1.text = [NSString stringWithFormat:@"%ld", (long)_model.hate_count];
    }
    return _labCommentNum1;
}
- (UILabel *)labelQiuBi {
    if (!_labelQiuBi) {
        _labelQiuBi = [[UILabel alloc] init];
        _labelQiuBi.font = font14;
        _labelQiuBi.textColor = color33;
    }
    return _labelQiuBi;
}
- (UIButton *)btnPay {
    if (!_btnPay) {
        _btnPay = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnPay setBackgroundImage:[UIImage imageNamed:@"paynow"] forState:UIControlStateNormal];
        [_btnPay addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnPay setTitle:@"立即支付" forState:UIControlStateNormal];
        [_btnPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnPay.titleLabel.font = font14;
    }
    return _btnPay;
}
- (void)payBtnClick:(UIButton *)sender {
    //    if (![RLSMethods login]) {
    //        [RLSMethods toLogin];
    //        return;
    //    }
    [self appleBuyWithData];
}
- (void)zhucetongzhi {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxtongzhi:) name:@"wxtongzhi" object:nil];
}
- (void)wxtongzhi:(NSNotification *)text {
    self.payView.hidden = YES;
    self.bottomView.hidden = NO;
    self.tableView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 49);
    _model.see = YES;
    self.tableView.headerModel = _model;
    [self loadDataWhetherFirst:NO];
    [self.tableView reloadData];
    [self paySuccess];
}
- (void)paySuccess {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@(_modelId) forKey:@"outerId"];
    [parameter setObject:@"1" forKey:@"oType"];
    RLSDCHttpRequest *httpRequest = [RLSDCHttpRequest shareInstance];
    if (![RLSMethods login]) {
        httpRequest = [RLSDCHttpRequest guestInstance];
        [parameter setObject:@"106205" forKey:@"userId"];
        [parameter setObject:@"106205" forKey:@"cnickid"];
    }
    [httpRequest sendRequestByMethod:@"post"
        WithParamaters:parameter
        PathUrlL:[NSString stringWithFormat:@"%@%@", APPDELEGATE.url_Server, url_appPaySuccess]
        ArrayFile:nil
        Start:^(id requestOrignal) {
        }
        End:^(id responseOrignal) {
        }
        Success:^(id responseResult, id responseOrignal) {
            NSString *msg = [NSString stringWithFormat:@"%@", [responseOrignal objectForKey:@"msg"]];
            if ([[responseOrignal objectForKey:@"code"] integerValue] == 200 || [msg isEqualToString:@"服务端程序异常，请稍后再试"]) {
                if ([[responseOrignal objectForKey:@"code"] integerValue] == 200) {
                    NSArray *dataArr = [[NSUserDefaults standardUserDefaults] arrayForKey:@"experts"];
                    if (dataArr == nil) dataArr = @[];
                    NSMutableArray *dataArray = [NSMutableArray arrayWithArray: dataArr];
                    NSNumber *num = [[NSNumber alloc] initWithInteger:_modelId];
                    [dataArray addObject: num];
                    [[NSUserDefaults standardUserDefaults] setObject:[dataArray copy] forKey:@"experts"];
                }
            
                self.payView.hidden = YES;
                self.bottomView.hidden = NO;
                self.tableView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 49);
                _model.see = YES;
                [self loadDataWhetherFirst:YES];
                self.tableView.headerModel = _model;
                [self.tableView reloadData];

                // reload webPage
                BOOL isWebView = [NSStringFromClass([self.navigationController.viewControllers[0] class]) isEqualToString:@"RLSToolWebViewController"];
                if (isWebView) {
                    RLSToolWebViewController *toolWebViewController = self.navigationController.viewControllers[0];
                    [toolWebViewController reload];
                }
            } else {
                [SVProgressHUD showWithStatus:msg];
                [SVProgressHUD dismissWithDelay:2.0f];
            }
        }
        Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            NSLog(@"11");
        }];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        if (_sendBtn.enabled) {
            [self sendCommentWithCommentTag:_sendCommentTag withDict:_notifComment];
            _sendBtn.enabled = NO;
        } else {
        }
        return NO;
    }
    return YES;
}
- (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:
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
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([RLSMethods login]) {
        return YES;
    } else {
        [RLSMethods toLogin];
        return NO;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@" 说说您对比赛的看法"]) {
        textView.text = @"";
        _textView.textColor = color33;
    } else if ([textView.text isEqualToString:@"......"]) {
        textView.text = _currentTextViewText;
        _textView.textColor = color33;
    }
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(frame.size.width, size.height));
    }];
    [self.view layoutIfNeeded];
    textView.scrollsToTop = YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text == nil || [textView.text isEqualToString:@""]) {
        textView.text = @" 说说您对比赛的看法";
        _textView.textColor = colorCC;
    } else {
        textView.text = @"......";
        _textView.textColor = color33;
    }
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(frame.size.width, size.height));
    }];
    [self.view layoutIfNeeded];
}
- (void)textViewDidChange:(UITextView *)textView {
    _currentTextViewText = textView.text;
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(frame.size.width, size.height));
    }];
    [self.view layoutIfNeeded];
}
- (void)KeyboardShow:(NSNotification *)notification {
    _sendBtn.enabled = YES;
    NSDictionary *userInfo = [notification userInfo];
    CGRect rect =
        [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(rect);
    CGFloat keyboardDuration =
        [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-keyboardHeight);
    }];
    [self.cancelBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];
    [self.sendBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width - 0 - 20, 32));
    }];
    [UIView animateWithDuration:keyboardDuration
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
    _textView.scrollsToTop = YES;
}
- (void)KeyboardHide:(NSNotification *)notification {
    _sendBtn.enabled = YES;
    NSDictionary *userInfo = [notification userInfo];
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width - 20 - 88, 32));
    }];
    [self.cancelBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];
    [self.sendBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
    [UIView animateWithDuration:keyboardDuration
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
}
- (void)loadDataWhetherFirst:(BOOL)first {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    if (_modelId == 0) {
        NSString *mid = [[NSUserDefaults standardUserDefaults] objectForKey:@"paymodelId"];
        [parameter setObject:mid forKey:@"newsId"];
    } else {
        [parameter setObject:[NSString stringWithFormat:@"%ld", (long)_modelId] forKey:@"newsId"];
    }
    RLSDCHttpRequest *httpRequest = [RLSDCHttpRequest shareInstance];
    BOOL flag = NO;
    NSArray *dataArr = [[NSUserDefaults standardUserDefaults] arrayForKey:@"experts"];
    if (![RLSMethods login]) {
        for (int i=0; i<dataArr.count; ++i) {
            NSNumber *num = dataArr[i];
            if (num.integerValue == _modelId) {
                httpRequest = [RLSDCHttpRequest guestInstance];
                [parameter setObject:@"106205" forKey:@"userId"];
                [parameter setObject:@"106205" forKey:@"cnickid"];
                break;
            }
        }
    }
    
    
    [parameter setObject:@"0" forKey:@"oddstype"];
    [httpRequest sendGetRequestByMethod:@"get"
        WithParamaters:parameter
        PathUrlL:[NSString stringWithFormat:@"%@%@", APPDELEGATE.url_Server, url_recommendshow]
        Start:^(id requestOrignal) {
            if (first) {
                [RLSLodingAnimateView showLodingView];
            }
        }
        End:^(id responseOrignal) {
            [RLSLodingAnimateView dissMissLoadingView];
        }
        Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                NSDictionary *news = [[responseOrignal objectForKey:@"data"] objectForKey:@"news"];
                _model = nil;
                _model = [RLSTuijiandatingModel entityFromDictionary:news];
                NSArray *recoommentArray = [[NSArray alloc] initWithArray:[RLSCommentModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"comments"]]];

                NSMutableArray *recods = [NSMutableArray array];

                DetailGroupModel *groupModel1 = [[DetailGroupModel alloc] init];
                [recods addObject:groupModel1];

                NSArray *arr = [RLSTuijiandatingModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"recs"]];
                DetailGroupModel *groupModel2 = [[DetailGroupModel alloc] init];
                groupModel2.title = @"相关推荐";
                groupModel2.showVerticalLine = true;
                groupModel2.dataList = [arr mutableCopy];
                [recods addObject:groupModel2];

                DetailGroupModel *groupModel3 = [[DetailGroupModel alloc] init];
                groupModel3.title = @"评论";
                groupModel3.showVerticalLine = true;
                groupModel3.dataList = [recoommentArray mutableCopy];
                [recods addObject:groupModel3];
                _tableView.arrData = recods;

                _tableView.headerModel = _model;
                if (_typeTuijianDetailHeader == typeTuijianDetailHeaderCellDanchang) {
                    _tableView.typeTuijianDetailHeader = _typeTuijianDetailHeader;

                    if (_status == 1) {
                    }
                    self.tableView.hidden = NO;
                    if (!_model.see) {
                        self.payView.hidden = NO;
                        self.bottomView.hidden = YES;
                        self.tableView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 0);
                        if (_status == 1) {
                            self.tableView.height = _status == Height - APPDELEGATE.customTabbar.height_myNavigationBar - 49;
                        } else {
                            self.tableView.height = Height - APPDELEGATE.customTabbar.height_myNavigationBar - 55;
                        }
                        _labCommentNum.text = [NSString stringWithFormat:@"%ld", (long)_model.like_count];
                        _labComment.selected = _model.liked;
                        _labCommentNum1.text = [NSString stringWithFormat:@"%ld", (long)_model.hate_count];
                        _labComment1.selected = _model.hated;
                        NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"currency"];
                        if (!(str.length > 0)) {
                            str = @"钻石";
                        }
                        _labelQiuBi.text = [NSString stringWithFormat:@"需支付 %ld 连红币", _model.amount == 3800 ? 30 : _model.amount / 100];
                        _labelQiuBi.font = font14;
                        _labelQiuBi.attributedText = [RLSMethods withContent:_labelQiuBi.text WithColorText:[NSString stringWithFormat:@"%ld 连红币", _model.amount == 3800 ? 30 : _model.amount / 100] textColor:redcolor strFont:font18];
                    } else {
                        self.bottomView.hidden = NO;
                        self.payView.hidden = YES;
                        self.tableView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 0);
                        if (_status == 1) {
                            self.tableView.height = Height - APPDELEGATE.customTabbar.height_myNavigationBar - 49;
                        } else {
                            self.tableView.height = Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44;
                        }
                    }
                } else {
                }
                [_tableView reloadData];
            } else {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
            }
        }
        Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        }];
}
- (void)sendCommentWithCommentTag:(NSInteger)commentTag withDict:(NSDictionary *)dictP {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    if (_textView.text == nil || [_textView.text isEqualToString:@""]) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入评论内容"];
        return;
    }
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    if (_typeTuijianDetailHeader == typeTuijianDetailHeaderCellDanchang) {
        [parameter setObject:@"0" forKey:@"type"];
        [parameter setObject:[NSString stringWithFormat:@"%ld", (long)_model.idId] forKey:@"newsId"];
    } else {
    }
    switch (commentTag) {
        case 0: {
        } break;
        case 1: {
            [parameter setObject:[dictP objectForKey:@"parentId"] forKey:@"parentId"];
            [parameter setObject:[dictP objectForKey:@"toUserid"] forKey:@"toUserid"];
            [parameter setObject:[dictP objectForKey:@"toUsername"] forKey:@"toUsername"];
        } break;
        case 2: {
            [parameter setObject:[dictP objectForKey:@"parentId"] forKey:@"parentId"];
            [parameter setObject:[dictP objectForKey:@"toUserid"] forKey:@"toUserid"];
            [parameter setObject:[dictP objectForKey:@"toUsername"] forKey:@"toUsername"];
        } break;
        default:
            break;
    }
    NSString *content = _textView.text;
    [parameter setObject:content forKey:@"content"];
    [RLSLodingAnimateView showLodingView];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post"
        WithParamaters:parameter
        PathUrlL:[NSString stringWithFormat:@"%@%@", APPDELEGATE.url_Server, url_addComment]
        ArrayFile:nil
        Start:^(id requestOrignal) {
        }
        End:^(id responseOrignal) {
        }
        Success:^(id responseResult, id responseOrignal) {
            [RLSLodingAnimateView dissMissLoadingView];
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                _textView.text = nil;
                _currentTextViewText = nil;
                if (_typeTuijianDetailHeader == typeTuijianDetailHeaderCellDanchang) {
                    _model.comment_count = _model.comment_count + 1;
                    _labCommentNum.text = [NSString stringWithFormat:@"%ld", (long)_model.like_count];
                    _labComment.selected = _model.liked;
                } else {
                }
                [self.view endEditing:YES];
                [self loadDataWhetherFirst:NO];
            } else {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
                [self.view endEditing:YES];
            }
        }
        Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
            [self.view endEditing:YES];
            [RLSLodingAnimateView dissMissLoadingView];
        }];
}
- (void)addLiked:(UIButton *)btn {
    if (![RLSMethods login]) {
        [RLSMethods toLogin];
        return;
    }
    if (btn.tag == 1) {
        if (_model.liked == YES) {
            return;
        }
        if (_model.hated == YES) {
            return;
        }
    } else if (btn.tag == 2) {
        if (_model.liked == YES) {
            return;
        }
        if (_model.hated == YES) {
            return;
        }
    }
    NSMutableDictionary *paremeter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [paremeter setObject:@"1" forKey:@"type"];
    [paremeter setObject:[NSString stringWithFormat:@"%ld", (long)_model.idId] forKey:@"targetId"];
    [paremeter setObject:[NSString stringWithFormat:@"%ld", (long)btn.tag] forKey:@"lclass"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post"
        WithParamaters:paremeter
        PathUrlL:[NSString stringWithFormat:@"%@%@", APPDELEGATE.url_Server, url_likeAdd]
        ArrayFile:nil
        Start:^(id requestOrignal) {
        }
        End:^(id responseOrignal) {
        }
        Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                if ((NSInteger)[[responseOrignal objectForKey:@"data"] integerValue] > 0) {
                    if (btn.tag == 1) {
                        _labComment.selected = YES;
                        _model.like_count = _model.like_count + 1;
                        _model.liked = YES;
                        _labCommentNum.text = [NSString stringWithFormat:@"%ld", (long)_model.like_count];
                    } else {
                        _labComment1.selected = YES;
                        _model.hate_count = _model.hate_count + 1;
                        _model.hated = YES;
                        _labCommentNum1.text = [NSString stringWithFormat:@"%ld", (long)_model.hate_count];
                    }
                } else {
                }
            } else {
            }
        }
        Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark------------
- (void)buyActionWithOption:(NSMutableArray *)dataArray {
    NSMutableArray *array = [NSMutableArray new];
    for (NSInteger i = 0; i < dataArray.count; i++) {
        NSDictionary *typeDic = dataArray[i];
        NSInteger type = [typeDic[@"type"] integerValue];
        NSString *text = typeDic[@"text"];
        NSString *icon = nil;
        switch (type) {
            case 0: {
                icon = @"appicon";
            } break;
            case 1: {
                icon = @"wxicon";
            } break;
            case 2: {
                icon = @"aliicon";
            } break;
            case 3: {
                icon = @"coupon";
            } break;
            default:
                break;
        }
        [array addObject:@{ PayMentLeftIcon : icon,
                            PayMentTitle : text,
                            PayMentType : @(type) }];
    }
    [array removeLastObject];
    __weak RLSTuijianDetailVC *weakSelf = self;
    [RLSSelectPayMentView showPaymentInfo:[NSString stringWithFormat:@"￥%@", PARAM_IS_NIL_ERROR(@"18")]
                                  options:array
                               animations:YES
                             selectOption:^(payMentType type) {
                                 switch (type) {
                                     case payMentTypeApplePurchase: {
                                         [weakSelf appleBuyWithData];
                                     } break;
                                     case payMentTypeWx: {
                                         [weakSelf tencentBuyWithData];
                                     } break;
                                     case payMentTypeAli: {
                                         [weakSelf alibuyWithData];
                                     } break;
                                     case payMentTypeCoupon: {
                                     } break;
                                     default:
                                         break;
                                 }
                             }];
}
- (void)tencentBuyWithData {
    [RLSLodingAnimateView showLodingView];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@(_modelId) forKey:@"outerId"];
    [parameter setObject:@"1" forKey:@"oType"];
    [parameter setObject:@"IOS" forKey:@"resource"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post"
        WithParamaters:parameter
        PathUrlL:[NSString stringWithFormat:@"%@%@", APPDELEGATE.url_Server, url_appPayW]
        ArrayFile:nil
        Start:^(id requestOrignal) {
        }
        End:^(id responseOrignal) {
        }
        Success:^(id responseResult, id responseOrignal) {
            [RLSLodingAnimateView dissMissLoadingView];
            NSDictionary *resultDic = (NSDictionary *)responseOrignal;
            if ([resultDic[@"code"] isEqualToString:@"200"]) {
                NSDictionary *dataDic = resultDic[@"data"];
                XHPayWxReq *req = [[XHPayWxReq alloc] init];
                req.openID = dataDic[@"appid"];
                req.partnerId = dataDic[@"partnerid"];
                req.prepayId = dataDic[@"prepayid"];
                req.nonceStr = dataDic[@"noncestr"];
                NSUInteger timStamp = [dataDic[@"timestamp"] integerValue];
                req.timeStamp = timStamp;
                req.package = dataDic[@"package"];
                req.sign = dataDic[@"sign"];
                [[XHPayKit defaultManager] wxpayOrder:req
                                            completed:^(NSDictionary *resultDict) {
                                                NSInteger code = [resultDict[@"errCode"] integerValue];
                                                if (code == 0) {
                                                    [self paySuccess];
                                                } else {
                                                    [SVProgressHUD showSuccessWithStatus:@"购买失败"];
                                                }
                                            }];
            }
        }
        Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            [RLSLodingAnimateView dissMissLoadingView];
            [SVProgressHUD showErrorWithStatus:errorDict];
        }];
}
- (void)alibuyWithData {
    [RLSLodingAnimateView dissMissLoadingView];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@(_modelId) forKey:@"outerId"];
    [parameter setObject:@"1" forKey:@"oType"];
    [parameter setObject:@"IOS" forKey:@"resource"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post"
        WithParamaters:parameter
        PathUrlL:[NSString stringWithFormat:@"%@%@", APPDELEGATE.url_Server, url_appPayA]
        ArrayFile:nil
        Start:^(id requestOrignal) {
        }
        End:^(id responseOrignal) {
        }
        Success:^(id responseResult, id responseOrignal) {
            [RLSLodingAnimateView dissMissLoadingView];
            NSDictionary *resultDic = (NSDictionary *)responseOrignal;
            if ([resultDic[@"code"] isEqualToString:@"200"]) {
                NSString *orderSign = resultDic[@"data"];
                [[XHPayKit defaultManager] alipayOrder:orderSign
                                            fromScheme:@"com.Gunqiu.GQapp"
                                             completed:^(NSDictionary *resultDict) {
                                                 NSInteger status = [resultDict[@"resultStatus"] integerValue];
                                                 if (status == 9000) {
                                                     [self paySuccess];
                                                 } else {
                                                     [SVProgressHUD showSuccessWithStatus:@"购买失败"];
                                                 }
                                             }];
            }
        }
        Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            [RLSLodingAnimateView dissMissLoadingView];
            [SVProgressHUD showErrorWithStatus:errorDict];
        }];
}
- (void)appleBuyWithData {
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    [self.view addSubview:hud];
    [hud show:YES];

    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@(_modelId) forKey:@"outerId"];
    RLSDCHttpRequest *httpRequest = [RLSDCHttpRequest shareInstance];
    if (![RLSMethods login]) {
        httpRequest = [RLSDCHttpRequest guestInstance];
        [parameter setObject:@"106205" forKey:@"userId"];
        [parameter setObject:@"106205" forKey:@"cnickid"];
    }
    [httpRequest sendRequestByMethod:@"post"
        WithParamaters:parameter
        PathUrlL:[NSString stringWithFormat:@"%@%@", APPDELEGATE.url_Server, url_purchase_recommend]
        ArrayFile:nil
        Start:^(id requestOrignal) {
            [RLSLodingAnimateView showLodingView];
        }
        End:^(id responseOrignal) {
        }
        Success:^(id responseResult, id responseOrignal) {
            //        [self paySuccess];
            //        return;
            [RLSLodingAnimateView dissMissLoadingView];
            NSDictionary *dic = (NSDictionary *)responseOrignal;
            if (dic) {
                NSDictionary *dataDic = dic[@"data"];
                NSString *gemAmount = dataDic[@"productId"];
                gemAmount = [gemAmount stringByReplacingOccurrencesOfString:@"com.Gunqiu.GQapptuijian" withString:@""];

                NSString *productID = [NSString stringWithFormat:@"com.lineredsport.mobile.%@gems", gemAmount];
                _orderId = dataDic[@"orderId"];
                NSInteger amount = [RLSMethods amountWithProductId:productID];
                amount = amount * 100;
                [[RLSAppleIAPService sharedInstance] purchase:@{ @"product_id" : productID,
                                                                 @"orderID" : _orderId,
                                                                 @"amount" : @(amount) }
                    resultBlock:^(NSString *message, NSError *error) {
                        [hud hide:YES];
                        if (error) {
                            NSString *errMse = error.userInfo[@"NSLocalizedDescription"];
                            [SVProgressHUD showErrorWithStatus:errMse];
                        } else {
                            [self paySuccess];
                        }
                    }];
            } else {
                [hud hide:YES];
            }
        }
        Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            [RLSLodingAnimateView dissMissLoadingView];
            [hud hide:YES];
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"无法取得商品"];
        }];
}
@end
