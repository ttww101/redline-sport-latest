#import "RLSCouponModel.h"
@implementation RLSCouponModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"couponID" : @"id"
             };
}
@end
@implementation CouponListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : NSClassFromString(@"RLSCouponModel") };
}
@end
