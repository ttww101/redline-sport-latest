#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "RLSWebModel.h"
@interface RLSRecommendedWebView : WKWebView
@property (nonatomic , strong) RLSWebModel *model;
@property (nonatomic, copy) NSString *html5Url;
@property (nonatomic, copy) NSString *urlPath;
@property (nonatomic, assign) BOOL cellCanScroll;
- (void)reloadData;
- (void)cancleLoadData;
@end
