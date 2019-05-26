#import "RLSshowVideoView.h"
#import "RLSWebviewProgressLine.h"
@interface RLSshowVideoView () <UIWebViewDelegate>
@property (nonatomic , strong) UIWebView *webView;
@property (nonatomic , strong) RLSWebviewProgressLine *progressLine;
@property (nonatomic , strong) UILabel *recordLabel;
@end
@implementation RLSshowVideoView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setNavView];
        [self configUI];
    }
    return self;
}
- (void)setNavView {
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 64)];
    bgView.backgroundColor = redcolor;
    [self addSubview:bgView];
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, bgView.frame.size.height - 1, self.width, 1);
    layer.backgroundColor = UIColorFromRGBWithOX(0xeeeeee).CGColor;
    [bgView.layer addSublayer:layer];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"closedTuijian"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(15, 20, 44, 44);
    [bgView addSubview:btn];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"咪咕视频";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = font17;
    [bgView addSubview:titleLabel];
    self.recordLabel = titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView.mas_centerX);
        make.top.equalTo(bgView.mas_top).offset(30);
        make.left.equalTo(self.mas_left).offset(70);
        make.right.equalTo(self.mas_right).offset(-70);
    }];
    UIButton *reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reloadBtn addTarget:self action:@selector(reloadAction) forControlEvents:UIControlEventTouchUpInside];
    [reloadBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [reloadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    reloadBtn.frame = CGRectMake(self.width - 15 - 44, 20, 44, 44);
    [bgView addSubview:reloadBtn];
}
#pragma mark - Config UI
- (void)configUI {
    [self addSubview:self.webView];
    self.progressLine = [[RLSWebviewProgressLine alloc] initWithFrame:CGRectMake(0, 0, Width, 3)];
    self.progressLine.lineColor = redcolor;
    [self.webView addSubview:self.progressLine];
}
#pragma mark - Open RLSMethods
- (void)setUrl:(NSString *)url {
    _url = [url copy];
    NSURL *miguurl = [NSURL URLWithString:_url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:miguurl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:15];
    [request setValue:PARAM_IS_NIL_ERROR([RLSMethods getTokenModel].token) forHTTPHeaderField:@"token"];
    [self.webView loadRequest:request];
    self.recordLabel.text = _url;
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.progressLine startLoadingAnimation];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.progressLine endLoadingAnimation];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.progressLine endLoadingAnimation];
}
#pragma mark - Events
- (void)closeAction {
    [self removeFromSuperview];
}
- (void)reloadAction {
    [self.webView reload];
}
#pragma mark - Lazy Load
- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.width, self.height - 64)];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _webView;
}
@end
