#import "RLSDCNavViewController.h"
@interface RLSDCNavViewController ()<UIGestureRecognizerDelegate, UINavigationBarDelegate>
@end
@implementation RLSDCNavViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    id target = self.interactivePopGestureRecognizer.delegate;
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
    UIView *targetView = self.interactivePopGestureRecognizer.view;
    UIPanGestureRecognizer * fullScreenGes = [[UIPanGestureRecognizer alloc]initWithTarget:target action:handler];
    fullScreenGes.delegate = self;
    [targetView addGestureRecognizer:fullScreenGes];
    [self.interactivePopGestureRecognizer setEnabled:NO];
    [self configNavigation];
}
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    BOOL shouldPop = YES;
    NSUInteger count = self.viewControllers.count;
    NSUInteger itemsCount = navigationBar.items.count;
    if(count < itemsCount){
        return shouldPop;
    }
    UIViewController *vc = self.topViewController;
    if([vc respondsToSelector:@selector(shouldPopOnBackButtonPress)]){
        shouldPop = [vc performSelector:@selector(shouldPopOnBackButtonPress)];
    }
    if(shouldPop == NO){
        [self setNavigationBarHidden:YES];
        [self setNavigationBarHidden:NO];
    }else{
        if(count >= itemsCount){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self popViewControllerAnimated: YES];
            });
        }
    }
    return shouldPop;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:gestureRecognizer.view];
    if ([[RLSMethods help_getCurrentVC].className isEqualToString:@"RLSFenxiPageVC"]) {
        return false;
    }
    if (translation.x <= 0) {
        return NO;
    }
    return self.childViewControllers.count == 1 ? NO : YES;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    UIViewController* topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Private Method
- (void)configNavigation {
    self.navigationBar.barTintColor = redcolor;
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                                     NSForegroundColorAttributeName : [UIColor whiteColor],
                                     };
    [self.navigationBar setTitleTextAttributes:textAttributes];
    self.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIImage *backImage = [[UIImage imageNamed:@"backNew"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        backButton.frame = CGRectMake(0, 0, 44, 44);
        [backButton setImage:backImage forState:UIControlStateNormal];
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backButton addTarget:self action:@selector(leftBtnItemAction) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:nil action:nil];
    }
    [super pushViewController:viewController animated:animated];
}
#pragma mark - action
- (void)leftBtnItemAction {
    [self popViewControllerAnimated:YES];
}
@end
