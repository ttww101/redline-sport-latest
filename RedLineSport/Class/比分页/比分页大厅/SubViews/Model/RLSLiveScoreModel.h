#import "RLSBasicModel.h"
@interface RLSLiveScoreModel : RLSBasicModel
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *guestOrder;
@property (nonatomic, assign) NSInteger guestRed;
@property (nonatomic, assign) NSInteger guestYellow;
@property (nonatomic, assign) NSInteger guesthalfscore;
@property (nonatomic, assign) NSInteger guestscore;
@property (nonatomic, copy) NSString *guestteam;
@property (nonatomic, assign) NSInteger guestteamid;
@property (nonatomic, copy) NSString *homeOrder;
@property (nonatomic, assign) NSInteger homeRed;
@property (nonatomic, assign) NSInteger homeYellow;
@property (nonatomic, assign) NSInteger homehalfscore;
@property (nonatomic, assign) NSInteger homescore;
@property (nonatomic, copy) NSString *hometeam;
@property (nonatomic, assign) NSInteger hometeamid;
@property (nonatomic, copy) NSString *league;
@property (nonatomic, copy) NSString *leagueColor;
@property (nonatomic, assign) NSInteger leagueId;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, assign) NSInteger matchstate;
@property (nonatomic, copy) NSString *matchtime;
@property (nonatomic, copy) NSString *matchtime2;
@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, assign) BOOL neutrality;
@property (nonatomic, copy) NSString *season;
@property (nonatomic, copy) NSString *temperature;
@property (nonatomic, copy) NSString *weather;
@property (nonatomic, copy) NSString *weathericon;
@property (nonatomic, assign) NSInteger info;
@property (nonatomic, assign) NSInteger recommand;
@property (nonatomic, copy) NSString *letgoal;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *standard;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *homeCorner;
@property (nonatomic, copy) NSString *guestCorner;
@property (nonatomic, copy) NSString *homeOrderNum;
@property (nonatomic, copy) NSString *guestOrderNum;
@property (nonatomic, assign) BOOL bgIsRed;
@property (nonatomic, assign) BOOL islive;

@end
