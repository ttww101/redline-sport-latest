#import <UIKit/UIKit.h>
#import "RLSInfoListModel.h"
@interface RLSNewQBTableViewCell : UITableViewCell
@property (nonatomic, strong) RLSInfoListModel *model;
@property (nonatomic, assign) BOOL hideBottomView;
@end
