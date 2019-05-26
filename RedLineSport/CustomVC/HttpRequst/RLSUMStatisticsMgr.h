#import <Foundation/Foundation.h>
@interface RLSUMStatisticsMgr : NSObject
INTERFACE_SINGLETON(RLSUMStatisticsMgr)
- (void)viewStaticsBeginWithMarkStr:(NSString *)markStr;
- (void)viewStaticsEndWithMarkStr:(NSString *)markStr;
@end
