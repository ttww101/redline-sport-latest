#import "RLSGuideView.h"
@interface RLSGuideView()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL touchtoTabBar;
@end
@implementation RLSGuideView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
    }
    return self;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(Width*3, Height);
        _scrollView.pagingEnabled = YES;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width*3, Height)];
        if (isOniPhone4) {
            imageView.image = [UIImage imageNamed:@"guide4"];
            btn.frame  = CGRectMake(Width*2, Height - 120 - 80, Width, 200);
        }
        else if(isOniPhone5){
            imageView.image = [UIImage imageNamed:@"guide"];
            btn.frame  = CGRectMake(Width*2, Height - 120 - 80, Width, 200);
        }
        else if(isOniphone6){
            imageView.image = [UIImage imageNamed:@"guide"];
            btn.frame  = CGRectMake(Width*2, Height - 120 - 110, Width, 200);
        }
        else if(isOniphone6p){
            imageView.image = [UIImage imageNamed:@"guide"];
            btn.frame  = CGRectMake(Width*2, Height - 120 - 140, Width, 200);
        }
        [_scrollView addSubview:imageView];
        [btn addTarget:self action:@selector(toTabBar) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btn];
    }
    return _scrollView;
}
- (void)toTabBar
{
    if (!_touchtoTabBar) {
        _touchtoTabBar = YES;
        [UIView animateWithDuration:1 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}
@end
