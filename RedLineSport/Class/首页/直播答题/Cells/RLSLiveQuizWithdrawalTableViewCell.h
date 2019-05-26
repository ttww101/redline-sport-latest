#import <UIKit/UIKit.h>
#import "RLSWithdrawalModel.h"
@interface RLSLiveQuizWithdrawalTableViewCell : UITableViewCell
+ (RLSLiveQuizWithdrawalTableViewCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForCell;
- (void)refreshContentData:(id)model;
@end
