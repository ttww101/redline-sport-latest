#import <UIKit/UIKit.h>
#import "RLSPeiLvDetailModel.h"
@interface RLSPeiLvDetailCell : UITableViewCell
@property (nonatomic, strong) RLSPeiLvDetailModel      *modelPeiLvDetail;
@property (nonatomic, strong) NSMutableArray        *array;
@property (nonatomic, strong) UILabel           *labTeamTime;
@property (nonatomic, strong) UILabel           *labTeamScore;
@property (nonatomic, strong) UILabel           *labTeamOdds;
@property (nonatomic, strong) UILabel           *labBollScore;
@property (nonatomic, strong) UILabel           *labOddsChang;
@property (nonatomic, strong) UILabel           *labMatchTime;
@end
