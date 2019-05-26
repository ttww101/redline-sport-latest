#import <UIKit/UIKit.h>
@protocol TongPeiSwitchDelegate<NSObject>
@optional
- (void)didSelectedIndex:(NSInteger )index;
@end
@interface RLSTongPeiSwitch : UIView
@property (nonatomic, weak) id<TongPeiSwitchDelegate> delegate;
- (void)setSelectedIndex:(NSInteger)index;
@end
