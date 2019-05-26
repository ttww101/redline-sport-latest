#import <UIKit/UIKit.h>
@protocol UserOfOtherCellDelegate<NSObject>
@optional
- (void)attentionBtnClick:(UIButton *)btn;
- (void)navBtnClick:(NSInteger)index;
- (void)tuijianBtnClick:(NSInteger)index;
- (void)upDownBtnClick:(BOOL)selected;
@end
@interface RLSUserOfOtherCell : UITableViewCell
@property (nonatomic, strong) RLSUserModel *model;
@property (nonatomic, weak) id<UserOfOtherCellDelegate> delegate;
@property (nonatomic, assign) BOOL showMoreUserInfo;
@end
