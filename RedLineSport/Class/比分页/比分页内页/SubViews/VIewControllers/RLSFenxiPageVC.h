#import "RLSBasicViewController.h"
#import "RLSViewPagerController.h"
#import "RLSLiveScoreModel.h"
@interface RLSFenxiPageVC : RLSBasicViewController
@property (nonatomic, strong) RLSLiveScoreModel *model;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger segIndex;
@end
