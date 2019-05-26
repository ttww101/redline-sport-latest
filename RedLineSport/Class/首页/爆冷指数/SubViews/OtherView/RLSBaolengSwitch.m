#import "RLSBaolengSwitch.h"
@interface RLSBaolengSwitch()
@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab3;
@end
@implementation RLSBaolengSwitch
- (id)init
{
    self = [super init];
    if (self) {
        UIView *basicView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 29)];
        [self addSubview:basicView];
        _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, basicView.width/3, basicView.height)];
        _lab1.textAlignment = NSTextAlignmentCenter;
        _lab1.font = font12;
        _lab1.text = @"全部";
        _lab1.layer.borderColor = colorDD.CGColor;
        _lab1.layer.borderWidth = 0.5;
        _lab1.backgroundColor = colorf5f5f5;
        _lab1.textColor = color99;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Tap)];
        [_lab1 addGestureRecognizer:tap1];
        _lab1.userInteractionEnabled = YES;
        [basicView addSubview:_lab1];
        _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(basicView.width/3 - 0.5, 0, basicView.width/3, basicView.height)];
        _lab2.textAlignment = NSTextAlignmentCenter;
        _lab2.font = font12;
        _lab2.text = @"同赛事";
        _lab2.layer.borderColor = colorDD.CGColor;
        _lab2.layer.borderWidth = 0.5;
        _lab2.backgroundColor = [UIColor whiteColor];
        _lab2.textColor = color33;
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Tap)];
        [_lab2 addGestureRecognizer:tap2];
        _lab2.userInteractionEnabled = YES;
        [basicView addSubview:_lab2];
        _lab3 = [[UILabel alloc] initWithFrame:CGRectMake(basicView.width/3*2 - 0.5, 0, basicView.width/3, basicView.height)];
        _lab3.textAlignment = NSTextAlignmentCenter;
        _lab3.font = font12;
        _lab3.text = @"历史交锋";
        _lab3.layer.borderColor = colorDD.CGColor;
        _lab3.layer.borderWidth = 0.5;
        _lab3.backgroundColor = [UIColor whiteColor];
        _lab3.textColor = color33;
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3Tap)];
        [_lab3 addGestureRecognizer:tap3];
        _lab3.userInteractionEnabled = YES;
        [basicView addSubview:_lab3];
    }
    return self;
}
- (void)tap1Tap
{
    _lab1.textColor = color99;
    _lab1.backgroundColor = colorf5f5f5;
    _lab2.textColor = color33;
    _lab2.backgroundColor = [UIColor whiteColor];
    _lab3.textColor = color33;
    _lab3.backgroundColor = [UIColor whiteColor];
    if (_delegate &&  [_delegate respondsToSelector:@selector(didSelectedBaolengSwitchIndex:)]) {
        [_delegate didSelectedBaolengSwitchIndex:0];
    }
}
- (void)tap2Tap
{
    _lab2.textColor = color99;
    _lab2.backgroundColor = colorf5f5f5;
    _lab1.textColor = color33;
    _lab1.backgroundColor = [UIColor whiteColor];
    _lab3.textColor = color33;
    _lab3.backgroundColor = [UIColor whiteColor];
    if (_delegate &&  [_delegate respondsToSelector:@selector(didSelectedBaolengSwitchIndex:)]) {
        [_delegate didSelectedBaolengSwitchIndex:1];
    }
}
- (void)tap3Tap
{
    _lab3.textColor = color99;
    _lab3.backgroundColor = colorf5f5f5;
    _lab2.textColor = color33;
    _lab2.backgroundColor = [UIColor whiteColor];
    _lab1.textColor = color33;
    _lab1.backgroundColor = [UIColor whiteColor];
    if (_delegate &&  [_delegate respondsToSelector:@selector(didSelectedBaolengSwitchIndex:)]) {
        [_delegate didSelectedBaolengSwitchIndex:2];
    }
}
- (void)setSelectedIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            _lab1.textColor = color99;
            _lab1.backgroundColor = colorf5f5f5;
            _lab2.textColor = color33;
            _lab2.backgroundColor = [UIColor whiteColor];
            _lab3.textColor = color33;
            _lab3.backgroundColor = [UIColor whiteColor];
        }
            break;
        case 1:
        {
            _lab2.textColor = color99;
            _lab2.backgroundColor = colorf5f5f5;
            _lab1.textColor = color33;
            _lab1.backgroundColor = [UIColor whiteColor];
            _lab3.textColor = color33;
            _lab3.backgroundColor = [UIColor whiteColor];
        }
            break;
        case 2:
        {
            _lab3.textColor = color99;
            _lab3.backgroundColor = colorf5f5f5;
            _lab2.textColor = color33;
            _lab2.backgroundColor = [UIColor whiteColor];
            _lab1.textColor = color33;
            _lab1.backgroundColor = [UIColor whiteColor];
        }
            break;
        default:
            break;
    }
}
@end
