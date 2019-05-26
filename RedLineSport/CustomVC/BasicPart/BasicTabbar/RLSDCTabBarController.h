#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString *const GQTableBarControllerName;
UIKIT_EXTERN NSString *const GQTabBarItemTitle;
UIKIT_EXTERN NSString *const GQTabBarItemImage;
UIKIT_EXTERN NSString *const GQTabBarItemSelectedImage;
UIKIT_EXTERN NSString *const GQTabBarItemLoadH5;
UIKIT_EXTERN NSString *const GQTabBarItemWbebModel;
@interface RLSDCTabBarController : UITabBarController<UITabBarControllerDelegate>
@property (nonatomic,assign)CGFloat height_myStateBar;
@property (nonatomic,assign)CGFloat height_myNavigationBar;
@property (nonatomic,assign)CGFloat height_myTabBar;
- (void)pushToViewController:(UIViewController *__nonnull)viewController animated:(BOOL)animated;
- (void)presentToViewController:(UIViewController *__nonnull)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
- (void)loadUreadNotificationNum;
- (void)loadUreadNotificationNumInMineView;
- (instancetype)initWithItemArray:(NSArray *)itemArray;
@end
