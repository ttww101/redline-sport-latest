#import "RLSBasicModel.h"
@interface RLSPeiLvDetailModel : RLSBasicModel
@property (nonatomic, strong) NSString           *HappenTime;
@property (nonatomic, strong) NSString           *Score;
@property (nonatomic, strong) NSString           *HomeOdds;
@property (nonatomic, strong) NSString           *PanKou;
@property (nonatomic, strong) NSString           *AwayOdds;
@property (nonatomic, strong) NSString           *ModifyTime;
@property (nonatomic, strong) NSString           *IsClosed;
@property (nonatomic, assign) NSInteger           BlackType;
@property (nonatomic, assign) NSInteger           Pankoutype;
@property (nonatomic, assign) BOOL ischangedScore;
@property (nonatomic, assign) BOOL ischangedHomeOdds;
@property (nonatomic, assign) BOOL ischangedPanKou;
@property (nonatomic, assign) BOOL ischangedAwayOdds;
@end
