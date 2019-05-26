#import "RLSBasicModel.h"
@interface RLSMostModel : RLSBasicModel
@property (nonatomic, assign)NSInteger sid;
@property (nonatomic, retain)NSString *league;
@property (nonatomic, retain)NSString *hometeam;
@property (nonatomic, retain)NSString *guestteam;
@property (nonatomic, assign)NSInteger hometeamid;
@property (nonatomic, assign)NSInteger guestteamid;
@property (nonatomic, retain)NSString *teamname;
@property (nonatomic, retain)NSString *mark;
@property (nonatomic, assign)NSInteger historymostresult;
@property (nonatomic, assign)NSInteger mostresult;
@property (nonatomic, assign)NSInteger type;
@property (nonatomic, retain)NSString *sort;
@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSString *maxname;
@end
