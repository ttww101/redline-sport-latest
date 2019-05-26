#import "RLSLodingAnimateView.h"
@interface RLSLodingAnimateView()
@property (nonatomic, strong) UIView *basicV;
@end
@implementation RLSLodingAnimateView
+ (RLSLodingAnimateView*)basicView {
    static dispatch_once_t once;
    static RLSLodingAnimateView *sharedView;
#if !defined(SV_APP_EXTENSIONS)
    dispatch_once(&once, ^{ sharedView = [[self alloc] initWithFrame:[[[UIApplication sharedApplication] delegate] window].bounds]; });
#else
    dispatch_once(&once, ^{ sharedView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
#endif
    return sharedView;
}
- (UIWindow *)frontWindow {
#if !defined(SV_APP_EXTENSIONS)
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelSupported = (window.windowLevel >= UIWindowLevelNormal && window.windowLevel <= UIWindowLevelNormal);
        if(windowOnMainScreen && windowIsVisible && windowLevelSupported) {
            return window;
        }
    }
#endif
    return nil;
}
+ (void)showLodingView
{
    [[self basicView] showAnimateView];
}
+ (void)dissMissLoadingView
{
    [[self basicView] hideAnimateView];
}
- (void)showAnimateView
{
    if (_basicV) {
        [_basicV removeFromSuperview];
        _basicV = nil;
    }
    _basicV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
    UIView *viewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
    viewBg.backgroundColor = [UIColor blackColor];
    viewBg.alpha = 0.5;
    [_basicV addSubview:viewBg];
    UIImageView *imageB = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    imageB.center = CGPointMake(Width/2, Height/2);
    imageB.image = [UIImage imageNamed:@"loadingBg"];
    [_basicV addSubview:imageB];
    UIImageView *animateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    animateImageView.center = CGPointMake(Width/2, Height/2);
    animateImageView.image = [UIImage imageNamed:@"loadingData"];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [animateImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [_basicV addSubview:animateImageView];
    _basicV.alpha = 0;
    [UIView animateWithDuration:0.1 animations:^{
        _basicV.alpha = 1;
    }];
    [[self frontWindow] addSubview:_basicV];
}
- (void)hideAnimateView
{
        [UIView animateWithDuration:0.5 animations:^{
            _basicV.alpha = 0;
        }completion:^(BOOL finished) {
            _basicV.hidden = YES;
            [_basicV removeFromSuperview];
            _basicV =nil;
        }];
}
@end
