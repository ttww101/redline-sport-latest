#import <Foundation/Foundation.h>
@class InfoGroupModel;
@interface RLSInfoModel : NSObject
@property (nonatomic , strong) NSMutableArray<InfoGroupModel *> *data;
@end
@interface InfoGroupModel : NSObject
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, copy) NSString *commentId;
@property (nonatomic , copy) NSString *content;
@property (nonatomic , copy) NSString *date;
@property (nonatomic, assign) NSInteger likeCount;
@property (nonatomic , copy) NSString *nickname;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) BOOL liked;
@property (nonatomic , copy) NSString *newsId;
@end
