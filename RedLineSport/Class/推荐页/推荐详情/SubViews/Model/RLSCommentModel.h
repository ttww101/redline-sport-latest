#import "RLSBasicModel.h"
@interface RLSCommentModel : RLSBasicModel
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) NSTimeInterval createtime;
@property (nonatomic, copy) NSString *userpic;
@property (nonatomic, assign) NSInteger Idid;
@property (nonatomic, assign) NSInteger news_id;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger userid;
@property (nonatomic, assign) NSInteger likeCount;
@property (nonatomic, strong) NSArray *child;
@property (nonatomic, assign) BOOL showMoreCommentChild;
@property (nonatomic, assign) NSInteger ilike;
@end


@interface DetailGroupModel : NSObject

@property (nonatomic , copy) NSString *title;
@property (nonatomic , strong) NSMutableArray *dataList;
@property (nonatomic , assign) BOOL showVerticalLine;


@end
