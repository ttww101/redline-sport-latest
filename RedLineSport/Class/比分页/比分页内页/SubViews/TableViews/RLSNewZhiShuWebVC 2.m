#import "RLSNewZhiShuWebVC.h"
#import "WebViewJavascriptBridge.h"
#import "RLSTongPeiDetailVC.h"
@interface RLSNewZhiShuWebVC ()
@property (nonatomic, strong)UIWebView *webView;
@property WebViewJavascriptBridge* bridge;
@property (nonatomic, retain)NSMutableArray *arrData;
@end
@implementation RLSNewZhiShuWebVC
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
    _arrData = [[NSMutableArray alloc] initWithCapacity:0];
    [self.view addSubview:self.webView];
    [self loadData];
}
#pragma mark -- setnavView
- (void)setNavView{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = self.dic[@"companyname"];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
    }
}
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar)];
        _webView.opaque = NO;
        _webView.scalesPageToFit = YES;
        _webView.backgroundColor = colorTableViewBackgroundColor;
        _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
        [_bridge registerHandler:@"tongpeiList" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"%@", data);
            NSDictionary *dict = (NSDictionary *)data;
            RLSTongPeiDetailVC *listWeb = [[RLSTongPeiDetailVC alloc] init];
            listWeb.scheduleId = [[dict objectForKey:@"sid"] integerValue];
            switch ([[dict objectForKey:@"flag"] integerValue]) {
                case 4:
                {
                    listWeb.pelvIndex = 0;
                }
                    break;
                case 5:
                {
                    listWeb.pelvIndex = 1;
                }
                    break;
                case 6:
                {
                    listWeb.pelvIndex = 2;
                }
                    break;
                default:
                    break;
            }
            listWeb.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:listWeb animated:YES];
            responseCallback(@"Response from testObjcCallback");
        }];
    }
    return _webView;
}
-(void)loadData{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:self.dic[@"flagid"] forKey:@"flag"];
    [parameter setObject:self.dic[@"sid"] forKey:@"sid"];
    [parameter setObject:self.dic[@"oddsid"] forKey:@"oddsid"];
    [parameter setObject:self.dic[@"companyid"] forKey:@"companyid"];
    [[RLSDCHttpRequest shareInstance] sendHtmlGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_OddsList] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"zhishu-list" ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [_webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
        [_arrData addObject:responseOrignal];
        [_arrData addObject:self.dic[@"flagid"]];
        [_arrData addObject:self.dic[@"sid"]];
        [_arrData addObject:self.dic[@"companyid"]];
        [_bridge callHandler:@"zhishulist" data:_arrData responseCallback:^(id response) {
            NSLog(@"testJavascriptHandler responded: %@", response);
        }];
        [self.webView reload];
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
