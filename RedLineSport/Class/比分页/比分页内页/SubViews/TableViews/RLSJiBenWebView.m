#import "RLSJiBenWebView.h"
#import "WebViewJavascriptBridge.h"
#import "WKWebViewJavascriptBridge.h"
@interface RLSJiBenWebView()
@property WebViewJavascriptBridge* bridge;
@property (nonatomic, strong)NSMutableArray *arrJiBen;
@property (nonatomic, assign) NSInteger indexNum;
@property (nonatomic, assign) CGFloat oldContentY;
@end
@implementation RLSJiBenWebView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        _indexNum = 0;
        self.opaque = NO;
        self.scalesPageToFit = YES;
        _arrJiBen = [[NSMutableArray alloc] init];
        _bridge = [WebViewJavascriptBridge bridgeForWebView:self];
        self.backgroundColor = colorTableViewBackgroundColor;
        [WebViewJavascriptBridge enableLogging];
    }
    return self;
}
- (void)setModel:(RLSLiveScoreModel *)model{
    _model = model;
    [self loadFenXi];
}
- (void)loadFenXi{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [dict setObject:@(self.model.mid) forKey:@"sid"];
    switch (_indexNum) {
        case 1:{
            [dict setObject:@"5" forKey:@"flag"];
            [dict setObject:@"10" forKey:@"limit"];
        }
            break;
        case 0:{
            [dict setObject:@"0" forKey:@"flag"];
        }
            break;
        case 2:{
            [dict setObject:@"2" forKey:@"flag"];
        }
            break;
        default:
            break;
    }
    [[RLSDCHttpRequest shareInstance] sendHtmlGetRequestByMethod:@"get" WithParamaters:dict PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_RecordNearList] Start:^(id requestOrignal) {
        [RLSLodingAnimateView showLodingView];
    } End:^(id responseOrignal) {
        [RLSLodingAnimateView dissMissLoadingView];
    } Success:^(id responseResult, id responseOrignal) {
        [_arrJiBen addObject:responseOrignal];
        [_arrJiBen addObject:@{@"homeName":self.model.hometeam,@"guesName":self.model.guestteam,@"hometeamid":[NSString stringWithFormat:@"%ld",self.model.hometeamid],@"guestteamid":[NSString stringWithFormat:@"%ld",self.model.guestteamid]}];
        [self loadTongjiTezheng];
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [_arrJiBen addObject:@{@"data":@""}];
        [_arrJiBen addObject:@{@"homeName":self.model.hometeam,@"guesName":self.model.guestteam,@"hometeamid":[NSString stringWithFormat:@"%ld",self.model.hometeamid],@"guestteamid":[NSString stringWithFormat:@"%ld",self.model.guestteamid]}];
        [self loadTongjiTezheng];
    }];
}
- (void)loadTongjiTezheng
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@(_model.mid) forKey:@"matchid"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_ServerQiuTan,url_qtapi_zjtz] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        NSLog(@"%@",responseOrignal);
        [_arrJiBen addObject:responseOrignal];
        NSString* path = [[NSBundle mainBundle] pathForResource:@"fenxi" ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSString *basePath = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:basePath];
        [self loadHTMLString:htmlString baseURL:baseURL];
        [_bridge callHandler:@"tuijianPage" data:_arrJiBen responseCallback:^(id response) {
        }];
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [_arrJiBen addObject:@{@"data":@""}];
        NSString* path = [[NSBundle mainBundle] pathForResource:@"fenxi" ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSString *basePath = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:basePath];
        [self loadHTMLString:htmlString baseURL:baseURL];
        [_bridge callHandler:@"tuijianPage" data:_arrJiBen responseCallback:^(id response) {
        }];
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!_cellCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        _cellCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTableViewFrame" object:nil];
    }
}
@end
