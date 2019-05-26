#import <UIKit/UIKit.h>
#import "RLSHSTabBarContentView.h"
@protocol SelecterDTitleViewDelegate <NSObject>
- (void)tabBarContentView:(RLSHSTabBarContentView *)tabBarContentView didSelectItemAtIndex:(NSInteger)index;
@end
@interface RLSSelectedDTitleView : UIView
@property (nonatomic, weak) id<SelecterDTitleViewDelegate>      delegate;
@end
