#import "RLSBasicModel.h"
@interface RLSNavigationModel : RLSBasicModel
@property (nonatomic, retain)NSString *hometeam;
@property (nonatomic, retain)NSString *guestteam;
@property (nonatomic, retain)NSString *league;
@property (nonatomic, retain)NSString *leagueColor;
@property (nonatomic, assign)NSInteger leagueId;
@property (nonatomic, retain)NSString *matchtime;
@property (nonatomic, assign)NSInteger mid;
@property (nonatomic, assign)NSInteger hot;
@property (nonatomic, assign)NSInteger info_count;
@property (nonatomic, assign)NSInteger recommend_count;
@end
