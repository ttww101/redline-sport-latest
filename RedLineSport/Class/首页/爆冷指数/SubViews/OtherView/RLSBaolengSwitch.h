#import <UIKit/UIKit.h>
@protocol BaolengSwitchDelegate<NSObject>
@optional
- (void)didSelectedBaolengSwitchIndex:(NSInteger )index;
@end
@interface RLSBaolengSwitch : UIView
@property (nonatomic, weak) id<BaolengSwitchDelegate> delegate;
- (void)setSelectedIndex:(NSInteger)index;
@end
