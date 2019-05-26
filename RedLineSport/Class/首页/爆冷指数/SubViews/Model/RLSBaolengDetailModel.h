#import "RLSBasicModel.h"
#import "RLSBaolengDTModel.h"
#import "RLSBaolengMatchModel.h"
@interface RLSBaolengDetailModel : RLSBasicModel
@property (nonatomic, strong) RLSBaolengDTModel *body;
@property (nonatomic, strong) NSArray *list;
@end
