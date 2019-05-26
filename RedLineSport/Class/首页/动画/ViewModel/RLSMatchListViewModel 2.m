#import "RLSMatchListViewModel.h"
#import <YYModel/YYModel.h>
@implementation RLSMatchListViewModel
- (void)fetchMatchDateInterfaceWithParameter:(id)parameter  callBack:(requestCallBack)response {
    NSMutableDictionary *baseParameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [RLSLodingAnimateView showLodingView];
    [[RLSDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:baseParameter PathUrlL:[NSString stringWithFormat:@"http://api.live.gunqiu.com:88/radar?action=getDayData&day=%@",parameter] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        [RLSLodingAnimateView dissMissLoadingView];
        LiveListArrayModel *model = [LiveListArrayModel yy_modelWithDictionary:responseOrignal];
        if (response) {
            response(YES, model);
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [RLSLodingAnimateView dissMissLoadingView];
        if (response) {
            response(false, errorDict);
        }
    }];
}
@end
