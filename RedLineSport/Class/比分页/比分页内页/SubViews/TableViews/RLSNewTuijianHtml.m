#import "RLSNewTuijianHtml.h"
#import "WebViewJavascriptBridge.h"
#import "RLSNewZhiShuWebVC.h"
#import "WKWebViewJavascriptBridge.h"
@interface RLSNewTuijianHtml()
@property WebViewJavascriptBridge* bridge;
@property (nonatomic, assign) NSInteger indexZhiShuNum;
@property (nonatomic, retain) NSMutableArray *arrZhiShu;
@property (nonatomic, assign) CGFloat oldContentY;
@property (nonatomic, strong) UISegmentedControl *segment;
@end
@implementation RLSNewTuijianHtml
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame: frame]) {
        self.opaque = NO;
        self.scalesPageToFit = YES;
        UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 65)];
        viewHeader.backgroundColor = [UIColor whiteColor];
        [self addSubview:viewHeader];
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"欧指",@"亚指",@"进球数",@"凯利",@"必发"]];
        _segment.frame = CGRectMake(0, 15, 60*5, 30);
        _segment.center = CGPointMake(Width/2, _segment.center.y);
        _segment.tintColor = redcolor;
            _segment.selectedSegmentIndex = 0;
        [_segment addTarget:self action:@selector(changIndex:) forControlEvents:UIControlEventValueChanged];
        [viewHeader addSubview:_segment];
        _indexZhiShuNum = 0;
        _arrZhiShu = [[NSMutableArray alloc] initWithCapacity:0];
        _bridge = [WebViewJavascriptBridge bridgeForWebView:self];
        self.backgroundColor = colorTableViewBackgroundColor;
        [_bridge registerHandler:@"zhushuList" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"%@", data);
            RLSNewZhiShuWebVC *listWeb = [[RLSNewZhiShuWebVC alloc] init];
            listWeb.dic = data;
            listWeb.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:listWeb animated:YES];
            responseCallback(@"Response from testObjcCallback");
        }];
    }
    return self;
}
- (void)setSegIndex:(NSInteger)segIndex{
    _segIndex = segIndex;
        _segment.selectedSegmentIndex = _segIndex;
}
- (void)changIndex:(UISegmentedControl *)seg
{
    [_bridge callHandler:@"zhishuindex" data:[NSString stringWithFormat:@"%ld",seg.selectedSegmentIndex] responseCallback:^(id response) {
        NSLog(@"testJavascriptHandler responded: %@", response);
    }];
}
- (void)delayMethod{
}
- (void)setModel:(RLSLiveScoreModel *)model{
    _model = model;
    [self loadZhiShu];
}
- (void)loadZhiShu{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [dict setObject:@(self.model.mid) forKey:@"sid"];
    switch (_indexZhiShuNum) {
        case 0:{
            [dict setObject:@"1" forKey:@"flag"];
        }
            break;
        case 1:{
            [dict setObject:@"2" forKey:@"flag"];
        }
            break;
        case 2:{
            [dict setObject:@"3" forKey:@"flag"];
        }
            break;
        case 3:{
            [dict setObject:@"2" forKey:@"flag"];
        }
            break;
        default:
            break;
    }
    [[RLSDCHttpRequest shareInstance] sendHtmlGetRequestByMethod:@"get" WithParamaters:dict PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,_indexZhiShuNum == 3 ? url_JiaoYiList:url_ZhiShuOuPei] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        [_arrZhiShu addObject:responseOrignal];
        if (_indexZhiShuNum == 3) {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"zhishu" ofType:@"html"];
            NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            NSString *basePath = [[NSBundle mainBundle] bundlePath];
            NSURL *baseURL = [NSURL fileURLWithPath:basePath];
            [self loadHTMLString:htmlString baseURL:baseURL];
            [_arrZhiShu addObject:[NSString stringWithFormat:@"%ld",_model.mid]];
            [_bridge callHandler:@"zhishu" data:_arrZhiShu responseCallback:^(id response) {
                NSLog(@"testJavascriptHandler responded: %@", response);
            }];
            if (self.segIndex) {
                [_bridge callHandler:@"zhishuindex" data:[NSString stringWithFormat:@"%ld",self.segIndex] responseCallback:^(id response) {
                    NSLog(@"testJavascriptHandler responded: %@", response);
                }];
            }
        }else{
            _indexZhiShuNum += 1;
            [self loadZhiShu];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
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
