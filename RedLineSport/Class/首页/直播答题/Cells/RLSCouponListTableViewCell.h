#import <UIKit/UIKit.h>
#import "RLSCouponModel.h"
@interface RLSCouponListTableViewCell : UITableViewCell
+ (RLSCouponListTableViewCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForCell;
- (void)refreshContentData:(id)model;
@end
