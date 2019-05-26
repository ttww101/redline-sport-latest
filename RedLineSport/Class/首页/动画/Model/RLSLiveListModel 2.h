#import <Foundation/Foundation.h>
@interface RLSLiveListModel : NSObject
@property (nonatomic , copy) NSString *away;
@property (nonatomic , copy) NSString *ID;
@property (nonatomic , assign) long startTime;
@property (nonatomic , copy) NSString *event;
@property (nonatomic , copy) NSString *home;
@property (nonatomic , copy) NSString *mid;
@property (nonatomic, assign) BOOL hideBottormLine;
@property (nonatomic , copy) NSString *awayUid;
@property (nonatomic , copy) NSString *homeUid;
@property (nonatomic , copy) NSString *status;
@property (nonatomic , copy) NSString *statusImageName;
@property (nonatomic , copy) NSString *statusId;
@end
@interface LiveListArrayModel : NSObject
@property (nonatomic, strong) NSMutableArray <RLSLiveListModel *> *data;
@end
