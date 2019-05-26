#import "RLSBasicModel.h"
@interface RLSRecord_OneModel : RLSBasicModel
@property (nonatomic, assign)NSInteger sid;
@property (nonatomic, assign)NSInteger teamid;
@property (nonatomic, retain)NSString *teamname;
@property (nonatomic, retain)NSString *result;
@property (nonatomic, retain)NSString *mtime;
@property (nonatomic, retain)NSString *league;
@property (nonatomic, retain)NSString *hometeam;
@property (nonatomic, retain)NSString *guestteam;
@property (nonatomic, assign)NSInteger lost;
@property (nonatomic, assign)NSInteger mostresult;
@property (nonatomic, assign)NSInteger historymostresult;
@property (nonatomic, assign)NSInteger zou;
@property (nonatomic, retain)NSString *sort;
@property (nonatomic, retain)NSString *sortone;
@property (nonatomic, assign)NSInteger type;
@property (nonatomic, strong) NSString *win;
@property (nonatomic, strong) NSString *draw;
@property (nonatomic, strong) NSString *lose;
@end
