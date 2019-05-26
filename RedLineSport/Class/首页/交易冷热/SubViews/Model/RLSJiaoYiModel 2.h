#import "RLSBasicModel.h"
@interface RLSJiaoYiModel : RLSBasicModel
@property (nonatomic, assign)NSInteger sid;
@property (nonatomic, retain)NSString *sort;
@property (nonatomic, retain)NSString *league;
@property (nonatomic, retain)NSString *mtime;
@property (nonatomic, assign)NSInteger type;
@property (nonatomic, retain)NSArray *bifa;
@property (nonatomic, retain)NSArray *deal;
@property (nonatomic, retain)NSString *maxval;
@property (nonatomic, retain)NSString *hometeam;
@property (nonatomic, retain)NSString *guestteam;
@property (nonatomic, assign)NSInteger homescore;
@property (nonatomic, assign)NSInteger guestscore;
@property (nonatomic, assign)NSInteger matchstate;
@end
