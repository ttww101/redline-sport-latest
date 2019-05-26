#import "RLSBasicModel.h"
#import "RLSUserTongjiModel.h"
@interface RLSUserTongjiAllModel : RLSBasicModel
@property (nonatomic, strong) RLSUserTongjiModel *month;
@property (nonatomic, strong) RLSUserTongjiModel *all;
@property (nonatomic, strong) RLSUserTongjiModel *week;
@property (nonatomic, strong) NSArray *recent;
@end
