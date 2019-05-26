#import <UIKit/UIKit.h>
#import "RLSMineModel.h"
@interface RLSMineTableViewCell : UITableViewCell
+ (RLSMineTableViewCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForCell;
- (void)refreshContentData:(RLSMineModel *)model;
@end
