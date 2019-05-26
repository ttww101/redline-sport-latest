#import "RLSInfoViewModel.h"
@implementation RLSInfoViewModel
- (void)fetchRecommendedReviewsWithParameter:(NSDictionary *)param
                                    callBack:(requestCallBack)response {
    [[RLSDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:param PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,info_url] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([responseOrignal[@"code"] isEqualToString:@"200"]) {
            response(true, responseOrignal);
        } else {
             response(false, responseOrignal);
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        response(false, responseOrignal);
    }];
}
@end
