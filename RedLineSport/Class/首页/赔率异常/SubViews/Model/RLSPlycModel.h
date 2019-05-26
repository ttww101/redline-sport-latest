#import "RLSBasicModel.h"
#import "RLSPanProcessModel.h"
@interface RLSPlycModel : RLSBasicModel
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, assign) NSInteger companyId;
@property (nonatomic, strong) NSString *finalDraw;
@property (nonatomic, strong) NSString *finalLose;
@property (nonatomic, strong) NSString *finalWin;
@property (nonatomic, strong) NSString *firstDraw;
@property (nonatomic, strong) NSString *firstLose;
@property (nonatomic, strong) NSString *firstWin;
@property (nonatomic, strong) NSString *guestTeam;
@property (nonatomic, strong) NSString *homeTeam;
@property (nonatomic, strong) NSString *matchTime;
@property (nonatomic, strong) NSString *sclassName;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSString *amp;
@property (nonatomic, assign) NSInteger scheduleId;
@property (nonatomic, assign) NSInteger idId;
@property (nonatomic, strong) NSString *loseAmp;
@property (nonatomic, strong) NSString *winAmp;
@property (nonatomic, strong) NSString *drawAmp;
@property (nonatomic, assign) NSInteger matchType;
@property (nonatomic, assign) NSInteger oddType;
@property (nonatomic, assign) NSTimeInterval statisTime;
@property (nonatomic, assign) NSInteger timeType;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger changeNum;
@property (nonatomic, strong) NSArray *panProcess;
@property (nonatomic, assign) NSTimeInterval finalTime;
@property (nonatomic, assign) NSTimeInterval firstTime;
@property (nonatomic, assign) NSInteger oddsId;
@property (nonatomic, strong) NSString *finalTimeCn;
@end
