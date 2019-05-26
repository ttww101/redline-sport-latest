#import <UIKit/UIKit.h>
#import "RLSLiveListModel.h"
@interface RLSLiveListTableViewCell : UITableViewCell
+ (RLSLiveListTableViewCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForCell;
- (void)refreshContentData:(RLSLiveListModel *)model;
@end
