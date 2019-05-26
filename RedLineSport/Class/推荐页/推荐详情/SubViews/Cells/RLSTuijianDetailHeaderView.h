#import <UIKit/UIKit.h>
#import "RLSTuijiandatingModel.h"
typedef NS_ENUM(NSInteger,TuijianDetailHeaderViewtype)
{
    TuijianDetailHeaderViewShowContent = 1,
    TuijianDetailHeaderViewHideContent = 0,
};
@interface RLSTuijianDetailHeaderView : UITableViewCell
@property (nonatomic, assign) CGFloat webViewHight;
@property (nonatomic) TuijianDetailHeaderViewtype type;
@property (nonatomic, strong) RLSTuijiandatingModel *model;
@end
