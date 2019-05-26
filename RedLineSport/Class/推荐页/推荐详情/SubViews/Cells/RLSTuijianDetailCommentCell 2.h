#import <UIKit/UIKit.h>
#import "RLSCommentModel.h"
#import "RLSCommentChildModel.h"
typedef NS_ENUM(NSInteger,typeCommentCell)
{
    typeCommentCellTuijian = 0,
    typeCommentCellZixun = 1,
};
@protocol TuijianDetailCommentCellDelegate<NSObject>
@optional
- (void)didShowMoreBtn;
- (void)touchBasicViewToHideHudViewWithIdid:(NSInteger)Idid;
@end
@interface RLSTuijianDetailCommentCell : UITableViewCell
@property (nonatomic, strong) RLSCommentModel *model;
@property (nonatomic, weak) id<TuijianDetailCommentCellDelegate> delegate;
@property (nonatomic) typeCommentCell type;
- (void)hideHudView;
@end
