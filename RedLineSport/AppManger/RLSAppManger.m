#import "RLSAppManger.h"
#import "RLSWebModel.h"
#import "RLSToolWebViewController.h"
#import "RLSDCTabBarController.h"
#import <YYModel/YYModel.h>
#import "ArchiveFile.h"
@interface RLSAppManger ()
@property (nonatomic , strong) UIWebView *webView;
@property (nonatomic , strong) WKWebView *wkWebView;
@property (nonatomic , strong) WebViewJavascriptBridge *bridge;
@property (nonatomic , copy) GQJSHandler gqHandler;
@end
@implementation RLSAppManger
+ (instancetype)shareInstance {
    static RLSAppManger *manger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[self alloc]init];
    });
    return manger;
}
- (void)initialize {
}
- (WebViewJavascriptBridge *)registerJSTool:(UIWebView *)webView hannle:(GQJSHandler)jsHandle {
    if (webView) {
        self.webView = webView;
    }
    if (jsHandle) {
        self.gqHandler = jsHandle;
    }
    [self initJavaScriptObservers];
    return self.bridge;
}
- (WebViewJavascriptBridge *)WK_RegisterJSTool:(WKWebView *)webView hannle:(GQJSHandler)jsHandle {
    if (webView) {
        self.wkWebView = webView;
    }
    if (jsHandle) {
        self.gqHandler = jsHandle;
    }
    [self initJavaScriptObservers];
    return self.bridge;
}
- (void)initJavaScriptObservers {
    if (self.webView) {
        self.bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    } else {
        self.bridge = [WebViewJavascriptBridge bridgeForWebView:_wkWebView];
    }
    __weak RLSAppManger *weakSelf = self;
    [self.bridge registerHandler:@"guestId" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSArray *dataArr = [[NSUserDefaults standardUserDefaults] arrayForKey:@"experts"];
        if (dataArr==nil) dataArr = @[];
        NSString *ret = [self getJSONMessage:@{@"ids":dataArr}];
        responseCallback(ret);
    }];
    [self.bridge registerHandler:@"currentPage" handler:^(id data, WVJBResponseCallback responseCallback) {
        RLSJSModel *model =  [RLSJSModel yy_modelWithDictionary:@{
                                                            @"methdName":@"currentPage:",
                                                            @"parameterData":data}];
        weakSelf.gqHandler(model, ^(id responseData) {
        });
    }];
    [self.bridge registerHandler:@"getToken" handler:^(id data, WVJBResponseCallback responseCallback) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSString *currentToken = [RLSMethods getTokenModel].token;
            NSString *valueJson = [self getJSONMessage:@{@"token":PARAM_IS_NIL_ERROR(currentToken)}];
            NSString *parameter = [self getJSONMessage:@{@"id":@"getToken", @"val":PARAM_IS_NIL_ERROR(valueJson)}];
            [weakSelf.bridge callHandler:@"jsCallBack" data:parameter responseCallback:^(id responseData) {
            }];
        });
    }];
    [self.bridge registerHandler:@"info" handler:^(id data, WVJBResponseCallback responseCallback) {
        RLSUserModel *model =[RLSMethods getUserModel];
        NSMutableArray *dataArray = [ArchiveFile getDataWithPath:Buy_Type_Path];
        NSInteger weatherShowThirdPay = 0;
        if (dataArray.count > 0) {
            weatherShowThirdPay = 1;
        }
        NSString *version = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
        NSString *sysVersion = [UIDevice currentDevice].systemVersion;
        NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        NSString *webPath = [NSString stringWithFormat:@"%@/%@", APPDELEGATE.url_ip,H5_Host];
        NSDictionary *infoDic = @{
                                  @"platform":@"1",
                                  @"visit":@(1),
                                  @"version":version,
                                  @"resource":@"iOS",
                                  @"sysVersion":sysVersion,
                                  @"uuid":idfv,
                                  @"deviceType":[RLSMethods iphoneType],
                                  @"userId": @(model.idId),
                                  @"thirdPay":@(weatherShowThirdPay),
                                  @"User-Agent": [NSString stringWithFormat:@"gqapp/%@", version],
                                  @"h5Path":webPath
                                  };
        NSString *jsonInfo = [self getJSONMessage:infoDic];
        NSString *jsonParameter = [self getJSONMessage:@{@"id":@"info", @"val":jsonInfo}];
        [weakSelf.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
        }];
    }];
    [self.bridge registerHandler:@"openH5" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        RLSWebModel *webModel = [[RLSWebModel alloc]init];
        webModel.title = dic[@"title"];
        webModel.webUrl =  dic[@"url"];
        webModel.parameter = dic[@"nav"];
        webModel.hideNavigationBar = [dic[@"nav_hidden"] integerValue];
        RLSToolWebViewController *webVC = [[RLSToolWebViewController alloc]init];
        webVC.model = webModel;
        [APPDELEGATE.customTabbar pushToViewController:webVC animated:YES];
        return ;
    }];
    [self.bridge registerHandler:@"UMAnalytics" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        [MobClick event:PARAM_IS_NIL_ERROR(dic[@"eventID"]) label:PARAM_IS_NIL_ERROR(dic[@"label"])];
    }];
    [self.bridge registerHandler:@"txtCopy" handler:^(id data, WVJBResponseCallback responseCallback) {
        UIPasteboard *paste = [UIPasteboard generalPasteboard];
        paste.string = data;
        [SVProgressHUD showSuccessWithStatus:@"复制成功"];
    }];
    
    [self.bridge registerHandler:@"getState" handler:^(id data, WVJBResponseCallback responseCallback) {
    }];
    
    [self.bridge registerHandler:@"back" handler:^(id data, WVJBResponseCallback responseCallback) {
        RLSJSModel *model =  [RLSJSModel yy_modelWithDictionary:@{
                                                            @"methdName":@"back:",
                                                            @"parameterData":data}];
        self.gqHandler(model, ^(id responseData) {
            NSString *jsonUrlPath = [self getJSONMessage:@{@"imagePath":responseData}];
            NSString *jsonParameter = [self getJSONMessage:@{@"id":@"back", @"val":jsonUrlPath}];
            [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
            }];
        });
        responseCallback(@"Response from testObjcCallback");
    }];
    
    [self.bridge registerHandler:@"dialog" handler:^(id data, WVJBResponseCallback responseCallback) {
        RLSJSModel *model =  [RLSJSModel yy_modelWithDictionary:@{
                                                            @"methdName":@"dialog:",
                                                            @"parameterData":data}];
        self.gqHandler(model, ^(id responseData) {
            NSString *jsonUrlPath = [self getJSONMessage:@{@"imagePath":responseData}];
            NSString *jsonParameter = [self getJSONMessage:@{@"id":@"back", @"val":jsonUrlPath}];
            [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
            }];
        });
    }];
    
    [self.bridge registerHandler:@"toast" handler:^(id data, WVJBResponseCallback responseCallback) {
        if (data == nil) {
            return ;
        }
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        [SVProgressHUD showInfoWithStatus:dic[@"text"]];
        [SVProgressHUD dismissWithDelay:[dic[@"time"] integerValue] / 1000];
    }];
    
    [self.bridge registerHandler:@"getResource" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"00" ofType:@"png"];
        NSURL *urlPath = [NSURL fileURLWithPath:path];
        NSString *jsonUrlPath = [self getJSONMessage:@{@"imagePath":urlPath.absoluteString}];
        NSString *jsonParameter = [self getJSONMessage:@{@"id":@"getResource", @"val":jsonUrlPath}];
        [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
        }];
    }];
    [self.bridge registerHandler:@"open" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSInteger type = [data integerValue];
        NSString *className = nil;
        if (type == 1) {
            if (![RLSMethods login]) {
                [RLSMethods toLogin];
                return;
            }
        } else if (type == 2) {
        } else if (type == 3) {
        } else if (type == 4) {
            className = @"RLSLiveQuizWithDrawalViewController";
        } else if (type == 5) {
            className = @"RLSCouponListViewController";
        }
        RLSJSModel *model =  [RLSJSModel yy_modelWithDictionary:@{
                                                            @"methdName":@"open:",
                                                            @"parameterData":className}];
        self.gqHandler(model, ^(id responseData) {
        });
        responseCallback(@"Response from testObjcCallback");
    }];
    [self.bridge registerHandler:@"share" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSString *title = dic[@"title"];
        NSString *picurl = dic[@"picurl"];
        NSString *des = dic[@"des"];
        NSString *linkurl = dic[@"linkurl"];
        NSString *type = PARAM_IS_NIL_ERROR(dic[@"type"]);
        if (!(type.length > 0)) {
            type = @"link";
        }
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            switch (platformType) {
                case UMSocialPlatformType_Sina: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_Sina]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装新浪客户端"];
                        return ;
                    }
                }
                    break;
                case UMSocialPlatformType_WechatSession: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatSession]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装微信客户端"];
                        return ;
                    }
                }
                    break;
                case UMSocialPlatformType_WechatTimeLine: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatTimeLine]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装微信客户端"];
                        return ;
                    }
                }
                    break;
                case UMSocialPlatformType_QQ: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_QQ]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装QQ客户端"];
                        return ;
                    }
                }
                    break;
                case UMSocialPlatformType_Qzone: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_Qzone]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装QQ客户端"];
                        return ;
                    }
                }
                    break;
                default:
                    break;
            }
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            if ([type isEqualToString:@"link"]) {
                UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:des thumImage:picurl];
                shareObject.webpageUrl = linkurl;
                messageObject.shareObject = shareObject;
            } else if ([type isEqualToString:@"pic"]) {
                UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
                shareObject.thumbImage = [UIImage imageNamed:@"icon"];
                [shareObject setShareImage:picurl];
                messageObject.shareObject = shareObject;
            } else if ([type isEqualToString:@"richText"]) {
                messageObject.text = title;
                UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
                shareObject.thumbImage = [UIImage imageNamed:@"icon"];
                [shareObject setShareImage:picurl];
                messageObject.shareObject = shareObject;
            }
            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[RLSMethods help_getCurrentVC] completion:^(id data, NSError *error) {
                if (error) {
                    NSString *jsonParameter = [self getJSONMessage:@{@"id":@"shareFailed", @"val":@(platformType)}];
                    [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
                    }];
                }else{
                    NSString *jsonParameter = [self getJSONMessage:@{@"id":@"shareSuccess", @"val":@(platformType)}];
                    [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
                    }];
                }
            }];
        }];
        return;
    }];
    [self.bridge registerHandler:@"toLogin" handler:^(id data, WVJBResponseCallback responseCallback) {
        if (![RLSMethods login]) {
            [RLSMethods toLogin];
        }
        RLSJSModel *model =  [RLSJSModel yy_modelWithDictionary:@{
                                                            @"methdName":@"toLogin:",
                                                            @"parameterData":@{@"type":@"123"}}];
        weakSelf.gqHandler(model, ^(id responseData) {
        });
    }];
    [self.bridge registerHandler:@"payAction" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        RLSJSModel *model =  [RLSJSModel yy_modelWithDictionary:@{
                                                            @"methdName":@"payAction:",
                                                            @"parameterData":dic}];
        weakSelf.gqHandler(model, ^(id responseData) {
        });
    }];
    [self.bridge registerHandler:@"openNative" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        RLSJSModel *model =  [RLSJSModel yy_modelWithDictionary:@{
                                                            @"methdName":@"openNative:",
                                                            @"parameterData":dic}];
        weakSelf.gqHandler(model, ^(id responseData) {
        });
    }];
    [self.bridge registerHandler:@"nav" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        RLSJSModel *model =  [RLSJSModel yy_modelWithDictionary:@{
                                                           @"methdName":@"nav:",
                                                           @"parameterData":dic}];
        weakSelf.gqHandler(model, ^(id responseData) {
        });
    }];
    [self.bridge registerHandler:@"pay" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        RLSJSModel *model =  [RLSJSModel yy_modelWithDictionary:@{
                                                            @"methdName":@"pay:",
                                                            @"parameterData":dic}];
        self.gqHandler(model, ^(id responseData) {
            if ([responseData integerValue] == 1) {
                NSString *jsonParameter = [self getJSONMessage:@{@"id":@"paySuccess", @"val":@(1)}];
                [weakSelf.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
                }];
            } else {
                NSString *jsonParameter = [self getJSONMessage:@{@"id":@"payFailed", @"val":@(0)}];
                [weakSelf.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
                }];
            }
        });
    }];
    [self.bridge registerHandler:@"closeWin" handler:^(id data, WVJBResponseCallback responseCallback) {
        RLSJSModel *model =  [RLSJSModel yy_modelWithDictionary:@{
                                                            @"methdName":@"closeWin:",
                                                            @"parameterData":@{@"type":@"123"}}];
        weakSelf.gqHandler(model, ^(id responseData) {
        });
    }];
    
    [self.bridge registerHandler:@"openBrowser" handler:^(id data, WVJBResponseCallback responseCallback) {
        if (data) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data]];
        } else {
            [SVProgressHUD showErrorWithStatus:@"地址错误"];
        }
    }];
    
    [self.bridge registerHandler:@"webStorage" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if ([dic isKindOfClass:NSClassFromString(@"NSDictionary")]) {
            [[NSUserDefaults standardUserDefaults]setObject:dic[@"storageValue"] forKey:dic[@"storageKey"]];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
    }];
    
    [self.bridge registerHandler:@"getStorage" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *jsonData = [[NSUserDefaults standardUserDefaults]objectForKey:PARAM_IS_NIL_ERROR(data)];
        NSString *jsonParameter = [self getJSONMessage:@{@"id":@"getStorageData", @"val":PARAM_IS_NIL_ERROR(jsonData)}];
        [weakSelf.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
            
        }];
    }];
    
    [self.bridge registerHandler:@"removeStorage" handler:^(id data, WVJBResponseCallback responseCallback) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:PARAM_IS_NIL_ERROR(data)];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }];

    [self.bridge registerHandler:@"pagetoolbar" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        RLSJSModel *model =  [RLSJSModel yy_modelWithDictionary:@{
                                                            @"methdName":@"pagetoolbar:",
                                                            @"parameterData":dic}];
        self.gqHandler(model, ^(id responseData) {
            if ([responseData integerValue] == 1) {
            } else {
            }
        });
    }];
}
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
