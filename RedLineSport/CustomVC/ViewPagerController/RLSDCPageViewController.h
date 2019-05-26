#import "RLSBasicViewController.h"
@class RLSDCPageViewController;
#pragma mark View Pager Delegate
@protocol  DCPageViewControllerDelegate <NSObject>
@optional
-(void)viewPagerViewController:(RLSDCPageViewController *)viewPager didFinishScrollWithCurrentViewController:(UIViewController *)viewController;
-(void)viewPagerViewController:(RLSDCPageViewController *)viewPager willScrollerWithCurrentViewController:(UIViewController *)RLSViewController;
@end
#pragma mark View Pager DataSource
@protocol DCPageViewControllerDataSource <NSObject>
@required
-(NSInteger)numberViewControllersInViewPager:(RLSDCPageViewController *)viewPager;
-(UIViewController *)viewPager:(RLSDCPageViewController *)viewPager indexViewControllers:(NSInteger)index;
-(NSString *)viewPager:(RLSDCPageViewController *)viewPager titleWithIndexViewControllers:(NSInteger)index;
@optional
-(UIButton *)viewPager:(RLSDCPageViewController *)viewPager titleButtonStyle:(NSInteger)index;
-(CGFloat)heightForTitleViewPager:(RLSDCPageViewController *)viewPager;
-(UIView *)headerViewForInViewPager:(RLSDCPageViewController *)viewPager;
-(CGFloat)heightForHeaderViewPager:(RLSDCPageViewController *)viewPager;
@end
@interface RLSDCPageViewController : RLSBasicViewController
@property (nonatomic,weak) id<DCPageViewControllerDataSource> dataSource;
@property (nonatomic,weak) id<DCPageViewControllerDelegate> delegate;
-(void)reloadScrollPage;
@property(nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,assign) CGFloat lineHeight;
@property (nonatomic,assign) CGFloat lineWidth;
@property (nonatomic,strong) UIFont *titleFont;
@property (nonatomic,strong) UIColor *defaultColor;
@property (nonatomic,strong) UIColor *chooseColor;
@end
#pragma mark 标题按钮
@interface XLBasePageTitleButton : UIButton
@property (nonatomic,assign) CGFloat buttonlineHeight;
@property (nonatomic,assign) CGFloat buttonlineWidth;
@end
