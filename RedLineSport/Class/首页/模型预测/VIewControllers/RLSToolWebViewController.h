#import <UIKit/UIKit.h>
#import "RLSWebModel.h"
#import "RLSSelectPayMentView.h"
#import "RLSBasicViewController.h"
#import <WebKit/WebKit.h>
#import "RLSFabuTuijianSelectedItemVC.h"
@interface RLSToolWebViewController : RLSBasicViewController
@property (nonatomic , strong) WKWebView *wkWeb;
@property (nonatomic, copy) NSString *webTitle;
@property (nonatomic, copy) NSString *html5Url;
@property (nonatomic, copy) NSString *urlPath;
@property (nonatomic , copy) NSDictionary *parameterDic;
@property (nonatomic , strong) RLSWebModel *model;
@property (nonatomic , strong) UIWebView *webView;
- (void)reload;
@end
