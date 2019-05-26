#import "RLSBasicModel.h"
@interface RLSTongPeiMatchModel : RLSBasicModel
@property (nonatomic, strong) NSString *sclassName;
@property (nonatomic, strong) NSString *sclassColor;
@property (nonatomic, strong) NSString *matchTime;
@property (nonatomic, strong) NSString *homeTeam;
@property (nonatomic, strong) NSString *guestTeam;
@property (nonatomic, assign) NSInteger homeScore;
@property (nonatomic, assign) NSInteger guestScore;
@property (nonatomic, strong) NSString *firstWin;
@property (nonatomic, strong) NSString *firstDraw;
@property (nonatomic, strong) NSString *firstLose;
@property (nonatomic, strong) NSString *finalWin;
@property (nonatomic, strong) NSString *finalDraw;
@property (nonatomic, strong) NSString *finalLose;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *resultColor;
@end
