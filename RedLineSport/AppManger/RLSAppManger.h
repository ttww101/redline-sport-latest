#import <Foundation/Foundation.h>
#import "RLSJSModel.h"
#import "WebViewJavascriptBridge.h"
#import <WebKit/WebKit.h>
typedef void (^GQJSResponseCallback)(id responseData);
typedef void (^GQJSHandler)(id data, GQJSResponseCallback responseCallback);
@interface RLSAppManger : NSObject
+ (instancetype)shareInstance;
- (void)initialize;
- (WebViewJavascriptBridge *)registerJSTool:(UIWebView *)webView hannle:(GQJSHandler)jsHandle;
- (WebViewJavascriptBridge *)WK_RegisterJSTool:(WKWebView *)webView hannle:(GQJSHandler)jsHandle;
@end
