#import <UIKit/UIKit.h>
#import "RLSWebModel.h"
@interface RLSLiveQuizViewController : UIViewController
@property (nonatomic, copy) NSString *webTitle;
@property (nonatomic, copy) NSString *html5Url;
@property (nonatomic, copy) NSString *urlPath;
@property (nonatomic , copy) NSDictionary *parameterDic;
@property (nonatomic , strong) RLSWebModel *model;
@end
