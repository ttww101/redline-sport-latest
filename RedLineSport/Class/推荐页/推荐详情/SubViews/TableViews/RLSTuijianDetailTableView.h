typedef NS_ENUM(NSInteger, typeTuijianDetailHeaderCell)
{
    typeTuijianDetailHeaderCellDanchang = 0,
    typeTuijianDetailHeaderCellChuanGuan = 1,
    typeTuijianDetailHeaderCellZucai = 2,
};
#import "RLSBasicTableView.h"
#import "RLSTuijiandatingModel.h"
#import "RLSpayUserModel.h"
@interface RLSTuijianDetailTableView : RLSBasicTableView
@property (nonatomic, strong) RLSTuijiandatingModel *headerModel;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, assign) typeTuijianDetailHeaderCell typeTuijianDetailHeader;
@property (nonatomic, strong) RLSTuijiandatingModel *tuijianModel;
@property (nonatomic, strong) RLSpayUserModel *payUsersModel;
@property (nonatomic ,strong) NSArray *arrPic;
@property (nonatomic , strong) NSMutableArray *recs;

@end
