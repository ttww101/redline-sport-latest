#import "RLSTeamViewOfPlycCell.h"
@interface RLSTeamViewOfPlycCell()
@property (nonatomic, assign) BOOL isAddlayout;
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UILabel *labHome;
@property (nonatomic, strong) UILabel *labVS;
@property (nonatomic, strong) UILabel *labGuest;
@property (nonatomic, strong) UILabel *labQici;
@property (nonatomic, strong) UILabel *labLeague;
@property (nonatomic, strong) UILabel *labTime;
@property (nonatomic, strong) UILabel *labNum;
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UIImageView *imageNum;
@property (nonatomic, strong) UIView *viewNum;
@property (nonatomic, strong) UIView *viewLine;
@end
@implementation RLSTeamViewOfPlycCell
- (void)setModel:(RLSPlycModel *)model
{
    _model = model;
    [self addSubview:self.basicView];
    if (!_isAddlayout) {
        _isAddlayout = YES;
        [self addLayout];
    }
    _labHome.text = _model.homeTeam;
    _labGuest.text = _model.guestTeam;
    _labVS.text = @"VS";
    _labLeague.text = [NSString stringWithFormat:@"%@ ",_model.sclassName];
    if ([_model.matchTime isKindOfClass:[NSString class]]) {
        _labTime.text = _model.matchTime;
    }else{
        _labTime.text = @"";
    }
    switch (_type) {
        case 1:
        {
            switch (_model.type) {
                case 1:
                    _labTitle.text = @"胜赔幅度";
                    break;
                case 2:
                    _labTitle.text = @"平赔幅度";
                    break;
                case 3:
                    _labTitle.text = @"负赔幅度";
                    break;
                default:
                    break;
            }
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"peilvyichangshouIndex"] == 0 ) {
                _labQici.text = @"";
            }else{
                _labQici.text = [NSString stringWithFormat:@"%@ ",_model.symbol];
            }
        }
            break;
        case 2:
        {
            _labTitle.text = @"盘口变动";
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"yapanzhushouIndex"] == 0 ) {
                _labQici.text = @"";
            }else{
                _labQici.text = [NSString stringWithFormat:@"%@ ",_model.symbol];
            }
        }
            break;
        case 3:
        {
            _labTitle.text = @"奖金变化";
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"yapanzhushouIndex"] == 0 ) {
                _labQici.text = @"";
            }else{
                _labQici.text = [NSString stringWithFormat:@"%@ ",_model.symbol];
            }
        }
            break;
        default:
            break;
    }
    _labNum.text = _model.amp;
    if ([_model.amp containsString:@"-"]) {
        _viewNum.backgroundColor = greencolor;
        _imageNum.image = [UIImage imageNamed:@"plycWhiteDown"];
        if (_type == 2) {
            _labNum.text = [NSString stringWithFormat:@"%@个盘口",[_model.amp substringFromIndex:1]];
        }else{
            _labNum.text = [NSString stringWithFormat:@"%@%%",_model.amp];
        }
    }else{
        _viewNum.backgroundColor = redcolor;
        _imageNum.image = [UIImage imageNamed:@"plycWhiteup"];
        if (_type == 2) {
            _labNum.text = [NSString stringWithFormat:@"%@个盘口",_model.amp];
            if ([_model.amp isEqualToString:@"0"]) {
                _imageNum.image = [UIImage imageNamed:@"clear"];
                _labNum.text = [NSString stringWithFormat:@"%@个盘口",_model.amp];
                _viewNum.backgroundColor = color99;
            }
        }else{
            _labNum.text = [NSString stringWithFormat:@"+%@%%",_model.amp];
        }
    }
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.labHome];
        [_basicView addSubview:self.labVS];
        [_basicView addSubview:self.labGuest];
        [_basicView addSubview:self.labQici];
        [_basicView addSubview:self.labLeague];
        [_basicView addSubview:self.labTime];
        [_basicView addSubview:self.viewNum];
        [_basicView addSubview:self.imageNum];
        [_basicView addSubview:self.labNum];
        [_basicView addSubview:self.labTitle];
        [_basicView addSubview:self.viewLine];
    }
    return _basicView;
}
- (UILabel *)labHome
{
    if (!_labHome) {
        _labHome = [[UILabel alloc] init];
        _labHome.textColor = color33;
        _labHome.font = font14;
    }
    return _labHome;
}
- (UILabel *)labGuest
{
    if (!_labGuest) {
        _labGuest = [[UILabel alloc] init];
        _labGuest.textColor = color33;
        _labGuest.font = font14;
    }
    return _labGuest;
}
- (UILabel *)labVS
{
    if (!_labVS) {
        _labVS = [[UILabel alloc] init];
        _labVS.textColor = color33;
        _labVS.font = font14;
    }
    return _labVS;
}
- (UILabel *)labQici
{
    if (!_labQici) {
        _labQici = [[UILabel alloc] init];
        _labQici.textColor = color99;
        _labQici.font = font11;
    }
    return _labQici;
}
- (UILabel *)labLeague
{
    if (!_labLeague) {
        _labLeague = [[UILabel alloc] init];
        _labLeague.textColor = color99;
        _labLeague.font = font11;
    }
    return _labLeague;
}
- (UILabel *)labTime
{
    if (!_labTime) {
        _labTime = [[UILabel alloc] init];
        _labTime.textColor = color99;
        _labTime.font = font11;
    }
    return _labTime;
}
- (UILabel *)labNum
{
    if (!_labNum) {
        _labNum = [[UILabel alloc] init];
        _labNum.textColor = [UIColor whiteColor];
        _labNum.font = font12;
    }
    return _labNum;
}
- (UIImageView *)imageNum
{
    if (!_imageNum) {
        _imageNum = [[UIImageView alloc] init];
    }
    return _imageNum;
}
- (UILabel *)labTitle
{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] init];
        _labTitle.textColor = color99;
        _labTitle.font = font12;
    }
    return _labTitle;
}
- (UIView *)viewNum
{
    if (!_viewNum) {
        _viewNum = [[UIView alloc] init];
        _viewNum.backgroundColor= redcolor;
    }
    return _viewNum;
}
- (UIView *)viewLine
{
    if (!_viewLine) {
        _viewLine = [[UIView alloc] init];
        _viewLine.backgroundColor= colorCellLine;
    }
    return _viewLine;
}
- (void)addLayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.labHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(13);
        make.top.equalTo(self.basicView.mas_top).offset(9);
    }];
    [self.labVS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labHome.mas_right).offset(3);
        make.centerY.equalTo(self.labHome.mas_centerY);
    }];
    [self.labGuest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labVS.mas_right).offset(3);
        make.centerY.equalTo(self.labHome.mas_centerY);
    }];
    [self.labQici mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(13);
        make.top.equalTo(self.labHome.mas_bottom).offset(4);
    }];
    [self.labLeague mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labQici.mas_right).offset(0);
        make.top.equalTo(self.labHome.mas_bottom).offset(4);
    }];
    [self.labTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labLeague.mas_right).offset(0);
        make.top.equalTo(self.labHome.mas_bottom).offset(4);
    }];
    [self.viewNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.basicView.mas_right).offset(-14);
        make.top.equalTo(self.basicView.mas_top).offset(14);
        make.size.mas_equalTo(CGSizeMake(68, 20));
    }];
    [self.labNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewNum.mas_centerY);
        make.centerX.equalTo(self.viewNum.mas_centerX).offset(4);
    }];
    [self.imageNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labNum.mas_centerY);
        make.right.equalTo(self.labNum.mas_left).offset(-4);
    }];
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewNum.mas_bottom).offset(3);
        make.centerX.equalTo(self.viewNum.mas_centerX);
    }];
    [self.viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.basicView.mas_bottom);
        make.left.equalTo(self.basicView.mas_left);
        make.size.mas_equalTo(CGSizeMake(Width, 0.5));
    }];
}
@end
