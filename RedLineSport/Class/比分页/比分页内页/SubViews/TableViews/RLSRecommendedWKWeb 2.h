#import <WebKit/WebKit.h>
#import "RLSWebModel.h"
@interface RLSRecommendedWKWeb : WKWebView
@property (nonatomic, copy) NSString *html5Url;
@property (nonatomic, copy) NSString *urlPath;
@property (nonatomic , strong) RLSWebModel *model;
@property (nonatomic, assign) BOOL cellCanScroll;
- (void)reloadData;
@end
