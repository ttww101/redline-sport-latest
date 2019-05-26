#import "RLSBasicModel.h"
#import "RLSStatisticsModel.h"
#import "RLSGoodPlayModel.h"
#import "RLSGoodsclassModel.h"
#import "RLSTotalrateModel.h"
#import "RLSStatisticsSectionTwoModel.h"
@interface RLSUsercatestatisModel : RLSBasicModel
@property (nonatomic, assign) NSInteger avgweeknum;
@property (nonatomic, strong) RLSStatisticsModel *userinfo;
@property (nonatomic, strong) RLSGoodPlayModel *goodplay;
@property (nonatomic, strong) RLSGoodsclassModel *goodsclass;
@property (nonatomic, strong) NSArray *totalrate;
@property (nonatomic, strong) NSArray *nearten;
@property (nonatomic, strong) NSArray *sclassStatis;
@property (nonatomic, strong) NSArray *playStatis0;
@property (nonatomic, strong) NSArray *playStatis1;
@property (nonatomic, strong) NSArray *ouPanStatis;
@property (nonatomic, strong) NSArray *playStatis2;
@property (nonatomic, strong) NSArray *yaPanStatis;
@property (nonatomic, strong) NSArray *playStatis3;
@property (nonatomic, strong) NSArray *dxPanStatis;
@property (nonatomic, strong) NSArray *timeStatis;
@property (nonatomic, strong) NSArray *monthGroup;
@property (nonatomic, strong) NSArray *weekGroup;
@end
