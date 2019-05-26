#import "RLSBasicModel.h"
@interface RLSFansModel : RLSBasicModel
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, assign) NSInteger idId;
@property (nonatomic, assign) NSInteger recommend_count;
@property (nonatomic, assign) NSInteger follower_count;
@property (nonatomic, assign) NSInteger info_count;
@property (nonatomic, assign) NSInteger focus_count;
@property (nonatomic, assign) BOOL focused;
@end
