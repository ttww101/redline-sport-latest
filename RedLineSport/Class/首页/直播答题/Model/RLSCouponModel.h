#import <Foundation/Foundation.h>
@interface RLSCouponModel : NSObject
@property (nonatomic , copy) NSString *beginTime;
@property (nonatomic , copy) NSString *endTime;
@property (nonatomic , copy) NSString *couponID;
@property (nonatomic , copy) NSString *price;
@property (nonatomic , copy) NSString *status;
@end
@interface CouponListModel : NSObject
@property (nonatomic , strong) NSMutableArray<RLSCouponModel *> *data;
@end
