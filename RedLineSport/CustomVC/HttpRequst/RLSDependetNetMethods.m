#import "RLSDependetNetMethods.h"
#import "PictureModel.h"
@implementation RLSDependetNetMethods
IMPLEMENTATION_SINGLETON(RLSDependetNetMethods)
#pragma mark -- 截屏分享依赖 (先上传图片)
- (void)uploadImageWithImageArr:(NSArray *)arrImage completion:(void(^)(BOOL finished,NSArray*arrUrl)) completion {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@(3) forKey:@"flag"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",@"http://mobile.gunqiu.com/interface",url_ZiXunUrl] ArrayFile:arrImage Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            NSArray *arr = [responseOrignal objectForKey:@"data"];
            NSMutableArray *arrPic = [NSMutableArray array];
            for (int i = 0; i < arr.count; i ++) {
                PictureModel *photoModel = [[PictureModel alloc] init];
                photoModel.imgthumburl = responseOrignal[@"data"][i][@"thumb"];
                photoModel.imageurl = responseOrignal[@"data"][i][@"image"];
                [arrPic addObject:photoModel];
            }
            completion(YES,arrPic);
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
            completion(NO,[NSArray array]);
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        completion(NO,[NSArray array]);
    }];
}
- (void)loadUserInfocompletion:(void(^)(RLSUserModel *userback))userBack errorMessage:(void(^)(NSString * msg)) errormsg
{
   RLSUserModel *userModel = [RLSMethods getUserModel];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)userModel.idId] forKey:@"id"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_usernewinfo] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
        [APPDELEGATE.customTabbar loadUreadNotificationNum];
    } Success:^(id responseResult, id responseOrignal) {
        NSLog(@"%@",responseOrignal);
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
          RLSUserModel  *user = [RLSUserModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            [RLSMethods updateUsetModel:user];
            userBack(user);
        }else{
            errormsg([responseOrignal objectForKey:@"msg"]);
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        errormsg(errorDict);
    }];
}
- (void)requestSameOdd_indexStart:(requestStart)start
                              End:(requestEnd)end
                          Success:(requestSuccess)success
                          Failure:(requestFailure)failure
{
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:[RLSHttpString getCommenParemeter] PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_sameOdd_index] Start:start End:end Success:success Failure:failure];
}
- (void)requestSameOdd_detailWithscheduleId:(NSString *)scheduleId
                               WithsclassId:(NSString *)sclassId
                                      Start:(requestStart)start
                                        End:(requestEnd)end
                                    Success:(requestSuccess)success
                                    Failure:(requestFailure)failure
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:scheduleId forKey:@"scheduleId"];
    [parameter setObject:sclassId forKey:@"sclassId"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_sameOdd_detail] Start:start End:end Success:success Failure:failure];
}
- (void)requeSurprisestatisWithType:(NSString *)type
                              Start:(requestStart)start
                                End:(requestEnd)end
                            Success:(requestSuccess)success
                            Failure:(requestFailure)failure;
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:type forKey:@"mtype"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_surprisestatis] Start:start End:end Success:success Failure:failure];
}
- (void)requestSurpriseWithType:(NSString *)idId
                          Start:(requestStart)start
                            End:(requestEnd)end
                        Success:(requestSuccess)success
                        Failure:(requestFailure)failure
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:idId forKey:@"id"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_surprise] Start:start End:end Success:success Failure:failure];
}
@end
