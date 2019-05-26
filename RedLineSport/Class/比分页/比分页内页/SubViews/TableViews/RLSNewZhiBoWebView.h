#import <UIKit/UIKit.h>
#import "RLSLiveScoreModel.h"
#import <WebKit/WebKit.h>
@interface RLSNewZhiBoWebView : UIWebView
@property (nonatomic, strong) RLSLiveScoreModel *model;
@property (nonatomic, assign) BOOL cellCanScroll;
@end
