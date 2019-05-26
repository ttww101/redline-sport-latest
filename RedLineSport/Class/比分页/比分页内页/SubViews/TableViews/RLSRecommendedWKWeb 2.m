#import "RLSRecommendedWKWeb.h"
#import "WebViewJavascriptBridge.h"
#import "RLSAppManger.h"
#import <YYModel/YYModel.h>
#import "RLSToolWebViewController.h"
#import "ArchiveFile.h"
#import <WebKit/WebKit.h>
@interface RLSRecommendedWKWeb () <UIWebViewDelegate, WKUIDelegate, WKNavigationDelegate>
@property (nonatomic , copy) GQJSResponseCallback callBack;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic , strong) WebViewJavascriptBridge* bridge;
@end
@implementation RLSRecommendedWKWeb
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = colorTableViewBackgroundColor;
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, Width, 2)];
        self.progressView.progressTintColor = redcolor;
        self.progressView.trackTintColor = [UIColor clearColor];
        self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
        [self addSubview:self.progressView];
        [self loadBradgeHandler];
        [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"estimatedProgress"];
}
#pragma mark - Open Method
- (void)setModel:(RLSWebModel *)model {
    _model = model;
    [self loadData];
}
- (void)reloadData {
    NSString *jsonParameter = [self getJSONMessage:@{@"id":@"fireEvent", @"val":@"reload"}];
    [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
    }];
}
#pragma mark - Load Data
- (void)loadBradgeHandler {
    __weak RLSRecommendedWKWeb *weakSelf = self;
    RLSAppManger *manger = [[RLSAppManger alloc]init];
    WebViewJavascriptBridge* bridge = [manger WK_RegisterJSTool:self hannle:^(id data, GQJSResponseCallback responseCallback) {
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
    [bridge setWebViewDelegate:self];
    self.bridge = bridge;
}
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
        [self loadRequest:request];
    } else if (self.html5Url != nil) {
        NSString* path = [[NSBundle mainBundle] pathForResource:self.html5Url ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [self loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
    }
}
#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.estimatedProgress;
        if (self.progressView.progress == 1) {
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark - WKDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.progressView.hidden = NO;
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.progressView.hidden = YES;
    NSString *jsStr = @"function getStyle(className_){var styleSheets=window.document.styleSheets;var styleSheetsLength=styleSheets.length;for(var i=0;i<styleSheetsLength;i++){var classes=styleSheets[i].rules||styleSheets[i].cssRules;if(!classes)continue;var classesLength=classes.length;for(var x=0;x<classesLength;x++){if(classes[x].selectorText==className_){return classes[x];}}}}setTimeout(function(){getStyle('.nav span.dq') ? getStyle('.nav span.dq').style.background = '#FF8E00':0;getStyle('.playmoney')?getStyle('.playmoney').style.background = 'url(\"https://tok-fungame.github.io/img/ic_price_bg.png\")':0;getStyle('.navi span.dq').style.background = '#FF8E00';}, 500);";
    
//    NSString *jsStr = @"document.body.style.backgroundColor = 'yellow'";
    [webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {}];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    self.progressView.hidden = YES;
}
#pragma mark - JS Handle
- (void)openNative:(id)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dataDic = (NSDictionary *)data;
        NSString *className = dataDic[@"n"];
        className = [NSString stringWithFormat:@"RLS%@",className];
        if ([className isEqualToString:@"RLSGQMineViewController"]) {
            className = @"RLSMineViewController";
        }
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
            [[RLSMethods help_getCurrentVC].navigationController pushViewController:target animated:YES];
        }
    }
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
#pragma mark - Private Method
- (NSString *)getJSONMessage:(NSDictionary *)messageDic {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:messageDic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
@end
