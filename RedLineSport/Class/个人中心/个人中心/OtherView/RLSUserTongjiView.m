#import "RLSUserTongjiView.h"
@interface RLSUserTongjiView()
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UILabel *labWinRate;
@property (nonatomic, strong) UILabel *labWinRateTitle;
@property (nonatomic, strong) UILabel *labProfite;
@property (nonatomic, strong) UILabel *labProfiteTitle;
@property (nonatomic, strong) UILabel *roundTitle;
@property (nonatomic, strong) UILabel *roundNum;
@property (nonatomic, strong) UILabel *winTitle;
@property (nonatomic, strong) UILabel *winNum;
@property (nonatomic, strong) UILabel *zouTitle;
@property (nonatomic, strong) UILabel *zouNum;
@property (nonatomic, strong) UILabel *loseTitle;
@property (nonatomic, strong) UILabel *loseNum;
@property (nonatomic, strong) UIView *viewCenter;
@property (nonatomic, strong) UIView *viewBottom;
@end
@implementation RLSUserTongjiView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.basicView];
        [self setautolayout];
    }
    return self;
}
- (void)setModel:(RLSStatisticsModel *)model
{
    _model = model;
    _labWinRate.text = [NSString stringWithFormat:@"%@%%",_model.win_rate];
    _labWinRateTitle.text = @"总胜率";
    _labProfite.text = [NSString stringWithFormat:@"%@%%",_model.profit_rate];
    _labProfiteTitle.text = @"总盈利率";
    if ([_model.win_rate floatValue]>0) {
        if ([_labWinRate.text containsString:@"."]) {
            _labWinRate.attributedText = [RLSMethods withContent:_labWinRate.text WithColorText:[_labWinRate.text substringFromIndex:_labWinRate.text.length - 3] textColor:redcolor strFont:font12];
        } else {
             _labWinRate.attributedText = [RLSMethods withContent:_labWinRate.text WithColorText:@"%" textColor:redcolor strFont:font12];
        }
        _labWinRate.textColor = redcolor;
    }else{
        if ([_labWinRate.text containsString:@"."]) {
            _labWinRate.attributedText = [RLSMethods withContent:_labWinRate.text WithColorText:[_labWinRate.text substringFromIndex:_labWinRate.text.length - 3] textColor:color99 strFont:font12];
        } else {
            _labWinRate.attributedText = [RLSMethods withContent:_labWinRate.text WithColorText:@"%" textColor:color99 strFont:font12];
        }
        _labWinRate.textColor = color99;
    }
    if ([_model.profit_rate floatValue]>0) {
        _labProfite.textColor = redcolor;
        _labProfite.attributedText = [RLSMethods withContent:_labProfite.text WithColorText:[_labProfite.text substringFromIndex:_labProfite.text.length - 3] textColor:redcolor strFont:font12];
    }else{
        _labProfite.textColor = color99;
        _labProfite.attributedText = [RLSMethods withContent:_labProfite.text WithColorText:[_labProfite.text substringFromIndex:_labProfite.text.length - 3] textColor:color99 strFont:font12];
    }
    _roundTitle.text = @"共";
    _winTitle.text = @"场，赢";
    _zouTitle.text = @"走";
    _loseTitle.text = @"输";
    _roundNum.text = [NSString stringWithFormat:@"%ld",_model.recommend_count];
    _winNum.text = [NSString stringWithFormat:@"%ld",_model.winnum];
    _zouNum.text = [NSString stringWithFormat:@"%ld",_model.recommend_count - _model.winnum -_model.losenum];
    _loseNum.text = [NSString stringWithFormat:@"%ld",_model.losenum];
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        _basicView.backgroundColor = [UIColor whiteColor];
        [_basicView addSubview:self.labWinRate];
        [_basicView addSubview:self.labWinRateTitle];
        [_basicView addSubview:self.labProfite];
        [_basicView addSubview:self.labProfiteTitle];
        [_basicView addSubview:self.roundNum];
        [_basicView addSubview:self.roundTitle];
        [_basicView addSubview:self.winTitle];
        [_basicView addSubview:self.winNum];
        [_basicView addSubview:self.zouTitle];
        [_basicView addSubview:self.zouNum];
        [_basicView addSubview:self.loseTitle];
        [_basicView addSubview:self.loseNum];
        [_basicView addSubview:self.viewCenter];
        [_basicView addSubview:self.viewBottom];
    }
    return _basicView;
}
- (UILabel *)labWinRate
{
    if (!_labWinRate) {
        _labWinRate = [[UILabel alloc] init];
        _labWinRate.font = font30;
        _labWinRate.textColor = redcolor;
    }
    return _labWinRate;
}
- (UILabel *)labWinRateTitle
{
    if (!_labWinRateTitle) {
        _labWinRateTitle = [[UILabel alloc] init];
        _labWinRateTitle.font = font12;
        _labWinRateTitle.textColor = color33;
    }
    return _labWinRateTitle;
}
- (UILabel *)labProfite
{
    if (!_labProfite) {
        _labProfite = [[UILabel alloc] init];
        _labProfite.font = font30;
        _labProfite.textColor = redcolor;
    }
    return _labProfite;
}
- (UILabel *)labProfiteTitle
{
    if (!_labProfiteTitle) {
        _labProfiteTitle = [[UILabel alloc] init];
        _labProfiteTitle.font = font12;
        _labProfiteTitle.textColor = color33;
    }
    return _labProfiteTitle;
}
- (UILabel *)roundTitle
{
    if (!_roundTitle) {
        _roundTitle = [[UILabel alloc] init];
        _roundTitle.font = font12;
        _roundTitle.textColor = color99;
    }
    return _roundTitle;
}
- (UILabel *)roundNum
{
    if (!_roundNum) {
        _roundNum = [[UILabel alloc] init];
        _roundNum.font = font12;
        _roundNum.textColor = color33;
    }
    return _roundNum;
}
- (UILabel *)winTitle
{
    if (!_winTitle) {
        _winTitle = [[UILabel alloc] init];
        _winTitle.font = font12;
        _winTitle.textColor = color99;
    }
    return _winTitle;
}
- (UILabel *)winNum
{
    if (!_winNum) {
        _winNum = [[UILabel alloc] init];
        _winNum.font = font12;
        _winNum.textColor = color33;
    }
    return _winNum;
}
- (UILabel *)zouTitle
{
    if (!_zouTitle) {
        _zouTitle = [[UILabel alloc] init];
        _zouTitle.font = font12;
        _zouTitle.textColor = color99;
    }
    return _zouTitle;
}
- (UILabel *)zouNum
{
    if (!_zouNum) {
        _zouNum = [[UILabel alloc] init];
        _zouNum.font = font12;
        _zouNum.textColor = color33;
    }
    return _zouNum;
}
- (UILabel *)loseTitle
{
    if (!_loseTitle) {
        _loseTitle = [[UILabel alloc] init];
        _loseTitle.font = font12;
        _loseTitle.textColor = color99;
    }
    return _loseTitle;
}
- (UILabel *)loseNum
{
    if (!_loseNum) {
        _loseNum = [[UILabel alloc] init];
        _loseNum.font = font12;
        _loseNum.textColor = color33;
    }
    return _loseNum;
}
- (UIView *)viewCenter
{
    if (!_viewCenter) {
        _viewCenter = [[UIView alloc] init];
        _viewCenter.backgroundColor = cellLineColor;
    }
    return _viewCenter;
}
- (UIView *)viewBottom
{
    if (!_viewBottom) {
        _viewBottom = [[UIView alloc] init];
        _viewBottom.backgroundColor = colorTableViewBackgroundColor;
    }
    return _viewBottom;
}
- (void)setautolayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    [self.labWinRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.top.equalTo(self.basicView.mas_top).offset(25);
        make.height.mas_equalTo(33);
    }];
    [self.labWinRateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labWinRate.mas_right).offset(5);
        make.bottom.equalTo(self.labWinRate.mas_bottom).offset(-3);
    }];
    [self.labProfite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(Width/2 + 15);
        make.top.equalTo(self.labWinRate.mas_top);
        make.height.equalTo(self.labWinRate.mas_height);
    }];
    [self.labProfiteTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labProfite.mas_right).offset(5);
        make.bottom.equalTo(self.labWinRate.mas_bottom).offset(-3);
    }];
    [self.roundTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.top.equalTo(self.labWinRate.mas_bottom).offset(0);
        make.height.mas_equalTo(20);
    }];
    [self.roundNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.roundTitle.mas_right).offset(0);
        make.top.equalTo(self.labWinRate.mas_bottom).offset(0);
        make.height.mas_equalTo(20);
    }];
    [self.winTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.roundNum.mas_right).offset(0);
        make.top.equalTo(self.labWinRate.mas_bottom).offset(0);
        make.height.mas_equalTo(20);
    }];
    [self.winNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.winTitle.mas_right).offset(0);
        make.top.equalTo(self.labWinRate.mas_bottom).offset(0);
        make.height.mas_equalTo(20);
    }];
    [self.zouTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.winNum.mas_right).offset(0);
        make.top.equalTo(self.labWinRate.mas_bottom).offset(0);
        make.height.mas_equalTo(20);
    }];
    [self.zouNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.zouTitle.mas_right).offset(0);
        make.top.equalTo(self.labWinRate.mas_bottom).offset(0);
        make.height.mas_equalTo(20);
    }];
    [self.loseTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.zouNum.mas_right).offset(0);
        make.top.equalTo(self.labWinRate.mas_bottom).offset(0);
        make.height.mas_equalTo(20);
    }];
    [self.loseNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loseTitle.mas_right).offset(0);
        make.top.equalTo(self.labWinRate.mas_bottom).offset(0);
        make.height.mas_equalTo(20);
    }];
    [self.viewCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.basicView.mas_centerX);
        make.centerY.equalTo(self.basicView.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(0.5, 45));
    }];
    [self.viewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.basicView.mas_bottom);
        make.left.equalTo(self.basicView.mas_left);
        make.size.mas_equalTo(CGSizeMake(Width, 10));
    }];
}
@end
