#import <UIKit/UIKit.h>
@class RLSHSTabBarContentView;
@protocol HSTabBarContentViewDataSource <NSObject>
@required
- (NSInteger)numberOfItemsInTabBarContentView:(RLSHSTabBarContentView *)tabBarContentView;
- (NSString *)tabBarContentView:(RLSHSTabBarContentView *)tabBarContentView titleForItemAtIndex:(NSInteger)index;
- (UIView *)tabBarContentView:(RLSHSTabBarContentView *)tabBarContentView contentViewAtIndex:(NSInteger)index;
@end
@protocol HSTabBarContentViewDelegate <NSObject>
@optional
- (CGFloat)heightForTabBarInTabBarContentView:(RLSHSTabBarContentView *)tabBarContentView;
- (UIColor *)colorForTabBarItemTextInTabBarContentView:(RLSHSTabBarContentView *)tabBarContentView;
- (UIColor *)highlightColorForTabBarItemInTabBarContentView:(RLSHSTabBarContentView *)tabBarContentView;
- (UIView *)highlightViewForTabBarItemInTabBarContentView:(RLSHSTabBarContentView *)tabBarContentView;
- (void)tabBarContentView:(RLSHSTabBarContentView *)tabBarContentView didSelectItemAtIndex:(NSInteger)index;
@end
@interface RLSHSTabBarContentView : UIView
@property (weak, nonatomic)   id<HSTabBarContentViewDataSource>     dataSource;
@property (weak, nonatomic)   id<HSTabBarContentViewDelegate>       delegate;
@property (strong, nonatomic)   UIView                              *tabBarBackgroundView;
@property (assign, nonatomic)  BOOL                                 bottomLineHide;
@property (assign, nonatomic) CGFloat                               titleFont;
@property (assign, nonatomic) NSInteger                             selectedIndex;
@property (nonatomic, assign) long   titleFlag;
- (void)realoadTabBar;
- (void)reloadData;
@end
