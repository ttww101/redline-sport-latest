#import "RLSJiXianCell.h"
@interface RLSJiXianCell()
@property (nonatomic, strong)UIView *basicView;
@property (nonatomic, strong)UILabel *labNumOne;
@property (nonatomic, strong)UILabel *labNumOneStr;
@property (nonatomic, strong)UILabel *labNumTwo;
@property (nonatomic, strong)UILabel *labNumTwoStr;
@property (nonatomic, strong)UIView *liView;
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
@end
@implementation RLSJiXianCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.basicView];
        [self.basicView addSubview:self.labNumOne];
        [self.basicView addSubview:self.labNumOneStr];
        [self.basicView addSubview:self.labNumTwo];
        [self.basicView addSubview:self.labNumTwoStr];
        [self.basicView addSubview:self.liView];
        [self.basicView addSubview:self.labQici];
        [self.basicView addSubview:self.labLeague];
        [self.basicView addSubview:self.labTime];
        [self.basicView addSubview:self.labHomteam];
        [self.basicView addSubview:self.labGuestteam];
        [self.basicView addSubview:self.labVS];
        [self.basicView addSubview:self.labCompany];
        [self.basicView addSubview:self.labPankou];
        [self.basicView addSubview:self.labPeilvUp];
        [self.basicView addSubview:self.labpeilvGoal];
        [self.basicView addSubview:self.labPeilvDown];
        [self.basicView addSubview:self.viewLine];
        [self setMas];
    }
    return self;
}
- (UIView *)basicView{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        _basicView.backgroundColor = [UIColor clearColor];
    }
    return _basicView;
}
- (UILabel *)labNumOne{
    if (!_labNumOne) {
        _labNumOne = [[UILabel alloc] init];
        _labNumOne.font = font28;
        _labNumOne.textColor = redcolor;
        _labNumOne.text = @"12";
        _labNumOne.textAlignment = NSTextAlignmentCenter;
    }
    return _labNumOne;
}
- (UILabel *)labNumOneStr{
    if (!_labNumOneStr) {
        _labNumOneStr = [[UILabel alloc] init];
        _labNumOneStr.font = font11;
        _labNumOneStr.textColor = redcolor;
        _labNumOneStr.textAlignment = NSTextAlignmentCenter;
        _labNumOneStr.text = @"当前连红";
    }
    return _labNumOneStr;
}
- (UIView *)liView{
    if (!_liView) {
        _liView = [[UIView alloc] init];
        _liView.backgroundColor = colorDD;
    }
    return _liView;
}
- (UILabel *)labNumTwo{
    if (!_labNumTwo) {
        _labNumTwo = [[UILabel alloc] init];
        _labNumTwo.font = font28;
        _labNumTwo.textColor = color33;
        _labNumTwo.text = @"8";
        _labNumTwo.textAlignment = NSTextAlignmentCenter;
    }
    return _labNumTwo;
}
- (UILabel *)labNumTwoStr{
    if (!_labNumTwoStr) {
        _labNumTwoStr = [[UILabel alloc] init];
        _labNumTwoStr.font = font11;
        _labNumTwoStr.textColor = color33;
        _labNumTwoStr.textAlignment = NSTextAlignmentCenter;
        _labNumTwoStr.text = @"历史最高";
    }
    return _labNumTwoStr;
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
- (UIView *)viewLine
{
    if (!_viewLine) {
        _viewLine = [[UIView alloc] init];
        _viewLine.backgroundColor = colorCellLine;
    }
    return _viewLine;
}
- (void)setModel:(RLSRecord_OneModel *)model{
    _model = model;
    _labQici.text =isNUll(_model.sortone)?@"" :[NSString stringWithFormat:@"%@ ",_model.sortone] ;
    _labLeague.text = _model.league;
    _labTime.text = _model.mtime;
    if ([_model.hometeam isEqualToString:_model.teamname]) {
        _labHomteam.textColor = redcolor;
    }else{
        _labHomteam.textColor = color33;
    }
    if ([_model.guestteam isEqualToString:_model.teamname]) {
        _labGuestteam.textColor = redcolor;
    }else{
        _labGuestteam.textColor = color33;
    }
    NSString *home = _model.hometeam;
    NSString *guest = _model.guestteam;
    if (isOniPhone4 || isOniPhone5) {
        if (home.length>5) {
            home = [NSString stringWithFormat:@"%@…",[home substringToIndex:5]];
        }
        if (guest.length>5) {
            guest = [NSString stringWithFormat:@"%@…",[guest substringToIndex:5]];
        }
    }else{
        if (home.length>6) {
            home = [NSString stringWithFormat:@"%@…",[home substringToIndex:6]];
        }
        if (guest.length>6) {
            guest = [NSString stringWithFormat:@"%@…",[guest substringToIndex:6]];
        }
    }
    _labHomteam.text = home;
    _labVS.text = @"vs";
    _labGuestteam.text = guest;
    _labCompany.text = @"";
    self.labNumOne.text = [NSString stringWithFormat:@"%ld",model.mostresult];
    self.labNumTwo.text = [NSString stringWithFormat:@"%ld",model.historymostresult];
    if (self.type ==0) {
        _labPankou.text = @"初赔";
        switch (model.type) {
            case 1:
                self.labNumOneStr.text = @"当前连胜";
                _labNumOneStr.textColor = redcolor;
                _labNumOne.textColor = redcolor;
                break;
            case 2:
                self.labNumOneStr.text = @"当前连平";
                _labNumOneStr.textColor = bluecolor;
                _labNumOne.textColor = bluecolor;
                break;
            case 3:
                self.labNumOneStr.text = @"当前连负";                _labNumOneStr.textColor = greencolor;
                _labNumOne.textColor = greencolor;
                break;
            default:
                break;
        }
    }else if (self.type == 1){
        _labPankou.text = @"初指";
        switch (model.type) {
            case 1:
                self.labNumOneStr.text = @"连续让球胜";
                _labNumOneStr.textColor = redcolor;
                _labNumOne.textColor = redcolor;
                break;
            case 3:
                self.labNumOneStr.text = @"连续让球负";
                _labNumOneStr.textColor = greencolor;
                _labNumOne.textColor = greencolor;
                break;
            default:
                break;
        }
    }else{
        _labPankou.text = @"初指";
        switch (model.type) {
            case 1:
                self.labNumOneStr.text = @"连续大球";
                _labNumOneStr.textColor = redcolor;
                _labNumOne.textColor = redcolor;
                break;
            case 3:
                self.labNumOneStr.text = @"连续小球";
                _labNumOneStr.textColor = greencolor;
                _labNumOne.textColor = greencolor;
                break;
            default:
                break;
        }
    }
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
        _labPankou.text = @"";
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
}
- (void)setMas{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
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
    [self.viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(0);
        make.bottom.equalTo(self.basicView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(Width, 0.6));
    }];
    [self.labNumTwoStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.basicView.mas_right).offset(-18);
        make.bottom.mas_equalTo(self.basicView.mas_bottom).offset(-20);
    }];
    [self.labNumTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.labNumTwoStr.mas_centerX);
        make.bottom.mas_equalTo(self.labNumTwoStr.mas_top).offset(-10);
    }];
    [self.liView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labNumTwo.mas_top);
        make.bottom.mas_equalTo(self.labNumTwoStr.mas_bottom);
        make.width.mas_offset(0.5);
        make.right.mas_equalTo(self.labNumTwoStr.mas_left).offset(-11);
    }];
    [self.labNumOneStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.liView.mas_left).offset(-11);
        make.centerY.mas_equalTo(self.labNumTwoStr.mas_centerY);
    }];
    [self.labNumOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labNumTwo.mas_centerY);
        make.centerX.mas_equalTo(self.labNumOneStr.mas_centerX);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
