#import <UIKit/UIKit.h>
@interface RLSHeaderTableViewCell : UITableViewCell
@property (nonatomic , copy) NSString *title;
+ (RLSHeaderTableViewCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForCell;
@end
