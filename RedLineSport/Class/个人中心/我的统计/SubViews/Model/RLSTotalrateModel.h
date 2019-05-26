#import "RLSBasicModel.h"
@interface RLSTotalrateModel : RLSBasicModel
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *unitstr;
@property (nonatomic, copy) NSString *profitRate;
@property (nonatomic, copy) NSString *winRate;
@property (nonatomic, assign) NSInteger gonum;
@property (nonatomic, assign) NSInteger losenum;
@property (nonatomic, assign) NSInteger recommendCount;
@property (nonatomic, assign) NSInteger winnum;
@end
