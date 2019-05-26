#import "RLSBasicModel.h"
#import "RLSDan_StringMatchsModel.h"
@interface RLSDan_StringGuanModel : RLSBasicModel
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, retain)NSString *index;
@property (nonatomic, retain)NSMutableArray *matchs;
@end
