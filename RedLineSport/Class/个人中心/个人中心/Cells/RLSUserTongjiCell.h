#import <UIKit/UIKit.h>
#import "RLSUserTongjiAllModel.h"
@protocol UserTongjiCellDelegate<NSObject>
@optional
- (void)didToTongjiVC;
@end
@interface RLSUserTongjiCell : UITableViewCell
@property (nonatomic, strong) RLSUserTongjiAllModel *model;
@property (nonatomic, weak) id<UserTongjiCellDelegate> delegate;
@property(nonatomic,assign)NSInteger Number;
@end
