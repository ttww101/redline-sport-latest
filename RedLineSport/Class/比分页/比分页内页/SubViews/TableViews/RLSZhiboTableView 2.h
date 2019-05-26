#import "RLSBasicTableView.h"
#import "RLSLiveScoreModel.h"
#import "SRWebSocket.h"
@interface RLSZhiboTableView : UITableView
@property (nonatomic, strong) RLSLiveScoreModel *model;
@property (nonatomic,strong) SRWebSocket*webSocket;
@property (nonatomic, assign) BOOL cellCanScroll;
- (void)addSegMent;
@end
