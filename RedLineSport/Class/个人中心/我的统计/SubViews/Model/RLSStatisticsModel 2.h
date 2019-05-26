#import "RLSBasicModel.h"
#import "RLSGoodPlayModel.h"
#import "RLSGoodsclassModel.h"
#import "RLSTuijiandatingModel.h"
#import "RLSTotalrateModel.h"
@interface RLSStatisticsModel : RLSBasicModel
@property (nonatomic, assign) NSInteger avgweeknum;
@property (nonatomic, assign) NSInteger focus_count;
@property (nonatomic, assign) NSInteger follower_count;
@property (nonatomic, assign) NSInteger gonum;
@property (nonatomic, assign) NSInteger idId;
@property (nonatomic, assign) NSInteger level_id;
@property (nonatomic, assign) NSInteger losenum;
@property (nonatomic, assign) NSInteger recommend_count;
@property (nonatomic, assign) NSInteger role_id;
@property (nonatomic, assign) NSInteger winnum;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *userinfo;
@property (nonatomic, copy) NSString *usertitle;
@property (nonatomic, copy) NSString *profit_rate;
@property (nonatomic, copy) NSString *win_rate;
@property (nonatomic, strong) RLSGoodPlayModel *goodPlay;
@property (nonatomic, strong) RLSGoodsclassModel *goodsclass;
@property (nonatomic, strong) RLSTuijiandatingModel *Recoommandmodel;
@property (nonatomic, strong) NSArray *arrNearten;
@property (nonatomic, strong) NSArray *arrTotalrate;
@property (nonatomic, strong) NSArray *arrUsertitle;
@property (nonatomic, strong) NSArray *medals;
@end
