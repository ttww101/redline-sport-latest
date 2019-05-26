#import <UIKit/UIKit.h>
#import "RLSInfoModel.h"
@class RLSInfoTableViewCell;
@protocol InfoTableViewCellDelegate <NSObject>
- (void)tableViewCell:(RLSInfoTableViewCell *)cell likeComment:(UIButton *)comment;
- (void)tableViewCell:(RLSInfoTableViewCell *)cell moreComments:(id)moreComments;
@end
@interface RLSInfoTableViewCell : UITableViewCell
@property (nonatomic, weak) id <InfoTableViewCellDelegate> delegate;
@property (nonatomic , strong) InfoGroupModel *model;
+ (RLSInfoTableViewCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForCell;
- (void)hideMoreReply;
@end
