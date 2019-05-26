#import <UIKit/UIKit.h>
@protocol UserTuiianViewDelegate<NSObject>
@optional
- (void)didTouchItemWithIndex:(NSInteger)index;
@end
@interface RLSUserTuiianView : UIView
@property (nonatomic, strong) RLSUserModel *model;
@property (nonatomic, weak) id<UserTuiianViewDelegate> delegate;
@property (nonatomic, strong) NSString *imageName;
@end
