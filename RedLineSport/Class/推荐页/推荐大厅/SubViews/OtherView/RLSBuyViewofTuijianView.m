#import "RLSBuyViewofTuijianView.h"
@interface RLSBuyViewofTuijianView()
@property (nonatomic, assign) BOOL isaddLayout;
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UIView *viewline;
@property (nonatomic, strong) UILabel *labbuyNum;
@property (nonatomic, strong) UILabel *labuytime;
@property (nonatomic, strong) UILabel *labbuyNumtitle;
@property (nonatomic, strong) UILabel *labuytimetitle;
@property (nonatomic, strong) UILabel *labbuystate;
@property (nonatomic, strong) UILabel *labbuyStateTitle;
@end
@implementation RLSBuyViewofTuijianView
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)setModel:(RLSTuijiandatingModel *)model
{
    _model = model;
    [self addSubview:self.basicView];
    if (!_isaddLayout) {
        _isaddLayout = YES;
        [self addlayout];
    }
    _labbuyNumtitle.text = @"订单编号:";
    _labbuyNum.text = [NSString stringWithFormat:@"%ld",_model.oid];
    _labuytimetitle.text = @"购买时间:";
    _labuytime.text = _model.paytime;
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.labbuyNum];
        [_basicView addSubview:self.labuytime];
        [_basicView addSubview:self.viewline];
        [_basicView addSubview:self.labbuyNumtitle];
        [_basicView addSubview:self.labuytimetitle];
        [_basicView addSubview:self.labbuystate];
        [_basicView addSubview:self.labbuyStateTitle];
    }
    return _basicView;
}
- (UIView *)viewline
{
    if (!_viewline) {
        _viewline = [[UIView alloc] init];
        _viewline.backgroundColor = colorCellLine;
    }
    return _viewline;
}
- (UILabel *)labbuyNum
{
    if (!_labbuyNum) {
        _labbuyNum = [[UILabel alloc] init];
        _labbuyNum.textColor = color33;
        _labbuyNum.font = BoldFont4(fontSize12);
    }
    return _labbuyNum;
}
- (UILabel *)labbuyNumtitle
{
    if (!_labbuyNumtitle) {
        _labbuyNumtitle = [[UILabel alloc] init];
        _labbuyNumtitle.textColor = color99;
        _labbuyNumtitle.font = font12;
    }
    return _labbuyNumtitle;
}
- (UILabel *)labuytime
{
    if (!_labuytime) {
        _labuytime = [[UILabel alloc] init];
        _labuytime.textColor = color99;
        _labuytime.font = BoldFont4(fontSize12);
    }
    return _labuytime;
}
- (UILabel *)labuytimetitle
{
    if (!_labuytimetitle) {
        _labuytimetitle = [[UILabel alloc] init];
        _labuytimetitle.textColor = color99;
        _labuytimetitle.font = font12;
    }
    return _labuytimetitle;
}
- (UILabel *)labbuystate
{
    if (!_labbuystate) {
        _labbuystate = [[UILabel alloc] init];
        _labbuystate.textColor = color33;
        _labbuystate.font = font12;
    }
    return _labbuystate;
}
- (UILabel *)labbuyStateTitle
{
    if (!_labbuyStateTitle) {
        _labbuyStateTitle = [[UILabel alloc] init];
        _labbuyStateTitle.textColor = color99;
        _labbuyStateTitle.font = font12;
    }
    return _labbuyStateTitle;
}
- (void)addlayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left);
        make.top.equalTo(self.basicView.mas_top);
        make.size.mas_equalTo(CGSizeMake(Width, 0.5));
    }];
    [self.labbuyNumtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];
    [self.labbuyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labbuyNumtitle.mas_right).offset(5);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];
    [self.labuytimetitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.labuytime.mas_left).offset(-5);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];
    [self.labuytime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.basicView.mas_right).offset(-15);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];
    [self.labbuystate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.basicView.mas_right).offset(-15);
        make.top.equalTo(self.labuytimetitle.mas_top).offset(0);
    }];
    [self.labbuyStateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.labbuystate.mas_left).offset(-5);
        make.top.equalTo(self.labuytimetitle.mas_top).offset(0);
    }];
}
@end
