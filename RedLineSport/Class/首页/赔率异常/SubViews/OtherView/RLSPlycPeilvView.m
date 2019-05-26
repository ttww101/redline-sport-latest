#import "RLSPlycPeilvView.h"
@interface RLSPlycPeilvView()
@property (nonatomic, strong) NSMutableArray *arrBtn;
@property (nonatomic, assign) NSInteger currentIndex;
@end
@implementation RLSPlycPeilvView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taptouch)];
        [self addGestureRecognizer:tap];
        NSArray *arrTitle = @[@"全部",@"首赔",@"次赔",@"末赔",];
        _arrBtn = [NSMutableArray array];
        for (int i = 0; i<arrTitle.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 48 + 23 + 36*i, Width, 36);
            btn.backgroundColor = [UIColor whiteColor];
            btn.titleLabel.font = font14;
            btn.tag = i;
            [btn setTitle:[arrTitle objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitle:[arrTitle objectAtIndex:i] forState:UIControlStateSelected];
            [btn setTitleColor:color33 forState:UIControlStateNormal];
            [btn setTitleColor:redcolor forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnselected:) forControlEvents:UIControlEventTouchUpInside];
            if (_currentIndex == i) {
                btn.selected = YES;
            }else{
                btn.selected = NO;
            }
            [self addSubview:btn];
            [_arrBtn addObject:btn];
            UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, btn.bottom- 1, Width, 1)];
            viewLine.backgroundColor = colorTableViewBackgroundColor;
            [self addSubview:viewLine];
        }
    }
    return self;
}
- (void)btnselected:(UIButton *)btn
{
    _currentIndex = btn.tag;
    for (int i = 0; i<_arrBtn.count; i++) {
        UIButton *btns = [_arrBtn objectAtIndex:i];
        if (btns.tag == _currentIndex) {
            btns.selected = YES;
        }else{
            btns.selected = NO;
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(didselePlycPeilvViewWithIndex:)]) {
        [_delegate didselePlycPeilvViewWithIndex:_currentIndex];
    }
}
- (void)taptouch
{
    if (_delegate && [_delegate respondsToSelector:@selector(touchPlycPeilvViewBgView)]) {
        [_delegate touchPlycPeilvViewBgView];
    }
}
@end
