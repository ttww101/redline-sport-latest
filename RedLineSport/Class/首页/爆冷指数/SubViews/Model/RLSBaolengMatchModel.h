#import "RLSBasicModel.h"
@interface RLSBaolengMatchModel : RLSBasicModel
@property (nonatomic, assign) NSTimeInterval matchtime;
@property (nonatomic, strong) NSString * FirstGuestWin;
@property (nonatomic, strong) NSString * FirstHomeWin;
@property (nonatomic, assign) NSInteger  homescore;
@property (nonatomic, assign) NSInteger  guestscore;
@property (nonatomic, strong) NSString * FirstStandoff;
@property (nonatomic, assign) NSInteger  mid;
@property (nonatomic, strong) NSString * league;
@property (nonatomic, strong) NSString * hometeam;
@property (nonatomic, assign) NSInteger  kind;
@property (nonatomic, strong) NSString * guestteam;
@end
