#import "RLSUIAlertController+askForUser.h"
@implementation UIAlertController (askForUser)
+ (void)showWithtitle:(NSString *)title message:(NSString *)messege sure:(void(^)())sure{
    UIAlertController *alertvc = [UIAlertController alertControllerWithTitle:title message:messege preferredStyle:1];
    [alertvc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sure();
    }]];
    [alertvc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [[[[alertvc getNavigationVc] viewControllers] lastObject] presentViewController:alertvc animated:YES completion:nil];
}
- (UINavigationController *)getNavigationVc{
    UITabBarController *tab = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    UINavigationController *nav = [tab selectedViewController];
    return nav;
}
+ (void)showWithtitle:(NSString *)title targrt:(id)target message:(NSString *)messege sure:(void(^)())sure{
    UIAlertController *alertvc = [UIAlertController alertControllerWithTitle:title message:messege preferredStyle:1];
    [alertvc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sure();
    }]];
    [alertvc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [target presentViewController:alertvc animated:YES completion:nil];
}
+ (void)showWithtitle:(NSString *)title targrt:(id)target message:(NSString *)messege sureTitle:(NSString *)sureTitle cancelTitle:(NSString *)cancleTitle sure:(void(^)())sure cancle:(void(^)())cancle{
    UIAlertController *alertvc = [UIAlertController alertControllerWithTitle:title message:messege preferredStyle:1];
    [alertvc addAction:[UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sure();
    }]];
    [alertvc addAction:[UIAlertAction actionWithTitle:cancleTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancle();
    }]];
    [target presentViewController:alertvc animated:YES completion:nil];
}
@end
