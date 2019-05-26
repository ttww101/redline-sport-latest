#import "RLSBasicModel.h"
@interface RLSUserlistModel : RLSBasicModel
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, assign) NSInteger userid;
@property (nonatomic, assign) NSInteger newRecommendCount;
@property (nonatomic, copy) NSString *userintro;
@end
