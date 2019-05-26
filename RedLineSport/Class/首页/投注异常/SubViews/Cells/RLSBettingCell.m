#import "RLSBettingCell.h"
@interface RLSBettingCell()
@property (nonatomic, strong)UIView *basicView;
@property (nonatomic, strong)UILabel *labType;
@property (nonatomic, strong)UILabel *labPeLv;
@property (nonatomic, strong)UILabel *labgaiLv;
@property (nonatomic, strong)UILabel *labTRLS;
@property (nonatomic, strong)UILabel *labWuCha;
@property (nonatomic, strong)UIView *lineView;
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
@implementation RLSBettingCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.basicView];
        [self.basicView addSubview:self.labWuCha];
        [self.basicView addSubview:self.labTRLS];
        [self.basicView addSubview:self.labgaiLv];
        [self.basicView addSubview:self.labgaiLv];
        [self.basicView addSubview:self.labPeLv];
        [self.basicView addSubview:self.labType];
        [self.basicView addSubview:self.lineView];
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
- (UILabel *)labType{
    if (!_labType) {
        _labType = [[UILabel alloc] init];
        _labType.font = font14;
        _labType.textColor = color33;
        _labType.text = @"胜";
        _labType.textAlignment = NSTextAlignmentCenter;
    }
    return _labType;
}
- (UILabel *)labPeLv{
    if (!_labPeLv) {
        _labPeLv = [[UILabel alloc] init];
        _labPeLv.textColor = color33;
        _labPeLv.font = font11;
        _labPeLv.text = @"3.06";
        _labPeLv.textAlignment = NSTextAlignmentCenter;
    }
    return _labPeLv;
}
- (UILabel *)labgaiLv{
    if (!_labgaiLv) {
        _labgaiLv = [[UILabel alloc] init];
        _labgaiLv.text = @"46%";
        _labgaiLv.textColor = color33;
        _labgaiLv.font = font11;
        _labgaiLv.textAlignment = NSTextAlignmentCenter;
    }
    return _labgaiLv;
}
- (UILabel *)labTRLS{
    if (!_labTRLS) {
        _labTRLS = [[UILabel alloc] init];
        _labTRLS.text = @"74%";
        _labTRLS.textColor = color33;
        _labTRLS.font = font11;
        _labTRLS.textAlignment = NSTextAlignmentCenter;
    }
    return _labTRLS;
}
- (UILabel *)labWuCha{
    if (!_labWuCha) {
        _labWuCha = [[UILabel alloc] init];
        _labWuCha.text = @"89.76%";
        _labWuCha.textColor = color33;
        _labWuCha.font = font11;
        _labWuCha.textAlignment = NSTextAlignmentCenter;
    }
    return _labWuCha;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = colorDD;
    }
    return _lineView;
}
-(void)setModel:(RLSTouZhuModel *)model{
    _model = model;
    _labQici.text =isNUll(_model.sort)?@"" :[NSString stringWithFormat:@"%@ ",_model.sort] ;
    _labLeague.text = _model.league;
    _labTime.text = _model.mtime;
    NSString *home = _model.hometeam;
    NSString *guest = _model.guestteam;
    if (isOniPhone4 || isOniPhone5) {
        if (home.length>3) {
            home = [NSString stringWithFormat:@"%@…",[home substringToIndex:3]];
        }
        if (guest.length>3) {
            guest = [NSString stringWithFormat:@"%@…",[guest substringToIndex:3]];
        }
    }else{
        if (home.length>5) {
            home = [NSString stringWithFormat:@"%@…",[home substringToIndex:5]];
        }
        if (guest.length>5) {
            guest = [NSString stringWithFormat:@"%@…",[guest substringToIndex:5]];
        }
    }
    _labHomteam.text = home;
    _labVS.text = @"vs";
    _labGuestteam.text = guest;
    _labCompany.text = @"";
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
    switch ([model.deal[@"type"] integerValue]) {
        case 3:
            self.labType.text = @"胜";
            break;
        case 1:
            self.labType.text = @"平";
            break;
        case 0:
            self.labType.text = @"负";
            break;
        default:
            break;
    }
    self.labPeLv.text = model.deal[@"price"];
    self.labgaiLv.text = model.deal[@"returnRate"];
    self.labTRLS.text = model.deal[@"profit"];
    self.labWuCha.text = model.deal[@"deviation"];
    if ([[model.deal[@"deviation"] substringToIndex:1] isEqualToString:@"-"]) {
        self.labWuCha.textColor = greencolor;
    }else if ([[model.deal[@"deviation"] substringToIndex:1] isEqualToString:@"0"]){
        self.labWuCha.textColor = color66;
    }else{
        self.labWuCha.textColor = redcolor;
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
    [self.labWuCha mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.basicView.mas_right);
        make.centerY.mas_equalTo(self.basicView.mas_centerY);
        make.width.mas_offset(40 * Scale_Ratio);
    }];
    [self.labTRLS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.labWuCha.mas_left);
        make.centerY.mas_equalTo(self.labWuCha.mas_centerY);
        make.width.mas_offset(40 * Scale_Ratio);
    }];
    [self.labgaiLv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.labTRLS.mas_left);
        make.centerY.mas_equalTo(self.labTRLS.mas_centerY);
        make.width.mas_offset(35 * Scale_Ratio);
    }];
    [self.labType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.labgaiLv.mas_left);
        make.bottom.mas_equalTo(self.basicView.mas_centerY);
        make.width.mas_offset(40 * Scale_Ratio);
    }];
    [self.labPeLv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.labgaiLv.mas_left);
        make.top.mas_equalTo(self.basicView.mas_centerY).offset(5);
        make.width.mas_offset(40 * Scale_Ratio);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.basicView.mas_bottom);
        make.left.mas_equalTo(self.basicView.mas_left);
        make.right.mas_equalTo(self.basicView.mas_right);
        make.height.mas_offset(0.5);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
