#import "RLSBasicModel.h"
@interface RLSCommentChildModel : RLSBasicModel
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSTimeInterval createtime;
@property (nonatomic, assign) NSInteger userid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) NSInteger toUserid;
@property (nonatomic, copy) NSString *toUsername;
@property (nonatomic, assign) NSInteger Idid;
@property (nonatomic, assign) NSInteger likeCount;
@property (nonatomic, assign) NSInteger ilike;
@end
