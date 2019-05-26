#import "RLSTongbeiTongjiCell.h"
@interface RLSTongbeiTongjiCell()
@property (nonatomic, assign) BOOL isaddLayout;
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UIView *viewLine;
@property (nonatomic, strong) UILabel *labQici;
@property (nonatomic, strong) UILabel *labLeague;
@property (nonatomic, strong) UILabel *labTime;
@property (nonatomic, strong) UILabel *labHomteam;
@property (nonatomic, strong) UILabel *labGuestteam;
@property (nonatomic, strong) UILabel *labVS;
@property (nonatomic, strong) UILabel *labCompany;
@property (nonatomic, strong) UILabel *labPankou;
@property (nonatomic, strong) UILabel *labPeilvUp;
@property (nonatomic, strong) UILabel *labpeilvGoal;
@property (nonatomic, strong) UILabel *labPeilvDown;
@property (nonatomic, strong) UILabel *labRate;
@property (nonatomic, strong) UILabel *labRateTitle;
@property (nonatomic, strong) UILabel *labRound;
@end
@implementation RLSTongbeiTongjiCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)setModel:(RLSTongPeiTJModel *)model
{
    _model = model;
    [self.contentView addSubview:self.basicView];
    if (!_isaddLayout) {
        _isaddLayout = YES;
        [self addlayout];
    }
    _labQici.text =isNUll(_model.symbol)?@"" :[NSString stringWithFormat:@"%@ ",_model.symbol] ;
    _labLeague.text = _model.sclassName;
    _labLeague.textColor = [RLSMethods getColor:_model.sclassColor];
    _labTime.text = _model.matchTime;
    NSString *home = _model.homeTeam;
    NSString *guest = _model.guestTeam;
    if (isOniPhone4 || isOniPhone5) {
        if (home.length>5) {
            home = [NSString stringWithFormat:@"%@…",[home substringToIndex:5]];
        }
        if (guest.length>5) {
            guest = [NSString stringWithFormat:@"%@…",[guest substringToIndex:5]];
        }
    }else{
        if (home.length>7) {
            home = [NSString stringWithFormat:@"%@…",[home substringToIndex:7]];
        }
        if (guest.length>7) {
            guest = [NSString stringWithFormat:@"%@…",[guest substringToIndex:7]];
        }
    }
    _labHomteam.text = home;
    _labVS.text = @"vs";
    _labGuestteam.text = guest;
    _labCompany.text = _model.company;
    _labCompany.text = @"";
    if (isNUll(_model.win)) {
        _labPankou.text = @"";
        _labPeilvUp.text = @"";
        _labpeilvGoal.text = @"";
        _labPeilvDown.text = @"";
        [self.labQici mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.basicView.mas_top).offset(22.5);
        }];
        [self.labLeague mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.basicView.mas_top).offset(22.5);
        }];
        [self.labTime mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.basicView.mas_top).offset(22.5);
        }];
    }else{
        [self.labQici mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.basicView.mas_top).offset(14.5);
        }];
        [self.labLeague mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.basicView.mas_top).offset(14.5);
        }];
        [self.labTime mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.basicView.mas_top).offset(14.5);
        }];
        if (_type == 0) {
            _labPankou.text = @"初赔";
        }else{
            _labPankou.text = @"初指";
        }
        _labPeilvUp.text = _model.win;
        _labpeilvGoal.text = _model.draw;
        _labPeilvDown.text = _model.lose;
    }
    _labRateTitle.text = _model.rateDesc;
    _labRate.text = [NSString stringWithFormat:@"%@%%",_model.rate];
    _labRate.textColor = [RLSMethods getColor:_model.resultColor];
    _labRateTitle.textColor = [RLSMethods getColor:_model.resultColor];
    _labRound.text = [NSString stringWithFormat:@"共%ld场",_model.num];
    _labRound.textColor =color66;
    _labRate.attributedText = [RLSMethods withContent:_labRate.text WithColorText:@"%" textColor:[RLSMethods getColor:_model.resultColor] strFont:font12];
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.labQici];
        [_basicView addSubview:self.labLeague];
        [_basicView addSubview:self.labTime];
        [_basicView addSubview:self.labHomteam];
        [_basicView addSubview:self.labGuestteam];
        [_basicView addSubview:self.labVS];
        [_basicView addSubview:self.labCompany];
        [_basicView addSubview:self.labPankou];
        [_basicView addSubview:self.labPeilvUp];
        [_basicView addSubview:self.labpeilvGoal];
        [_basicView addSubview:self.labPeilvDown];
        [_basicView addSubview:self.labRate];
        [_basicView addSubview:self.labRateTitle];
        [_basicView addSubview:self.labRound];
        [_basicView addSubview:self.viewLine];
    }
    return _basicView;
}
- (UILabel *)labQici
{
    if (!_labQici) {
        _labQici = [[UILabel alloc] init];
        _labQici.font = font12;
        _labQici.textColor = color66;
    }
    return _labQici;
}
- (UILabel *)labLeague
{
    if (!_labLeague) {
        _labLeague = [[UILabel alloc] init];
        _labLeague.font = font12;
        _labLeague.textColor = color66;
    }
    return _labLeague;
}
- (UILabel *)labTime
{
    if (!_labTime) {
        _labTime = [[UILabel alloc] init];
        _labTime.font = font12;
        _labTime.textColor = color66;
    }
    return _labTime;
}
- (UILabel *)labHomteam
{
    if (!_labHomteam) {
        _labHomteam = [[UILabel alloc] init];
        _labHomteam.font = BoldFont4(fontSize16);
        _labHomteam.textColor = color33;
    }
    return _labHomteam;
}
- (UILabel *)labGuestteam
{
    if (!_labGuestteam) {
        _labGuestteam = [[UILabel alloc] init];
        _labGuestteam.font = BoldFont4(fontSize16);
        _labGuestteam.textColor = color33;
    }
    return _labGuestteam;
}
- (UILabel *)labVS
{
    if (!_labVS) {
        _labVS = [[UILabel alloc] init];
        _labVS.font = font16;
        _labVS.textColor = color99;
    }
    return _labVS;
}
- (UILabel *)labCompany
{
    if (!_labCompany) {
        _labCompany = [[UILabel alloc] init];
        _labCompany.font = font12;
        _labCompany.textColor = color66;
    }
    return _labCompany;
}
- (UILabel *)labPankou
{
    if (!_labPankou) {
        _labPankou = [[UILabel alloc] init];
        _labPankou.font = font12;
        _labPankou.textColor = color66;
    }
    return _labPankou;
}
- (UILabel *)labPeilvUp
{
    if (!_labPeilvUp) {
        _labPeilvUp = [[UILabel alloc] init];
        _labPeilvUp.font = font12;
        _labPeilvUp.textColor = color66;
    }
    return _labPeilvUp;
}
- (UILabel *)labpeilvGoal
{
    if (!_labpeilvGoal) {
        _labpeilvGoal = [[UILabel alloc] init];
        _labpeilvGoal.font = font12;
        _labpeilvGoal.textColor = color66;
    }
    return _labpeilvGoal;
}
- (UILabel *)labPeilvDown
{
    if (!_labPeilvDown) {
        _labPeilvDown = [[UILabel alloc] init];
        _labPeilvDown.font = font12;
        _labPeilvDown.textColor = color66;
    }
    return _labPeilvDown;
}
- (UILabel *)labRate
{
    if (!_labRate) {
        _labRate = [[UILabel alloc] init];
        _labRate.font = font32;
        _labRate.textColor = redcolor;
        _labRate.textAlignment = NSTextAlignmentCenter;
    }
    return _labRate;
}
- (UILabel *)labRateTitle
{
    if (!_labRateTitle) {
        _labRateTitle = [[UILabel alloc] init];
        _labRateTitle.font = font12;
        _labRateTitle.textColor = color66;
        _labRateTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labRateTitle;
}
- (UIView *)viewLine
{
    if (!_viewLine) {
        _viewLine = [[UIView alloc] init];
        _viewLine.backgroundColor = colorCellLine;
    }
    return _viewLine;
}
- (UILabel *)labRound
{
    if (!_labRound) {
        _labRound = [[UILabel alloc] init];
        _labRound.font = font12;
        _labRound.textColor = color66;
        _labRound.textAlignment = NSTextAlignmentCenter;
    }
    return _labRound;
}
- (void)addlayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self.labQici mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.top.equalTo(self.basicView.mas_top).offset(14.5);
    }];
    [self.labLeague mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labQici.mas_right).offset(0);
        make.top.equalTo(self.basicView.mas_top).offset(14.5);
    }];
    [self.labTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labLeague.mas_right).offset(5);
        make.top.equalTo(self.basicView.mas_top).offset(14.5);
    }];
    [self.labHomteam mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.top.equalTo(self.labTime.mas_bottom).offset(6.5);
    }];
    [self.labVS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labHomteam.mas_right).offset(5);
        make.centerY.equalTo(self.labHomteam.mas_centerY);
    }];
    [self.labGuestteam mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labVS.mas_right).offset(5);
        make.centerY.equalTo(self.labHomteam.mas_centerY);
    }];
    [self.labCompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.top.equalTo(self.labHomteam.mas_bottom).offset(6.5);
    }];
    [self.labPankou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labCompany.mas_right).offset(0);
        make.top.equalTo(self.labHomteam.mas_bottom).offset(6.5);
    }];
    [self.labPeilvUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labPankou.mas_right).offset(5);
        make.centerY.equalTo(self.labPankou.mas_centerY);
    }];
    [self.labpeilvGoal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labPeilvUp.mas_right).offset(5);
        make.centerY.equalTo(self.labPankou.mas_centerY);
    }];
    [self.labPeilvDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labpeilvGoal.mas_right).offset(5);
        make.centerY.equalTo(self.labPankou.mas_centerY);
    }];
    [self.labRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.basicView.mas_centerY).offset(0);
        make.right.equalTo(self.basicView.mas_right).offset(0);
        make.width.mas_equalTo(110);
    }];
    [self.labRateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.labRate.mas_top).offset(-3.5);
        make.right.equalTo(self.basicView.mas_right).offset(0);
        make.width.mas_equalTo(110);
    }];
    [self.labRound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labRate.mas_bottom).offset(3.5);
        make.right.equalTo(self.basicView.mas_right).offset(0);
        make.width.mas_equalTo(110);
    }];
    [self.viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(0);
        make.bottom.equalTo(self.basicView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(Width, 0.6));
    }];
}
@end
