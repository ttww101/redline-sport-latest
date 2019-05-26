#import "RLSNavView.h"
@implementation RLSNavView
- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, Width, APPDELEGATE.customTabbar.height_myNavigationBar);
        self.backgroundColor = redcolor;
        [self addSubview:self.bgView];
        [self addSubview:self.btnLeft];
        [self addSubview:self.btnRight];
        [self addSubview:self.labTitle];
        [self addSubview:self.viewLine];
    }
    return self;
}
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.bounds];
        _bgView.backgroundColor = redcolor;
    }
    return _bgView;
}
- (UIButton *)btnLeft
{
    if (!_btnLeft) {
        _btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLeft.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myStateBar, APPDELEGATE.customTabbar.height_myNavigationBar -APPDELEGATE.customTabbar.height_myStateBar, APPDELEGATE.customTabbar.height_myNavigationBar -APPDELEGATE.customTabbar.height_myStateBar);
        [_btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnLeft.titleLabel.font = navFont;
        _btnLeft.tag = 1;
        [_btnLeft.titleLabel adjustsFontSizeToFitWidth];
        [_btnLeft addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLeft;
}
- (UIButton *)btnRight
{
    if (!_btnRight) {
        _btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRight.frame = CGRectMake(Width - APPDELEGATE.customTabbar.height_myNavigationBar + APPDELEGATE.customTabbar.height_myStateBar, APPDELEGATE.customTabbar.height_myStateBar, APPDELEGATE.customTabbar.height_myNavigationBar -APPDELEGATE.customTabbar.height_myStateBar, APPDELEGATE.customTabbar.height_myNavigationBar -APPDELEGATE.customTabbar.height_myStateBar);
        [_btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnRight.titleLabel.font = font14;
        _btnRight.tag = 2;
        [_btnRight.titleLabel adjustsFontSizeToFitWidth];
        [_btnRight addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRight;
}
- (UILabel *)labTitle
{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myStateBar, Width - APPDELEGATE.customTabbar.height_myNavigationBar*2, APPDELEGATE.customTabbar.height_myNavigationBar - APPDELEGATE.customTabbar.height_myStateBar)];
        _labTitle.center = CGPointMake(Width/2, _labTitle.center.y);
        _labTitle.font = navFont;
        _labTitle.textAlignment = NSTextAlignmentCenter;
        _labTitle.textColor = [UIColor whiteColor];
    }
    return _labTitle;
}
- (UIView *)viewLine
{
    if (!_viewLine) {
        _viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar -1, Width, 1)];
        _viewLine.backgroundColor = [UIColor clearColor];
    }
    return _viewLine;
}
- (void)btnClick:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(navViewTouchButton:)]) {
        [_delegate navViewTouchButton:btn];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(navViewTouchAnIndex:)]) {
        [_delegate navViewTouchAnIndex:btn.tag];
    }
}
@end
