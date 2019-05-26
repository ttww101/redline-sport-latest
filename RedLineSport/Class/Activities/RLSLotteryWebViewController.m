#import "RLSLotteryWebViewController.h"
#import "ArchiveFile.h"
@interface RLSLotteryWebViewController () <UIWebViewDelegate>
@property (nonatomic , strong) NSDictionary *activityDic;
@property (nonatomic , strong) UIView *statusView;
@property (nonatomic, assign) BOOL recodLoding;
@end
@implementation RLSLotteryWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *activityArray = [ArchiveFile getDataWithPath:Activity_Path];
    for (NSDictionary *dic in activityArray) {
        if (dic[@"main"]) {
            NSDictionary *itemDic = dic[@"main"];
            self.activityDic = itemDic;
        }
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.wkWeb addSubview:self.statusView];
    [self.wkWeb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    if ([RLSMethods login]) {
        if (self.recodLoding) {
            [self.navigationController setNavigationBarHidden:false animated:YES];
        }
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType  == UIWebViewNavigationTypeOther) {
        NSString *url = request.URL.absoluteString;
        [self publicDealWithUrl:url];
    } else if (navigationType == UIWebViewNavigationTypeBackForward){
        NSString *url = request.URL.absoluteString;
        [self publicDealWithUrl:url];
    } else if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSString *url = request.URL.absoluteString;
        [self publicDealWithUrl:url];
    }
    return YES;
}
- (void)publicDealWithUrl:(NSString *)url {
    NSDictionary *pDic = self.activityDic[@"v"];
    NSString *otherUrl = pDic[@"url_match_all"];
    if (otherUrl) {
        if ([otherUrl isEqualToString:url] || [url isEqualToString:[NSString stringWithFormat:@"%@index.html",otherUrl]]) {
            [self configNav];
            [self.wkWeb.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            self.statusView.hidden = YES;
            self.recodLoding = YES;
        } else {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
            if ([RLSMethods login]) {
                [self.wkWeb.scrollView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
                self.statusView.hidden = false;
            }
        }
    }
}
#pragma mark - Private Method
- (void)configNav {
    [self.navigationController setNavigationBarHidden:false animated:false];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 18)];
    titleImageView.image = [UIImage imageNamed:@"navimage"];
    self.navigationItem.titleView = titleImageView;
}
- (void)actionBack {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Lazy Load
- (UIView *)statusView {
    if (_statusView == nil) {
        _statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 20)];
        _statusView.backgroundColor = UIColorFromRGBWithOX(0x1E88D2);
        _statusView.hidden = YES;
    }
    return _statusView;
}
@end
