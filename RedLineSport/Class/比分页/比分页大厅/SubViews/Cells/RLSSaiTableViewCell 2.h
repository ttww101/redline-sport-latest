#import <UIKit/UIKit.h>
#import "RLSLiveScoreModel.h"
#import "RLSLivingModel.h"
@interface RLSSaiTableViewCell : UITableViewCell
@property (nonatomic, strong) RLSLiveScoreModel *ScoreModel;
@property (nonatomic, assign) int peilvIndex;
@property (nonatomic, assign) int SaishiType;
@end
