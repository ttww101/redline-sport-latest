#import "RLSBasicViewController.h"
@interface RLSBasicViewController ()<UIGestureRecognizerDelegate>
@end
@implementation RLSBasicViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
