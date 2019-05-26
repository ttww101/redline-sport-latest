#import "RLSTeamViewofTuijianCell.h"
@interface RLSTeamViewofTuijianCell ()
@property (nonatomic, assign) BOOL isaddlayout;
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UILabel *labSaishi;
@property (nonatomic, strong) UILabel *labbeginTime;
@property (nonatomic, strong) UILabel *labbeginTime1;
@property (nonatomic, strong) UILabel *labMoney;
@property (nonatomic, strong) UILabel *labTeamHome;
@property (nonatomic, strong) UIImageView *imgTeamHome;
@property (nonatomic, strong) UILabel *labTeamGuest;
@property (nonatomic, strong) UIImageView *imgTeamGuest;
@property (nonatomic, strong) UILabel *labVS;
@property (nonatomic, strong) UIView *lineV;
@property (nonatomic, strong)UILabel *labPankou;
@end
@implementation RLSTeamViewofTuijianCell
- (id)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.basicView];
    }
    return self;
}
- (void)setModel:(RLSTuijiandatingModel *)model
{
    _model = model;
    _labSaishi.text = _model.Name_JS;
    _labSaishi.textColor = [RLSMethods getColor:_model.leagueColor];
    NSInteger timeI =  [RLSMethods formatTimeStr:_model.MatchTime];
    _labbeginTime.text = [RLSMethods formatMMDDWithStamp:timeI / 1000];
        if (_model.playtype == 1) {
            _labPankou.text = @"胜平负";
        }else if (_model.playtype == 2){
            _labPankou.text = @"亚指";
        }else if (_model.playtype == 3){
            _labPankou.text = @"进球数";
        }
    _labTeamHome.text = _model.HomeTeam;
    _labTeamGuest.text = _model.GuestTeam;
    if (isOniPhone5 || isOniPhone4) {
        if (_model.HomeTeam.length > 4) {
            _labTeamHome.text = [NSString stringWithFormat:@"%@...",[_model.HomeTeam substringToIndex:4]];
        }
        if (_model.GuestTeam.length > 4) {
            _labTeamGuest.text = [NSString stringWithFormat:@"%@...",[_model.GuestTeam substringToIndex:4]];
        }
    }else if (isOniphone6 || isOniphone7){
        if (_model.HomeTeam.length > 6) {
            _labTeamHome.text = [NSString stringWithFormat:@"%@...",[_model.HomeTeam substringToIndex:6]];
        }
        if (_model.GuestTeam.length > 6) {
            _labTeamGuest.text = [NSString stringWithFormat:@"%@...",[_model.GuestTeam substringToIndex:6]];
        }
    }
    if (_model.MatchState == -1) {
        _labVS.font = [UIFont boldSystemFontOfSize:fontSize14];
        _labVS.textColor = redcolor;
        _labVS.text = [NSString stringWithFormat:@"%ld:%ld",(long)_model.HomeScore,(long)_model.GuestScore];
    }else if (_model.MatchState == 1 ||_model.MatchState == 2 ||_model.MatchState == 3 ||_model.MatchState == 4) {
        _labVS.font = [UIFont boldSystemFontOfSize:fontSize14];
        _labVS.textColor = green2Color;
        _labVS.text = [NSString stringWithFormat:@"%ld:%ld",(long)_model.HomeScore,(long)_model.GuestScore];
    }else {
        _labVS.font = font14;
        _labVS.textColor = UIColorHex(#E2392D);
        _labVS.text = [RLSMethods getTextByMatchState:_model.MatchState];
    }
    [_imgTeamHome sd_setImageWithURL:[NSURL URLWithString:url_imageTeam(_model.HomeTeamID)] placeholderImage:[UIImage imageNamed:@"DefaultTeam"]];
    [_imgTeamGuest sd_setImageWithURL:[NSURL URLWithString:url_imageTeam(_model.GuestTeamID)] placeholderImage:[UIImage imageNamed:@"DefaultTeam"]];
    NSLog(@"%ld",_model.amount);
    if (_model.amount == 0) {
        _labMoney.text = @"免费";
        _labMoney.textColor = greencolor;
    }else{
        _labMoney.textColor = redcolor;
        NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"currency"];
        if (!(str.length > 0)) {
            str = @"钻石";
        }
        _labMoney.text = [NSString stringWithFormat:@" ¥ %ld",_model.amount==3800?30:_model.amount/100];
        _labMoney.attributedText = [RLSMethods withContent:_labMoney.text WithColorText:str textColor:color33 strFont:font12];
    }
    _labMoney.text = @"";
    if (!_isaddlayout) {
        _isaddlayout = YES;
        [self addlayout];
    }
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.labSaishi];
        [_basicView addSubview:self.labbeginTime];
        [_basicView addSubview:self.labPankou];
        [_basicView addSubview:self.labMoney];
        [_basicView addSubview:self.labTeamHome];
        [_basicView addSubview:self.labTeamGuest];
        [_basicView addSubview:self.imgTeamHome];
        [_basicView addSubview:self.imgTeamGuest];
        [_basicView addSubview:self.labVS];
        [_basicView addSubview:self.lineV];
    }
    return _basicView;
}
- (UILabel *)labSaishi
{
    if (!_labSaishi) {
        _labSaishi = [[UILabel alloc] init];
        _labSaishi.font = font10;
        _labSaishi.textColor = green1Color;
    }
    return _labSaishi;
}
- (UILabel *)labMoney{
    if (!_labMoney) {
        _labMoney = [[UILabel alloc] init];
        _labMoney.font = BoldFont4(fontSize12);
        _labMoney.textColor  = greencolor;
        _labMoney.text = @"免费";
    }
    return _labMoney;
}
- (UILabel *)labbeginTime
{
    if (!_labbeginTime) {
        _labbeginTime = [[UILabel alloc] init];
        _labbeginTime.font = font10;
        _labbeginTime.textColor = color66;
    }
    return _labbeginTime;
}
- (UILabel *)labTeamHome
{
    if (!_labTeamHome) {
        _labTeamHome = [[UILabel alloc] init];
        _labTeamHome.textColor = color33;
        _labTeamHome.font = BoldFont4(fontSize14);
    }
    return _labTeamHome;
}
- (UILabel *)labVS
{
    if (!_labVS) {
        _labVS = [[UILabel alloc] init];
        _labVS.font = font14;
        _labVS.textColor = color99;
    }
    return _labVS;
}
- (UILabel *)labTeamGuest
{
    if (!_labTeamGuest) {
        _labTeamGuest = [[UILabel alloc] init];
        _labTeamGuest.textColor = color33;
        _labTeamGuest.font = BoldFont4(fontSize14);
    }
    return _labTeamGuest;
}
- (UILabel *)labPankou
{
    if (!_labPankou) {
        _labPankou = [[UILabel alloc] init];
        _labPankou.font = font10;
        _labPankou.textColor = [UIColor clearColor];
    }
    return _labPankou;
}
- (UIView *)lineV
{
    if (!_lineV) {
        _lineV = [[UIView alloc] init];
        _lineV.backgroundColor =  [UIColor clearColor];
    }
    return _lineV;
}
- (UIImageView *)imgTeamHome
{
    if (!_imgTeamHome) {
        _imgTeamHome = [[UIImageView alloc] init];
    }
    return _imgTeamHome;
}
- (UIImageView *)imgTeamGuest
{
    if (!_imgTeamGuest) {
        _imgTeamGuest = [[UIImageView alloc] init];
    }
    return _imgTeamGuest;
}
- (void)addlayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).offset(0);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right).offset(0);
    }];
    [self.labSaishi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.top.equalTo(self.basicView.mas_top).offset(2.5);
    }];
    [self.labbeginTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labSaishi.mas_right).offset(5);
        make.top.equalTo(self.basicView.mas_top).offset(2.5);
    }];
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labbeginTime.mas_right).offset(5);
        make.centerY.equalTo(self.labSaishi.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(0.5, 10));
    }];
    [self.labPankou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labbeginTime.mas_right).offset(10);
        make.centerY.equalTo(self.labSaishi.mas_centerY);
    }];
    [self.labMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.labPankou.mas_bottom);
        make.right.equalTo(self.basicView.mas_right).offset(-10);
    }];
    [self.imgTeamHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(10);
        make.top.equalTo(self.labSaishi.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];
    [self.labTeamHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.top.equalTo(self.labSaishi.mas_bottom).offset(7.5);
    }];
    [self.imgTeamGuest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.basicView.mas_right).offset(-10);
        make.centerY.equalTo(self.imgTeamHome.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];
    [self.labTeamGuest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labVS.mas_right).offset(6);
        make.centerY.equalTo(self.labTeamHome.mas_centerY);
    }];
    [self.labVS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labTeamHome.mas_right).offset(6);
        make.centerY.equalTo(self.labTeamHome.mas_centerY);
    }];
}
@end
