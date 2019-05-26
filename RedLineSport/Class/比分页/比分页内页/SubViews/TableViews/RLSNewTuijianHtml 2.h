#import <UIKit/UIKit.h>
#import "RLSLiveScoreModel.h"
#import <WebKit/WebKit.h>
@interface RLSNewTuijianHtml : UIWebView
@property (nonatomic, strong) RLSLiveScoreModel *model;
@property (nonatomic, assign) NSInteger segIndex;
@property (nonatomic, assign) BOOL cellCanScroll;
@end
