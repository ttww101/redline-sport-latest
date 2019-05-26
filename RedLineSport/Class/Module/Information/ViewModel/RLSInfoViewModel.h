#import <Foundation/Foundation.h>
typedef void(^requestCallBack)(BOOL isSucess, id response);
@interface RLSInfoViewModel : NSObject
- (void)fetchRecommendedReviewsWithParameter:(NSDictionary *)param
                                    callBack:(requestCallBack)response;
@end
