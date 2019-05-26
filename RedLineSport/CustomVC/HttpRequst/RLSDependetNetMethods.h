#import <Foundation/Foundation.h>
#import "ZLSingleton.h"
@interface RLSDependetNetMethods : NSObject
INTERFACE_SINGLETON(RLSDependetNetMethods)
- (void)uploadImageWithImageArr:(NSArray *)arrImage completion:(void(^)(BOOL finished,NSArray*arrUrl)) completion;
- (void)loadUserInfocompletion:(void(^)(RLSUserModel *userback))userBack errorMessage:(void(^)(NSString * msg)) errormsg;
- (void)requestSameOdd_indexStart:(requestStart)start
                              End:(requestEnd)end
                          Success:(requestSuccess)success
                          Failure:(requestFailure)failure;
- (void)requestSameOdd_detailWithscheduleId:(NSString *)scheduleId
                               WithsclassId:(NSString *)sclassId
                                      Start:(requestStart)start
                              End:(requestEnd)end
                          Success:(requestSuccess)success
                          Failure:(requestFailure)failure;
- (void)requeSurprisestatisWithType:(NSString *)type
                                    Start:(requestStart)start
                              End:(requestEnd)end
                          Success:(requestSuccess)success
                          Failure:(requestFailure)failure;
- (void)requestSurpriseWithType:(NSString *)idId
                          Start:(requestStart)start
                            End:(requestEnd)end
                        Success:(requestSuccess)success
                        Failure:(requestFailure)failure;
@end
