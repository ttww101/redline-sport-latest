#import "RLSWebView.h"
#import "WebViewJavascriptBridge.h"
#import "RLSAppManger.h"
#import <YYModel/YYModel.h>
#import "RLSToolWebViewController.h"
#import "ArchiveFile.h"
#import "RLSWebviewProgressLine.h"
@interface RLSWebView () <UIWebViewDelegate>
@property (nonatomic , copy) GQJSResponseCallback callBack;
@property (nonatomic , strong) WebViewJavascriptBridge* bridge;
@property (nonatomic , strong) RLSWebviewProgressLine *progressLine;
@end
@implementation RLSWebView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = colorTableViewBackgroundColor;
        [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
        [self becomeFirstResponder];
        [self loadBradgeHandler];
        self.progressLine = [[RLSWebviewProgressLine alloc] initWithFrame:CGRectMake(0, 0, Width, 3)];
        self.progressLine.lineColor = redcolor;
        [self addSubview:self.progressLine];
    }
    return self;
}
- (void)dealloc {
    [self resignFirstResponder];
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (void)setModel:(RLSWebModel *)model {
    _model = model;
     [self loadData];
}
- (void)reloadData {
    [self loadData];
}
- (void)jsReoload {
    NSString *jsonParameter = [self getJSONMessage:@{@"id":@"fireEvent", @"val":@"reload"}];
    [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
    }];
}
- (void)loadBradgeHandler {
    __weak RLSWebView *weakSelf = self;
    RLSAppManger *manger = [[RLSAppManger alloc]init];
    WebViewJavascriptBridge* bridge = [manger registerJSTool:self hannle:^(id data, GQJSResponseCallback responseCallback) {
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
        [self closeWin:@""];
        NSDictionary *dataDic = (NSDictionary *)data;
        NSString *className = dataDic[@"n"];
        if ([className isEqualToString:@"TuijianDetailVC"]) {
            className = @"RLSTuijianDetailVC";
        }
        if ([className isEqualToString:@"UserTuijianVC"]) {
            className = @"RLSUserTuijianVC";
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
- (void)closeWin:(id)data {
    if (_webDelegate && [_webDelegate respondsToSelector:@selector(webClose:)]) {
        [_webDelegate webClose:@"关闭"];
    }
}
- (void)toLogin:(id)data {
    [self closeWin:@""];
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
#pragma mark - ShakeToEdit 摇动手机之后的回调方法
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [self shake_start];
    }
}
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake){
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        [self shake_end];
    }
}
#pragma mark - Open Method
- (void)shake_start {
    NSString *jsonParameter = [self getJSONMessage:@{@"id":@"fireEvent", @"val":@"shake_start"}];
    [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
    }];
}
- (void)shake_end {
    NSString *jsonParameter = [self getJSONMessage:@{@"id":@"fireEvent", @"val":@"shake_end"}];
    [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
    }];
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
