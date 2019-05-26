#import "RLSBasicModel.h"
@interface RLSUsermarkModel : RLSBasicModel
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) BOOL isvalid;
@end
