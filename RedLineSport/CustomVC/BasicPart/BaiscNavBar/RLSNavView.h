#import <UIKit/UIKit.h>
@protocol NavViewDelegate<NSObject>
@optional
- (void)navViewTouchAnIndex:(NSInteger)index;
- (void)navViewTouchButton:(UIButton *)btn;
@end
@interface RLSNavView : UIView
@property (nonatomic, strong) UIButton *btnLeft;
@property (nonatomic, strong) UIButton *btnRight;
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UIView *viewLine;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, weak) id<NavViewDelegate> delegate;
@end
