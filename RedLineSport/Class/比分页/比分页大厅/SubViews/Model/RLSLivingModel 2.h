#import "RLSBasicModel.h"
@interface RLSLivingModel : RLSBasicModel
@property (nonatomic ,assign) int code;
@property (nonatomic ,assign) int gsc;
@property (nonatomic ,assign) int guestRed;
@property (nonatomic ,assign) int guestYellow;
@property (nonatomic ,copy) NSString *half;
@property (nonatomic ,assign) int homeRed;
@property (nonatomic ,assign) int homeYellow;
@property (nonatomic ,assign) int hsc;
@property (nonatomic ,assign) int sid;
@property (nonatomic ,copy) NSString *htime;
@end
