#import "RLSBasicTableView.h"
#import "RLSPeiLvDetailModel.h"
#import "RLSLiveScoreModel.h"
typedef NS_ENUM(NSInteger,PeiLvDetailCellType){
    isDetailBeforeTwo = 0,
    isDetailAfterTwo = 1,
};
typedef NS_ENUM(NSInteger,oddsType){
    oddsTypeRangQiu = 1,
    oddsTypeDaXiao = 2,
};
typedef NS_ENUM(NSInteger,isHalfType){
    isHalfQuanChang = 0,
    isHalfBanChange = 1,
};
typedef NS_ENUM(NSInteger,jiaoQiuType){
    isJiaoQiuDaXiao = 2,
    isJiaoQiuRangFen = 1,
};
@interface RLSPeiLvDetailTableVC : RLSBasicViewController
@property (nonatomic, strong) RLSPeiLvDetailModel                      *peiLvDetailModel;
@property (nonatomic, strong) RLSLiveScoreModel                        *model;
@property (nonatomic, assign) isHalfType                            isHalfType;
@property (nonatomic, assign) oddsType                              oddsType;
@property (nonatomic, assign) jiaoQiuType                           jiaoQiuType;
@property (nonatomic, assign) PeiLvDetailCellType                   PeiLvCDetailType;
@end
