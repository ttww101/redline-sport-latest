#import "RLSPlycSelectedView.h"
@interface RLSPlycSelectedView()
@property (nonatomic, assign) NSInteger currentPlay;
@property (nonatomic, assign) NSInteger currentTime;
@property (nonatomic, strong) NSMutableArray *arrbtnPlay;
@property (nonatomic, strong) NSMutableArray *arrbtnTime;
@end
@implementation RLSPlycSelectedView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTouch)];
        [self addGestureRecognizer:tap];
        UIView *basicV = [[UIView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 112)];
        basicV.backgroundColor = [UIColor whiteColor];
        [self addSubview:basicV];
        UILabel *labPlay = [[UILabel alloc] initWithFrame:CGRectMake(17, APPDELEGATE.customTabbar.height_myNavigationBar + 9, 25, 14)];
        labPlay.textColor = [UIColor whiteColor];
        labPlay.backgroundColor = redcolor;
        labPlay.font = font10;
        labPlay.textAlignment = NSTextAlignmentCenter;
        labPlay.text  = @"玩法";
        [self addSubview:labPlay];
        UIView *viewPlay = [[UIView alloc] initWithFrame:CGRectMake(0, labPlay.bottom, Width, 33)];
        [self addSubview:viewPlay];
        NSArray *arrPlay = @[@"全部",@"竞彩",@"北单",@"足彩",];
        _arrbtnPlay = [NSMutableArray array];
        CGFloat playWidth = Width/arrPlay.count;
        for (int i = 0; i<arrPlay.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(playWidth*i, 0, playWidth, 33);
            btn.backgroundColor = [UIColor whiteColor];
            btn.titleLabel.font = font12;
            btn.tag = i;
            [btn setTitle:[arrPlay objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitle:[arrPlay objectAtIndex:i] forState:UIControlStateSelected];
            [btn setTitleColor:color33 forState:UIControlStateNormal];
            [btn setTitleColor:redcolor forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnselectedPlay:) forControlEvents:UIControlEventTouchUpInside];
            if (_currentPlay == i) {
                btn.selected = YES;
            }else{
                btn.selected = NO;
            }
            [viewPlay addSubview:btn];
            [_arrbtnPlay addObject:btn];
        }
        UIView *viewLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, 32, Width, 1)];
        viewLine1.backgroundColor = colorTableViewBackgroundColor;
        [viewPlay addSubview:viewLine1];
        UILabel *labTime = [[UILabel alloc] initWithFrame:CGRectMake(17, viewPlay.bottom + 9, 25, 14)];
        labTime.textColor = [UIColor whiteColor];
        labTime.backgroundColor = redcolor;
        labTime.font = font10;
        labTime.textAlignment = NSTextAlignmentCenter;
        labTime.text  = @"时间";
        [self addSubview:labTime];
        UIView *viewTime = [[UIView alloc] initWithFrame:CGRectMake(0, labTime.bottom, Width, 33)];
        [self addSubview:viewTime];
        NSArray *arrTime = @[@"全部",@"赛前24小时",@"赛前12小时",@"赛前6小时",@"赛前3小时",];
        _arrbtnTime = [NSMutableArray array];
        CGFloat timeWidth = Width/arrTime.count;
        for (int i = 0; i<arrTime.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(timeWidth*i, 0, timeWidth, 33);
            btn.backgroundColor = [UIColor whiteColor];
            btn.titleLabel.font = font12;
            btn.tag = i;
            [btn setTitle:[arrTime objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitle:[arrTime objectAtIndex:i] forState:UIControlStateSelected];
            [btn setTitleColor:color33 forState:UIControlStateNormal];
            [btn setTitleColor:redcolor forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnselectedTime:) forControlEvents:UIControlEventTouchUpInside];
            if (_currentTime == i) {
                btn.selected = YES;
            }else{
                btn.selected = NO;
            }
            [viewTime addSubview:btn];
            [_arrbtnTime addObject:btn];
        }
        UIView *viewLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, 32, Width, 1)];
        viewLine2.backgroundColor = colorTableViewBackgroundColor;
        [viewTime addSubview:viewLine2];
    }
    return self;
}
- (void)btnselectedPlay:(UIButton*)btn
{
    _currentPlay = btn.tag;
    for (int i = 0; i<_arrbtnPlay.count; i++) {
        UIButton *btns = [_arrbtnPlay objectAtIndex:i];
        if (btns.tag == _currentPlay) {
            btns.selected = YES;
        }else{
            btns.selected = NO;
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(didselectedPlycSelectedViewWithPlayIndex:)]) {
        [_delegate didselectedPlycSelectedViewWithPlayIndex:_currentPlay];
    }
}
- (void)btnselectedTime:(UIButton*)btn
{
    _currentTime = btn.tag;
    for (int i = 0; i<_arrbtnTime.count; i++) {
        UIButton *btns = [_arrbtnTime objectAtIndex:i];
        if (btns.tag == _currentTime) {
            btns.selected = YES;
        }else{
            btns.selected = NO;
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(didselectedPlycSelectedViewWithTimeIndex:)]) {
        [_delegate didselectedPlycSelectedViewWithTimeIndex:_currentTime];
    }
}
- (void)tapTouch
{
    if (_delegate && [_delegate respondsToSelector:@selector(touchPlycSelectedViewBGView)]) {
        [_delegate touchPlycSelectedViewBGView];
    }
}
@end
