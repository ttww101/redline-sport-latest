#import "RLSBasicTableView.h"
#import "RLSLiveScoreModel.h"
typedef NS_ENUM(NSInteger,PeiLvCellType){
    isBeforeTwo = 0,
    isAfterTwo = 1,
};
@interface RLSPeiLvDetailVC : RLSBasicViewController
@property (nonatomic, strong) RLSLiveScoreModel                        *model;
@property (nonatomic, assign) PeiLvCellType                         PeiLvCType;
@end
