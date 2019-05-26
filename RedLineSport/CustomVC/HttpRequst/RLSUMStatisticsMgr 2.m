#import "RLSUMStatisticsMgr.h"
@implementation RLSUMStatisticsMgr
IMPLEMENTATION_SINGLETON(RLSUMStatisticsMgr)
#pragma mark - ViewStatics -
- (void)viewStaticsBeginWithMarkStr:(NSString *)markStr {
    [MobClick beginLogPageView:markStr];
}
- (void)viewStaticsEndWithMarkStr:(NSString *)markStr {
    [MobClick endLogPageView:markStr];
}
#pragma mark - ClickEvent -
@end
