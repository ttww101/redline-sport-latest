#import <UIKit/UIKit.h>
@class RLSPageScrollView;
@protocol PageScrollViewDateSource <NSObject>
@required
- (UIView *)pageScrollView:(RLSPageScrollView *)pageScroll tableViewForIndex:(NSInteger)index;
- (NSInteger)numberOfIndexInPageSrollView:(RLSPageScrollView *)pageScroll;
@end
@protocol PageScrollViewDelegate <NSObject>
@optional
- (void)scrollToPageIndex:(NSInteger)index;
@end
@interface RLSPageScrollView : RLSDCScrollVIew
@property (nonatomic, strong) id<PageScrollViewDateSource> dateSource;
@property (nonatomic, strong) id<PageScrollViewDelegate> pageDelegate;
@property (nonatomic, assign) NSInteger selectedIndex;
- (void)reloadData;
- (void)updateSelectedIndex:(NSInteger)index;
@end
