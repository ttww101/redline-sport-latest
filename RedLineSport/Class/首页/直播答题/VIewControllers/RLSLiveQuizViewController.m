#import "RLSLiveQuizViewController.h"
#import "WebViewJavascriptBridge.h"
#import "RLSLiveQuizWithDrawalViewController.h"
#import "RLSCouponListViewController.h"
#import "RLSToolWebViewController.h"
#import "RLSLiveQuizAlertView.h"
#import "RLSAppManger.h"
#import "RLSJSModel.h"
@interface RLSLiveQuizViewController () <UIWebViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic , strong) WebViewJavascriptBridge* bridge;
@property (nonatomic , copy) GQJSResponseCallback callBack;
@property (nonatomic , assign) BOOL showLoding;
@property (nonatomic , strong) RLSAppManger *manger;
@property (nonatomic , strong) UIView *toastView;
@end
@implementation RLSLiveQuizViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.showLoding = YES;
    [self configUI];
    [self loadBradgeHandler];
    [self loadData];
    __block __weak id gpsObserver;
    gpsObserver = [[NSNotificationCenter defaultCenter]addObserverForName:@"userLoginNotification" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self userLogin];
        [[NSNotificationCenter defaultCenter] removeObserver:gpsObserver];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:_model.hideNavigationBar animated:YES];
    if ([_model.title isEqualToString:@"直播答题"]) {
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    if ([_model.title isEqualToString:@"直播答题"]) {
        [[UIApplication sharedApplication] setIdleTimerDisabled:false];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - notification
- (void)userLogin {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_webView) {
            _webView = nil;
            [_webView removeFromSuperview];
        }
        [self configUI];
        [self loadBradgeHandler];
        [self loadData];
    });
}
#pragma mark - Config UI
- (void)configUI {
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.navigationItem.title = _model.title;
    adjustsScrollViewInsets_NO(self.webView.scrollView, self);
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];
}
#pragma mark - Load Data
- (void)loadData {
    if (_model) {
        self.urlPath = _model.webUrl;
        self.html5Url = _model.htmlUrl;
    }
    if (self.urlPath != nil) {
        self.urlPath = [self.urlPath stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSURL *url = [NSURL URLWithString:self.urlPath];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
        [request setValue:PARAM_IS_NIL_ERROR([RLSMethods getTokenModel].token) forHTTPHeaderField:@"token"];
        [self.webView loadRequest:request];
    } else if (self.html5Url != nil) {
        NSString* path = [[NSBundle mainBundle] pathForResource:self.html5Url ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
    }
}
- (void)loadBradgeHandler {
    __weak RLSLiveQuizViewController *weakSelf = self;
    RLSAppManger *manger = [[RLSAppManger alloc]init];
    self.bridge = [manger registerJSTool:self.webView hannle:^(id data, GQJSResponseCallback responseCallback) {
        if (responseCallback) {
            weakSelf.callBack = responseCallback;
        }
        RLSJSModel *model = (RLSJSModel *)data;
        NSString *actionString = model.methdName;
        SEL action = NSSelectorFromString(actionString);
        if ([self respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [weakSelf performSelector:action withObject:model.parameterData];
#pragma clang diagnostic pop
        }
    }];
    [self.bridge setWebViewDelegate:self];
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (self.showLoding) {
        [RLSLodingAnimateView showLodingView];
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (self.showLoding) {
        [RLSLodingAnimateView dissMissLoadingView];
    }
    [self dissMissToastView];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self createNullToastView:@"" imageName:@"nodataFirstP"];
    if (self.showLoding) {
        [RLSLodingAnimateView dissMissLoadingView];
    }
}
#pragma mark - JSHandle
- (void)back:(id)parameter {
    if ([parameter integerValue] == 0) {
        self.callBack(@"1");
        self.showLoding = false;
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)dialog:(id)parameter {
    NSData *jsonData = [parameter dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    [RLSLiveQuizAlertView showPaymentInfo:dic animations:YES selectOption:^(id selectAction) {
        if (selectAction) {
            self.callBack(@"1");
            self.showLoding = false;
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
- (void)open:(id)parameter {
    NSString *targetClass = parameter;
    Class targetCalss = NSClassFromString(targetClass);
    id target = [[targetCalss alloc] init];
    if (target == nil) {
        [SVProgressHUD showErrorWithStatus:@"暂时不能打开"];
        return;
    } else {
        [self.navigationController pushViewController:target animated:YES];
    }
}
- (void)openNative:(id)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dataDic = (NSDictionary *)data;
        NSString *className = dataDic[@"n"];
        if ([self containsClassName:className]) {
            UIViewController *controller =[self indexWithClassName:className];
            if (controller) {
                [self.navigationController popToViewController:controller animated:YES];
            } else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        } else {
            Class targetCalss = NSClassFromString(className);
            id target = [[targetCalss alloc] init];
            if (target == nil) {
                [SVProgressHUD showErrorWithStatus:@"暂时不能打开"];
                return;
            } else {
                unsigned int outCount = 0;
                NSMutableArray *keyArray = [NSMutableArray array];
                objc_property_t *propertys = class_copyPropertyList([targetCalss class], &outCount);
                for (unsigned int i = 0; i < outCount; i ++) {
                    objc_property_t property = propertys[i];
                    NSString * propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
                    [keyArray addObject:propertyName];
                }
                free(propertys);
                NSDictionary *parameterDic = dataDic[@"v"];
                if (parameterDic.allKeys.count > 0) {
                    NSArray *array = parameterDic.allKeys;
                    for (NSInteger i = 0; i < array.count; i++) {
                        NSString *key = array[i];
                        if ([keyArray containsObject:key]) {
                            [target setValue:parameterDic[key] forKey:key];
                        }
                    }
                }
                [self.navigationController pushViewController:target animated:YES];
            }
        }
    }
}
- (BOOL)containsClassName:(NSString *)className {
    NSArray *classArray = self.navigationController.viewControllers;
    Class targetClass = NSClassFromString(className);
    for (UIViewController *control in classArray) {
        if (control.class == targetClass) {
            return YES;
        } else {
            return false;
        }
    }
    return false;
}
- (id)indexWithClassName:(NSString *)className {
    NSArray *classArray = self.navigationController.viewControllers;
    Class targetClass = NSClassFromString(className);
    for (NSInteger i = 0; i < classArray.count; i++) {
        UIViewController *control = classArray[i];
        if (control.class == targetClass) {
            return control;
        }
    }
    return nil;
}
#pragma mark - Action
- (BOOL)panAction:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}
- (void)reloadAction {
    [self loadData];
}
#pragma mark - Private Method
- (void)createNullToastView:(NSString *)text imageName:(NSString *)imageName {
    if (!_toastView) {
        [self.navigationController setNavigationBarHidden:false animated:false];
        _toastView = [[UIView alloc]initWithFrame:self.webView.bounds];
        UIImageView *toastImageView = [UIImageView new];
        toastImageView.image = [UIImage imageNamed:imageName];
        toastImageView.contentMode = UIViewContentModeScaleToFill;
        toastImageView.userInteractionEnabled = YES;
        [_toastView addSubview:toastImageView];
        [toastImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_toastView);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reloadAction)];
        [toastImageView addGestureRecognizer:tap];
        [self.webView addSubview:_toastView];
    }
}
- (void)dissMissToastView {
    if (_toastView) {
        [_toastView removeFromSuperview];
        _toastView = nil;
        [self.navigationController setNavigationBarHidden:YES animated:false];
    }
}
#pragma mark - Lazy Load
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
        [_webView setMediaPlaybackRequiresUserAction:NO];
        [_webView setScalesPageToFit:YES];
    }
    return _webView;
}
- (RLSAppManger *)manger {
    if (_manger == nil) {
        _manger = [[RLSAppManger alloc]init];
    }
    return _manger;
}
@end
