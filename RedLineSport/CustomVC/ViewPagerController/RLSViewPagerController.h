#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ViewPagerOption) {
    ViewPagerOptionTabHeight,
    ViewPagerOptionTabOffset,
    ViewPagerOptionTabWidth,
    ViewPagerOptionTabLocation,
    ViewPagerOptionStartFromSecondTab,
    ViewPagerOptionCenterCurrentTab
};
typedef NS_ENUM(NSUInteger, ViewPagerComponent) {
    ViewPagerIndicator,
    ViewPagerTabsView,
    ViewPagerContent
};
@protocol ViewPagerDataSource;
@protocol ViewPagerDelegate;
@interface RLSViewPagerController :RLSBasicViewController  <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic, weak) id<ViewPagerDataSource> dataSource;
@property (nonatomic, weak) id<ViewPagerDelegate> delegate;
@property UIPageViewController *pageViewController;
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index;
#pragma mark ViewPagerOptions
@property CGFloat startFromSecondTab;
@property CGFloat centerCurrentTab;
#pragma mark Colors
@property UIColor *contentViewBackgroundColor;
@property (nonatomic) BOOL manualLoadData;
@property (nonatomic) BOOL scrollingLocked;
#pragma mark RLSMethods
- (void)reloadData;
@end
#pragma mark dataSource
@protocol ViewPagerDataSource <NSObject>
- (NSUInteger)numberOfTabsForViewPager:(RLSViewPagerController *)viewPager;
@optional
- (UIViewController *)viewPager:(RLSViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index;
- (UIView *)viewPager:(RLSViewPagerController *)viewPager contentViewForTabAtIndex:(NSUInteger)index;
@end
#pragma mark delegate
@protocol ViewPagerDelegate <NSObject>
@optional
- (void)viewPager:(RLSViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index;
- (CGFloat)viewPager:(RLSViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value;
- (void)setSubViewScrollStatus:(BOOL)enabled;
@end
