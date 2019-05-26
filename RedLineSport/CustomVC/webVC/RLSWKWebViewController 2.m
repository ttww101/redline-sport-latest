#define IOS8x ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
#import "RLSWKWebViewController.h"
#import <WebKit/WebKit.h>
@interface RLSWKWebViewController ()<UIWebViewDelegate,UIActionSheetDelegate,WKNavigationDelegate>
{
    RLSLMJScrollTextView * _scrollTextView1;
}
@property (nonatomic, strong) WKWebView *wkWebView;
@property (assign, nonatomic) NSUInteger loadCount;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) UIWebView *webView;
@end
@implementation RLSWKWebViewController
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
    [self setNavView];
    [self configUI];
}
#pragma mark -- setnavView
- (void)setNavView
{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    if ([RLSMethods getTextWidthSize:_strtitle strfont:font18] >(Width - 44*2 - 30*2)) {
        nav.labTitle.hidden = YES;
        _scrollTextView1 = [[RLSLMJScrollTextView alloc] initWithFrame:CGRectMake(0, 0, (Width - 44*2 - 30*2), 44) textScrollModel:LMJTextScrollContinuous direction:LMJTextScrollMoveLeft];
        _scrollTextView1.backgroundColor = [UIColor clearColor];
        [_scrollTextView1 startScrollWithText:_strtitle textColor:navTextColor font:font18];
        [nav addSubview:_scrollTextView1];
    }else{
        nav.labTitle.text = _strtitle;
    }
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    if (_showRefreshBtn) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 20)];
        imageV.center = CGPointMake(nav.btnRight.width/2, nav.btnRight.height/2);
        imageV.image = [UIImage imageNamed:@"refreshweb"];
        [nav.btnRight addSubview:imageV];
    }
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        if (self.presentingViewController) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if(index == 2){
    }
}
- (void)navViewTouchButton:(UIButton *)btn
{
    if (btn.tag == 1) {
    }else if(btn.tag == 2){
        if (_showRefreshBtn) {
            CABasicAnimation* rotationAnimation;
            rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
            rotationAnimation.duration = 1;
            rotationAnimation.cumulative = YES;
            rotationAnimation.repeatCount = 1;
            [btn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
            if (IOS8x) [self.wkWebView reload];
            else [self.webView reload];
        }
    }
}
- (void)configUI {
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, self.view.frame.size.width, 0)];
    progressView.tintColor = redcolor;
    progressView.trackTintColor = [UIColor whiteColor];
    [self.view addSubview:progressView];
    self.progressView = progressView;
    if (IOS8x) {
        WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, self.view.frame.size.width, Height -APPDELEGATE.customTabbar.height_myNavigationBar )];
        wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        wkWebView.backgroundColor = [UIColor whiteColor];
        wkWebView.navigationDelegate = self;
        [self.view insertSubview:wkWebView belowSubview:progressView];
        [wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_strurl]];
        [wkWebView loadRequest:request];
        self.wkWebView = wkWebView;
    }else {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, self.view.frame.size.width, Height -APPDELEGATE.customTabbar.height_myNavigationBar )];
        webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        webView.scalesPageToFit = YES;
        webView.backgroundColor = [UIColor whiteColor];
        webView.delegate = self;
        [self.view insertSubview:webView belowSubview:progressView];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_strurl]];
        [webView loadRequest:request];
        self.webView = webView;
    }
}
- (void)configBackItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"back"] HighImage:[UIImage imageNamed:@""] target:self action:@selector(backBtnPressed)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 18, 20);
    [btn setBackgroundImage:[UIImage imageNamed:@"refreshweb"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"refreshweb"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(rightBarButtonItem:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}
- (void)rightBarButtonItem:(UIButton *)btn
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1;
    [btn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    if (IOS8x) [self.wkWebView reload];
    else [self.webView reload];
}
#pragma mark - 普通按钮事件
- (void)backBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - wkWebView代理
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}
- (void)dealloc {
    if (IOS8x) {
        [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    }
}
#pragma mark - webView代理
- (void)setLoadCount:(NSUInteger)loadCount {
    _loadCount = loadCount;
    if (loadCount == 0) {
        self.progressView.hidden = YES;
        [self.progressView setProgress:0 animated:NO];
    }else {
        self.progressView.hidden = NO;
        CGFloat oldP = self.progressView.progress;
        CGFloat newP = (1.0 - oldP) / (loadCount + 1) + oldP;
        if (newP > 0.95) {
            newP = 0.95;
        }
        [self.progressView setProgress:newP animated:YES];
    }
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.loadCount ++;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.loadCount --;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    self.loadCount --;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
