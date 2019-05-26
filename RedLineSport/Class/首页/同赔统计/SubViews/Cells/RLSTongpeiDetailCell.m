#import "RLSTongpeiDetailCell.h"
@interface RLSTongpeiDetailCell()
@property (nonatomic, assign) BOOL isaddLayout;
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UILabel *labLeague;
@property (nonatomic, strong) UILabel *labTime;
@property (nonatomic, strong) UILabel *labHomteam;
@property (nonatomic, strong) UILabel *labGuestteam;
@property (nonatomic, strong) UIView *ViewPingCenter;
@property (nonatomic, strong) UILabel *labHomePankouwin;
@property (nonatomic, strong) UILabel *labHomePankouping;
@property (nonatomic, strong) UILabel *labHomePankoulose;
@property (nonatomic, strong) UILabel *labGuestPankouwin;
@property (nonatomic, strong) UILabel *labGuestPankouping;
@property (nonatomic, strong) UILabel *labGuestPankoulose;
@property (nonatomic, strong) UILabel *labHomeScore;
@property (nonatomic, strong) UILabel *labGuestScore;
@property (nonatomic, strong) UILabel *labWin;
@end
@implementation RLSTongpeiDetailCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setModel:(RLSTongPeiMatchModel *)model
{
    _model = model;
    [self.contentView addSubview:self.basicView];
    if (!_isaddLayout) {
        _isaddLayout = YES;
        [self addLayout];
    }
    _labLeague.text = _model.sclassName;
    _labLeague.textColor = [RLSMethods getColor:_model.sclassColor];
    _labTime.text = _model.matchTime;
    _labHomteam.text = _model.homeTeam;
    _labGuestteam.text = _model.guestTeam;
    _labHomeScore.text = [NSString stringWithFormat:@"%ld",_model.homeScore];
    _labGuestScore.text = [NSString stringWithFormat:@"%ld",_model.guestScore];
    _labHomePankouwin.text = _model.firstWin;
    _labHomePankouping.text = _model.firstDraw;
    _labHomePankoulose.text = _model.firstLose;
    _labGuestPankouwin.text = _model.finalWin;
    _labGuestPankouping.text = _model.finalDraw;
    _labGuestPankoulose.text = _model.finalLose;
    if ([_model.finalWin floatValue]>[_model.firstWin floatValue]) {
        _labGuestPankouwin.textColor = redcolor;
    }else if ([_model.finalWin floatValue]<[_model.firstWin floatValue]) {
        _labGuestPankouwin.textColor = greencolor;
    }else{
        _labGuestPankouwin.textColor = color33;
    }
    if (_pelvIndex == 0) {
        if ([_model.finalDraw floatValue]>[_model.firstDraw floatValue]) {
            _labGuestPankouping.textColor = redcolor;
        }else if ([_model.finalDraw floatValue]<[_model.firstDraw floatValue]) {
            _labGuestPankouping.textColor = greencolor;
        }else{
            _labGuestPankouping.textColor = color33;
        }
    }else{
        _labGuestPankouping.textColor = color33;
    }
    if ([_model.finalLose floatValue]>[_model.firstLose floatValue]) {
        _labGuestPankoulose.textColor = redcolor;
    }else if ([_model.finalLose floatValue]<[_model.firstLose floatValue]) {
        _labGuestPankoulose.textColor = greencolor;
    }else{
        _labGuestPankoulose.textColor = color33;
    }
    _labWin.text = _model.result;
    _labWin.backgroundColor = [RLSMethods getColor:_model.resultColor];
    _labWin.textColor = [UIColor whiteColor];
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.labLeague];
        [_basicView addSubview:self.labTime];
        [_basicView addSubview:self.labHomteam];
        [_basicView addSubview:self.labGuestteam];
        [_basicView addSubview:self.labHomeScore];
        [_basicView addSubview:self.labGuestScore];
        [_basicView addSubview:self.ViewPingCenter];
        [_basicView addSubview:self.labHomePankouwin];
        [_basicView addSubview:self.labHomePankouping];
        [_basicView addSubview:self.labHomePankoulose];
        [_basicView addSubview:self.labGuestPankouwin];
        [_basicView addSubview:self.labGuestPankouping];
        [_basicView addSubview:self.labGuestPankoulose];
        [_basicView addSubview:self.labWin];
    }
    return _basicView;
}
- (UIView *)ViewPingCenter
{
    if (!_ViewPingCenter) {
        _ViewPingCenter = [[UIView alloc] init];
    }
    return _ViewPingCenter;
}
- (UILabel *)labLeague
{
    if (!_labLeague) {
        _labLeague = [[UILabel alloc] init];
        _labLeague.font = font12;
        _labLeague.textColor = color33;
    }
    return _labLeague;
}
- (UILabel *)labTime
{
    if (!_labTime) {
        _labTime = [[UILabel alloc] init];
        _labTime.font = font12;
        _labTime.textColor = color99;
    }
    return _labTime;
}
- (UILabel *)labHomteam
{
    if (!_labHomteam) {
        _labHomteam = [[UILabel alloc] init];
        _labHomteam.font = font12;
        _labHomteam.textColor = color33;
    }
    return _labHomteam;
}
- (UILabel *)labGuestteam
{
    if (!_labGuestteam) {
        _labGuestteam = [[UILabel alloc] init];
        _labGuestteam.font = font12;
        _labGuestteam.textColor = color33;
    }
    return _labGuestteam;
}
- (UILabel *)labHomeScore
{
    if (!_labHomeScore) {
        _labHomeScore = [[UILabel alloc] init];
        _labHomeScore.font = font12;
        _labHomeScore.textColor = color33;
        _labHomeScore.textAlignment = NSTextAlignmentCenter;
    }
    return _labHomeScore;
}
- (UILabel *)labGuestScore
{
    if (!_labGuestScore) {
        _labGuestScore = [[UILabel alloc] init];
        _labGuestScore.font = font12;
        _labGuestScore.textColor = color33;
        _labGuestScore.textAlignment = NSTextAlignmentCenter;
    }
    return _labGuestScore;
}
- (UILabel *)labHomePankouwin
{
    if (!_labHomePankouwin) {
        _labHomePankouwin = [[UILabel alloc] init];
        _labHomePankouwin.font = font12;
        _labHomePankouwin.textColor = color33;
        _labHomePankouwin.textAlignment = NSTextAlignmentCenter;
    }
    return _labHomePankouwin;
}
- (UILabel *)labHomePankouping
{
    if (!_labHomePankouping) {
        _labHomePankouping = [[UILabel alloc] init];
        _labHomePankouping.font = font12;
        _labHomePankouping.textColor = color33;
        _labHomePankouping.textAlignment = NSTextAlignmentCenter;
    }
    return _labHomePankouping;
}
- (UILabel *)labHomePankoulose
{
    if (!_labHomePankoulose) {
        _labHomePankoulose = [[UILabel alloc] init];
        _labHomePankoulose.font = font12;
        _labHomePankoulose.textColor = color33;
        _labHomePankoulose.textAlignment = NSTextAlignmentCenter;
    }
    return _labHomePankoulose;
}
- (UILabel *)labGuestPankouwin
{
    if (!_labGuestPankouwin) {
        _labGuestPankouwin = [[UILabel alloc] init];
        _labGuestPankouwin.font = font12;
        _labGuestPankouwin.textColor = color33;
        _labGuestPankouwin.textAlignment = NSTextAlignmentCenter;
    }
    return _labGuestPankouwin;
}
- (UILabel *)labGuestPankouping
{
    if (!_labGuestPankouping) {
        _labGuestPankouping = [[UILabel alloc] init];
        _labGuestPankouping.font = font12;
        _labGuestPankouping.textColor = color33;
        _labGuestPankouping.textAlignment = NSTextAlignmentCenter;
    }
    return _labGuestPankouping;
}
- (UILabel *)labGuestPankoulose
{
    if (!_labGuestPankoulose) {
        _labGuestPankoulose = [[UILabel alloc] init];
        _labGuestPankoulose.font = font12;
        _labGuestPankoulose.textColor = color33;
        _labGuestPankoulose.textAlignment = NSTextAlignmentCenter;
    }
    return _labGuestPankoulose;
}
- (UILabel *)labWin
{
    if (!_labWin) {
        _labWin = [[UILabel alloc] init];
        _labWin.font = font12;
        _labWin.textColor = color33;
        _labWin.textAlignment = NSTextAlignmentCenter;
        _labWin.layer.cornerRadius = 3;
        _labWin.layer.masksToBounds = YES;
    }
    return _labWin;
}
- (void)addLayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self.labLeague mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.top.equalTo(self.basicView.mas_top).offset(7.5);
        make.width.mas_equalTo(60);
    }];
    [self.labTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.bottom.equalTo(self.basicView.mas_bottom).offset(-7.5);
        make.width.mas_equalTo(60);
    }];
    [self.labHomteam mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labLeague.mas_right);
        make.centerY.equalTo(self.labLeague.mas_centerY);
        make.width.mas_equalTo((Width - 15 - 60 - 35 -100 - 55));
    }];
    [self.labGuestteam mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labLeague.mas_right);
        make.centerY.equalTo(self.labTime.mas_centerY);
        make.width.mas_equalTo((Width - 15 - 60 - 35 -100 - 55));
    }];
    [self.labHomeScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labHomteam.mas_right);
        make.centerY.equalTo(self.labLeague.mas_centerY);
        make.width.mas_equalTo(35);
    }];
    [self.labGuestScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labHomteam.mas_right);
        make.centerY.equalTo(self.labTime.mas_centerY);
        make.width.mas_equalTo(35);
    }];
    [self.ViewPingCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top);
        make.left.equalTo(self.labHomeScore.mas_right);
        make.width.mas_equalTo(100);
    }];
    [self.labHomePankouping mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.ViewPingCenter.mas_centerX);
        make.centerY.equalTo(self.labLeague.mas_centerY);
    }];
    [self.labHomePankouwin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labLeague.mas_centerY);
        make.right.equalTo(self.labHomePankouping.mas_left).offset(-5);
    }];
    [self.labHomePankoulose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labHomePankouping.mas_right).offset(5);
        make.centerY.equalTo(self.labLeague.mas_centerY);
    }];
    [self.labGuestPankouping mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.ViewPingCenter.mas_centerX);
        make.centerY.equalTo(self.labTime.mas_centerY);
    }];
    [self.labGuestPankouwin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.labGuestPankouping.mas_left).offset(-5);
        make.centerY.equalTo(self.labTime.mas_centerY);
    }];
    [self.labGuestPankoulose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labGuestPankouping.mas_right).offset(5);
        make.centerY.equalTo(self.labTime.mas_centerY);
    }];
    [self.labWin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.basicView.mas_centerY);
        make.right.equalTo(self.basicView.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(35, 16));
    }];
}
@end
