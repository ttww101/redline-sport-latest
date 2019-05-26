#import "RLSTongpeiPeilvChangeTItleView.h"
@interface RLSTongpeiPeilvChangeTItleView()
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UILabel *labPeilv;
@property (nonatomic, strong) UILabel *labKaili;
@property (nonatomic, strong) UILabel *labBackRate;
@property (nonatomic, strong) UILabel *labTime;
@end
@implementation RLSTongpeiPeilvChangeTItleView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.basicView];
    }
    return self;
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
        [_basicView addSubview:self.labPeilv];
        [_basicView addSubview:self.labKaili];
        [_basicView addSubview:self.labBackRate];
        [_basicView addSubview:self.labTime];
    }
    return _basicView;
}
- (UILabel *)labPeilv
{
    if (!_labPeilv) {
        _labPeilv = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 105*Scale_Ratio_width, _basicView.height)];
        _labPeilv.font  = font12;
        _labPeilv.textColor = color99;
        _labPeilv.textAlignment = NSTextAlignmentCenter;
        _labPeilv.text = @"指数";
    }
    return _labPeilv;
}
- (UILabel *)labKaili
{
    if (!_labKaili) {
        _labKaili = [[UILabel alloc] initWithFrame:CGRectMake( _labPeilv.right,0, 105*Scale_Ratio_width, _basicView.height)];
        _labKaili.font  = font12;
        _labKaili.textColor = color99;
        _labKaili.textAlignment = NSTextAlignmentCenter;
        _labKaili.text = @"凯利指数";
    }
    return _labKaili;
}
- (UILabel *)labBackRate
{
    if (!_labBackRate) {
        _labBackRate = [[UILabel alloc] initWithFrame:CGRectMake( _labKaili.right,0, 55*Scale_Ratio_width, _basicView.height)];
        _labBackRate.font  = font12;
        _labBackRate.textColor = color99;
        _labBackRate.textAlignment = NSTextAlignmentCenter;
        _labBackRate.text = @"返还率";
    }
    return _labBackRate;
}
- (UILabel *)labTime
{
    if (!_labTime) {
        _labTime = [[UILabel alloc] initWithFrame:CGRectMake( _labBackRate.right,0, 110*Scale_Ratio_width, _basicView.height)];
        _labTime.font  = font12;
        _labTime.textColor = color99;
        _labTime.textAlignment = NSTextAlignmentCenter;
        _labTime.text = @"时间";
    }
    return _labTime;
}
@end
