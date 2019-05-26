#import "RLSBisaiTongjiCellTwo.h"
@interface RLSBisaiTongjiCellTwo ()
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, assign) BOOL isaddLayout;
@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UILabel *labhome;
@property (nonatomic,strong) UILabel *labguest;
@property (nonatomic, strong) UIView *viewTotal;
@property (nonatomic, strong) UIView *viewHome;
@property (nonatomic, strong) UIView *viewGuest;
@end
@implementation RLSBisaiTongjiCellTwo
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setModel:(RLSTechModel *)model;
{
    _model = model;
    [self.contentView addSubview:self.basicView];
    if (!_isaddLayout) {
        _isaddLayout = YES;
        [self addLayout];
    }
    _labTitle.text = _model.name;
    _labhome.text = _model.teamA;
    _labguest.text = _model.teamB;
    CGFloat color1 = [model.teamA floatValue];
    CGFloat color2 = [model.teamB floatValue];
    if ([model.name isEqualToString:@"控球率"]) {
        color1 = [[model.teamA substringToIndex:model.teamA.length-2] floatValue];
        color2 = [[model.teamB substringToIndex:model.teamB.length-2] floatValue];
    }
    CGFloat width1 = 0;
    CGFloat width2 = 0;
    if (color1 + color2 != 0) {
         width1 = color1/(color1 + color2);
         width2 = color2/(color1 + color2);
    }
    [self.viewHome mas_updateConstraints:^(MASConstraintMaker *make) {
               make.size.mas_equalTo(CGSizeMake((Width - 20 - 4)/2 - (Width - 20 - 4)/2*width2 , 4));
    }];
    [self.viewGuest mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake((Width - 20 - 4)/2 - (Width - 20 - 4)/2*width1 , 4));
    }];
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.labTitle];
        [_basicView addSubview:self.labhome];
        [_basicView addSubview:self.labguest];
        [_basicView addSubview:self.viewTotal];
        [_basicView addSubview:self.viewHome];
        [_basicView addSubview:self.viewGuest];
    }
    return _basicView;
}
- (UILabel *)labTitle
{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] init];
        _labTitle.font = font12;
        _labTitle.textColor = color99;
    }
    return _labTitle;
}
- (UILabel *)labhome
{
    if (!_labhome) {
        _labhome = [[UILabel alloc] init];
        _labhome.font = font12;
        _labhome.textColor = redcolor;
    }
    return _labhome;
}
- (UILabel *)labguest
{
    if (!_labguest) {
        _labguest = [[UILabel alloc] init];
        _labguest.font = font12;
        _labguest.textColor = bluecolor;
    }
    return _labguest;
}
- (UIView *)viewTotal
{
    if (!_viewTotal) {
        _viewTotal = [[UIView alloc] init];
        _viewTotal.backgroundColor = colorEE;
    }
    return _viewTotal;
}
- (UIView *)viewHome
{
    if (!_viewHome) {
        _viewHome = [[UIView alloc] init];
        _viewHome.backgroundColor = redcolor;
    }
    return _viewHome;
}
- (UIView *)viewGuest
{
    if (!_viewGuest) {
        _viewGuest = [[UIView alloc] init];
        _viewGuest.backgroundColor = bluecolor;
    }
    return _viewGuest;
}
- (void)addLayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
    }];
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.basicView.mas_centerX);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];
    [self.labhome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(10);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];
    [self.labguest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.basicView.mas_right).offset(-10);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];
    [self.viewTotal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.basicView.mas_bottom);
        make.centerX.equalTo(self.basicView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(Width - 20, 4));
    }];
    [self.viewHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.basicView.mas_bottom);
        make.right.equalTo(self.basicView.mas_centerX).offset(-2);
        make.size.mas_equalTo(CGSizeMake((Width - 20 - 4)/2 - (Width - 20 - 4)/2*0.5 , 4));
    }];
    [self.viewGuest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.basicView.mas_bottom);
        make.left.equalTo(self.basicView.mas_centerX).offset(2);
        make.size.mas_equalTo(CGSizeMake((Width - 20 - 4)/2 - (Width - 20 - 4)/2*0.5 , 4));
    }];
}
@end
