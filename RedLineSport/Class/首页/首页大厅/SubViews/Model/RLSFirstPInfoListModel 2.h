#import "RLSBasicModel.h"
#import "RLSDxModel.h"
@interface RLSFirstPInfoListModel : RLSBasicModel
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *downodds;
@property (nonatomic, copy) NSString *goals;
@property (nonatomic, copy) NSString *grouping;
@property (nonatomic, copy) NSString *guestteam;
@property (nonatomic, copy) NSString *hometeam;
@property (nonatomic, copy) NSString *league;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *mtime;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *upodds;
@property (nonatomic, copy) NSString *weekDayName;
@property (nonatomic, copy) NSString *matchintro;
@property (nonatomic, assign) NSInteger choice;
@property (nonatomic, assign) NSTimeInterval createtime;
@property (nonatomic, assign) NSTimeInterval matchtime;
@property (nonatomic, assign) NSInteger guestrank;
@property (nonatomic, assign) NSInteger guestscore;
@property (nonatomic, assign) NSInteger guestteamid;
@property (nonatomic, assign) NSInteger homerank;
@property (nonatomic, assign) NSInteger homescore;
@property (nonatomic, assign) NSInteger hometeamid;
@property (nonatomic, assign) NSInteger isindex;
@property (nonatomic, assign) NSInteger leagueId;
@property (nonatomic, assign) NSInteger matchstate;
@property (nonatomic, assign) NSInteger neutrality;
@property (nonatomic, assign) NSInteger newsid;
@property (nonatomic, assign) NSInteger round;
@property (nonatomic, assign) NSInteger sid;
@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, assign) NSInteger tid;
@property (nonatomic, strong) RLSDxModel *ya;
@property (nonatomic, strong) RLSDxModel *spf;
@property (nonatomic, strong) RLSDxModel *dx;
@property (nonatomic, assign) NSInteger info;
@property (nonatomic, assign) NSInteger recommand;
@property (nonatomic, copy) NSString *matchtime2;
@end
