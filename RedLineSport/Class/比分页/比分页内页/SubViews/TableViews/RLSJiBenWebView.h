#import <UIKit/UIKit.h>
#import "RLSLiveScoreModel.h"
#import <WebKit/WebKit.h>
@interface RLSJiBenWebView : UIWebView
@property (nonatomic, strong) RLSLiveScoreModel *model;
@property (nonatomic, assign) BOOL cellCanScroll;
@end
