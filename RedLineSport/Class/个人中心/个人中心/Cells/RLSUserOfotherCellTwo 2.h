#import <UIKit/UIKit.h>
@protocol UserOfotherCellTwoDelegate<NSObject>
@optional
- (void)attentionBtnClick:(UIButton *)btn;
- (void)upDownBtnClick:(BOOL)selected;
@end
@interface RLSUserOfotherCellTwo : UITableViewCell
@property (nonatomic, strong) RLSUserModel *model;
@property (nonatomic, assign) BOOL showMoreUserInfo;
@property (nonatomic, weak) id<UserOfotherCellTwoDelegate> delegate;
@end
