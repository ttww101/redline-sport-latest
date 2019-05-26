#import "RLSBasicModel.h"
@interface RLSTongPeiTJModel : RLSBasicModel
@property (nonatomic, assign) NSInteger scheduleId;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, assign) NSInteger sclassId;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) NSString *sclassName;
@property (nonatomic, strong) NSString *sclassColor;
@property (nonatomic, strong) NSString *matchTime;
@property (nonatomic, strong) NSString *homeTeam;
@property (nonatomic, strong) NSString *guestTeam;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *win;
@property (nonatomic, strong) NSString *draw;
@property (nonatomic, strong) NSString *lose;
@property (nonatomic, strong) NSString *rate;
@property (nonatomic, strong) NSString *rateDesc;
@property (nonatomic, strong) NSString *resultColor;
@end
