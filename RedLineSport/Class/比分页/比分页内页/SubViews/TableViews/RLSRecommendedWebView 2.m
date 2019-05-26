#import "RLSRecommendedWebView.h"
#import "WebViewJavascriptBridge.h"
#import "RLSAppManger.h"
#import <YYModel/YYModel.h>
#import "RLSToolWebViewController.h"
#import "ArchiveFile.h"
#import "RLSWebviewProgressLine.h"
#import <WebKit/WebKit.h>
@interface RLSRecommendedWebView () <UIWebViewDelegate, WKUIDelegate, WKNavigationDelegate, UIWebViewDelegate>
@property (nonatomic , copy) GQJSResponseCallback callBack;
@property (nonatomic , strong) RLSWebviewProgressLine *progressLine;
@property (nonatomic , strong) WebViewJavascriptBridge* bridge;
@end
@implementation RLSRecommendedWebView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = colorTableViewBackgroundColor;
        self.progressLine = [[RLSWebviewProgressLine alloc] initWithFrame:CGRectMake(0, 0, Width, 3)];
        self.progressLine.lineColor = redcolor;
        [self addSubview:self.progressLine];
        [self loadBradgeHandler];
    }
    return self;
}
- (void)setModel:(RLSWebModel *)model {
    _model = model;
    [self loadData];
}
-(void)downLoadWeb {
    NSURL *url=[NSURL URLWithString:_model.webUrl];
    NSError *error;
    NSString *strData=[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    NSData *data=[strData dataUsingEncoding:NSUTF8StringEncoding];
    if (data !=nil) {
        [self performSelectorOnMainThread:@selector(downLoad_completed:) withObject:data waitUntilDone:NO];
    } else {
        NSLog(@"error when download:%@",error);
    }
}
-(void)downLoad_completed:(NSData *)data{
    NSURL *url=[NSURL URLWithString:_model.webUrl];
    NSString *nameType=[self mimeType:url];
//    [self loadData:data MIMEType:nameType textEncodingName:@"UTF-8" baseURL:url];
}
- (NSString *)mimeType:(NSURL *)url {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return response.MIMEType;
}
- (void)reloadData {
    NSString *jsonParameter = [self getJSONMessage:@{@"id":@"fireEvent", @"val":@"reload"}];
    [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
    }];
}
- (void)cancleLoadData {
    if (self.isLoading) {
        [self stopLoading];
    }
}
- (void)loadBradgeHandler {
    __weak RLSRecommendedWebView *weakSelf = self;
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
        [self loadRequest:request];
    } else if (self.html5Url != nil) {
        NSString* path = [[NSBundle mainBundle] pathForResource:self.html5Url ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [self loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
    }
}
#pragma mark - JS Handle
- (void)openNative:(id)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dataDic = (NSDictionary *)data;
        NSString *className = dataDic[@"n"];
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
// WKNav
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
NSString *jsStr = @"\
function changeCSS(newCssHref, oldCssHref) {\
var oldlinks = document.getElementsByTagName(\"link\");\
var result;\
for (result = 0; result < oldlinks.length; result++) {\
if (oldlinks[result].href == oldCssHref)\
break;\
}\
\
var oldlink = document.getElementsByTagName(\"link\").item(result);\
\
var newlink = document.createElement(\"link\");\
newlink.setAttribute(\"rel\", \"stylesheet\");\
newlink.setAttribute(\"type\", \"text/css\");\
newlink.setAttribute(\"href\", newCssHref);\
\
document.getElementsByTagName(\"head\").item(0).replaceChild(newlink, oldlink);\
}\
changeCSS(\"https://tok-fungame.github.io/css/style.css\", \"https://mobile.gunqiu.com/appH5/v6/css/style.css?_=9\")\
";
    [webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {}];
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
