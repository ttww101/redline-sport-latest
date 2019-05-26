#import "RLSBasicTableView.h"
#import "RLSTuijianDatingCell.h"
#import "RLSLiveScoreModel.h"
@protocol TuijianDatingTableViewDelegate <NSObject>
@optional
@end
@interface RLSTuijianDatingTableView : RLSBasicTableView
@property (nonatomic, assign) typeTuijianCell type;
@property (nonatomic, weak) id <TuijianDatingTableViewDelegate> delegateTuijianDatingTableView;
@property (nonatomic, strong) RLSLiveScoreModel *model;
@property (nonatomic, assign) BOOL hideFooter;
@property (nonatomic, assign) BOOL cellCanScroll;
@end
