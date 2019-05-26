#import "RLSBasicModel.h"
@interface RLSGoodsclassModel : RLSBasicModel
@property (nonatomic, copy) NSString *sclasscolor;
@property (nonatomic, copy) NSString *sclassname;
@property (nonatomic, copy) NSString *profitRate;
@property (nonatomic, copy) NSString *winRate;
@property (nonatomic, assign) NSInteger gonum;
@property (nonatomic, assign) NSInteger losenum;
@property (nonatomic, assign) NSInteger recommendCount;
@property (nonatomic, assign) NSInteger sclassid;
@property (nonatomic, assign) NSInteger winnum;
@end
