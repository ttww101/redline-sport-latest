#import "RLSWithdrawalModel.h"
@implementation RLSWithdrawalModel
@end
@implementation WithdrawaListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"items" : NSClassFromString(@"RLSWithdrawalModel") };
}
@end
