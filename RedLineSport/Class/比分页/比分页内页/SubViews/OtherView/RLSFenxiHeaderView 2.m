#import "RLSFenxiHeaderView.h"
#import "RLSshowVideoView.h"
#import "RLSShowSignals.h"
@interface RLSFenxiHeaderView () <RLSShowSignalsDelegate>
{
}
@property (nonatomic, assign) BOOL isAddAutolayout;
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UIImageView *imagebg;
@property (nonatomic, strong) UIButton *imageback;
@property (nonatomic, strong) UILabel *labTime;
@property (nonatomic, strong) UILabel *labLeague;
@property (nonatomic, strong) UILabel *labState;
@property (nonatomic, strong) UIImageView *imageAnimation;
@property (nonatomic, strong) UILabel *labHscore;
@property (nonatomic, strong) UILabel *labGscore;
@property (nonatomic, strong) UILabel *labHome;
@property (nonatomic, strong) UILabel *labGuest;
@property (nonatomic, strong) UIImageView *imageHome;
@property (nonatomic, strong) UIImageView *imageGuest;
@property (nonatomic, strong) UIImageView           *basicBottomView;
@property (nonatomic, strong) UIImageView           *iconTQ;
@property (nonatomic, strong) UILabel               *labTQ;
@property (nonatomic, strong) UILabel               *labTQNum;
@property (nonatomic, strong) UILabel               *labPlace;
@property (nonatomic, strong) UILabel               *labAdress;
@property (nonatomic, strong) UILabel               *labHomeOrder;
@property (nonatomic, strong) UILabel               *labGuestOrder;
@property (nonatomic, assign) BOOL hideHeader;
@property (nonatomic , strong) UIButton *liveVideoBtn;
@property (nonatomic, copy) NSArray *signalLists;

@property (nonatomic , strong) RLSShowSignals *choiceSignalView;

@end
@implementation RLSFenxiHeaderView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (void)changeCountTimeWithTime:(NSString *)countTime
{
    if ([countTime isEqualToString:@"VS"]) {
        _labState.text = @"";
    }else{
        _labState.text = @"";
    }
    _labHscore.text = countTime;
}
- (void)updateScroeWithmodel:(RLSLiveScoreModel *)liviModel{
    NSString *time = [RLSMethods getDateByStyle:dateStyleFormatter withDate:[NSDate date]];
    if (liviModel.matchstate == 1 || liviModel.matchstate == 3) {
        [_imageAnimation startAnimating];
    }else{
        if ([_imageAnimation isAnimating]) {
            [_imageAnimation stopAnimating];
        }
    }
    if (liviModel.matchstate == -1) {
        _labState.text = @"完";
        _labHscore.text = [NSString stringWithFormat:@"%ld:%ld", liviModel.homescore,liviModel.guestscore];
    }else if (liviModel.matchstate == 1 ){
        NSString *timeCha =[RLSMethods intervalFromLastDate:liviModel.matchtime2 toTheDate:time];
        if ([timeCha isEqualToString:@"0"]) {
            _labState.text = @"1";
        }else{
            if ([timeCha intValue]>45) {
                _labState.text =@"45+";
            }else{
                _labState.text =timeCha;
            }
        }
        _labHscore.text = [NSString stringWithFormat:@"%ld:%ld", liviModel.homescore,liviModel.guestscore];
    }else if(liviModel.matchstate == 2){
        _labState.text = @"中场";
        _labHscore.text = [NSString stringWithFormat:@"%ld:%ld", liviModel.homescore,liviModel.guestscore];
    }else if(liviModel.matchstate == 3){
        NSString *timeCha =[RLSMethods intervalFromLastDateAnd45:liviModel.matchtime2 toTheDate:time];
        if ([timeCha isEqualToString:@"45"]) {
            _labState.text = @"46";
        }else{
            if ([timeCha intValue]>90) {
                _labState.text =@"90+";
            }else{
                _labState.text =timeCha;
            }
        }
        _labHscore.text = [NSString stringWithFormat:@"%ld:%ld", liviModel.homescore,liviModel.guestscore];
    }else if(liviModel.matchstate == 4){
        _labState.text = @"加时";
        _labHscore.text = [NSString stringWithFormat:@"%ld:%ld", liviModel.homescore,liviModel.guestscore];
    }else if(liviModel.matchstate == 0){
        _labState.text = @"";
        _labHscore.text = @"VS";
    }else{
        _labState.text = [RLSMethods getTextByMatchState:liviModel.matchstate];
        _labHscore.text = @"VS";
    }
}
- (void)setModel:(RLSLiveScoreModel *)model{
    [self checkoutVideoSignal];
    _model = model;
    [self addSubview:self.basicView];
    [_imageback setBackgroundImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
    [_imageRight setBackgroundImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
    [_imageback setBackgroundImage:[UIImage imageNamed:@"clear"] forState:UIControlStateHighlighted];
    [_imageRight setBackgroundImage:[UIImage imageNamed:@"clear"] forState:UIControlStateHighlighted];
    _labTime.text = [RLSMethods getDateByStyle:dateStyleFormatterMdHm withDate:[RLSMethods getDateFromString:_model.matchtime byformat:dateStyleFormatter]];
    _labLeague.text = _model.league;
    _labHscore.text = @"";
    _labGscore.text = @"";
    NSString *time = [RLSMethods getDateByStyle:dateStyleFormatter withDate:[NSDate date]];
    if (_model.matchstate == 1 || _model.matchstate == 3) {
        [_imageAnimation startAnimating];
    }else{
        if ([_imageAnimation isAnimating]) {
            [_imageAnimation stopAnimating];
        }
    }
    if (_model.matchstate == -1) {
        _labState.text = @"完";
        _labHscore.text = [NSString stringWithFormat:@"%ld:%ld", _model.homescore,_model.guestscore];
    }else if (_model.matchstate == 1 ){
        NSString *timeCha =[RLSMethods intervalFromLastDate:_model.matchtime2 toTheDate:time];
        if ([timeCha isEqualToString:@"0"]) {
            _labState.text = @"1";
        }else{
            if ([timeCha intValue]>45) {
                _labState.text =@"45+";
            }else{
                _labState.text =timeCha;
            }
        }
        _labHscore.text = [NSString stringWithFormat:@"%ld:%ld", _model.homescore,_model.guestscore];
    }else if(_model.matchstate == 2){
        _labState.text = @"中场";
        _labHscore.text = [NSString stringWithFormat:@"%ld:%ld", _model.homescore,_model.guestscore];
    }else if(_model.matchstate == 3){
        NSString *timeCha =[RLSMethods intervalFromLastDateAnd45:_model.matchtime2 toTheDate:time];
        if ([timeCha isEqualToString:@"45"]) {
            _labState.text = @"46";
        }else{
            if ([timeCha intValue]>90) {
                _labState.text =@"90+";
            }else{
                _labState.text =timeCha;
            }
        }
        _labHscore.text = [NSString stringWithFormat:@"%ld:%ld", _model.homescore,_model.guestscore];
    }else if(_model.matchstate == 4){
        _labState.text = @"加时";
        _labHscore.text = [NSString stringWithFormat:@"%ld:%ld", _model.homescore,_model.guestscore];
    }else if(_model.matchstate == 0){
        _labState.text = @"";
        _labHscore.text = @"VS";
    }else{
        _labState.text = [RLSMethods getTextByMatchState:_model.matchstate];
        _labHscore.text = @"VS";
    }
    if (_model.homeOrder!= nil && ![_model.homeOrder isEqualToString:@""] && _model.guestOrder!= nil && ![_model.guestOrder isEqualToString:@""]) {
    }else{
    }
    if (_hideHeader) {
        [_imageHome setImage:[UIImage imageNamed:@"clear"]];
        [_imageGuest setImage:[UIImage imageNamed:@"clear"]];
        _imageAnimation.hidden = YES;
    }else{
        [_imageHome sd_setImageWithURL:[NSURL URLWithString:url_imageTeam(_model.hometeamid)] placeholderImage:[UIImage imageNamed:@"DefaultTeam"]];
        [_imageGuest sd_setImageWithURL:[NSURL URLWithString:url_imageTeam(_model.guestteamid)] placeholderImage:[UIImage imageNamed:@"DefaultTeam"]];
        _imageAnimation.hidden = NO;
    }
    _imageHome.contentMode = UIViewContentModeScaleAspectFit;
    _imageGuest.contentMode = UIViewContentModeScaleAspectFit;
    [self setTeamName];
    if (!_isAddAutolayout) {
        _isAddAutolayout = YES;
        [self addAutolayout];
    }
    if (_model.temperature == nil && _model.weather == nil && _model.location == nil) {
        _basicBottomView.hidden = YES;
    }else{
        if (_model.temperature) {
            _labTQNum.text = _model.temperature;
        }
        if (_model.location) {
            _labPlace.hidden = NO;
            _labAdress.text = _model.location;
        }
        if ([_model.location isEqualToString:@""]) {
            _labAdress.text = @"暂无";
        }
        _labHomeOrder.text = _model.homeOrder;
        _labGuestOrder.text = _model.guestOrder;
        if ([_model.weather isEqualToString:@"7"]) {
            _labTQ.text = @"雪";
            _iconTQ.image = [UIImage imageNamed:@"xuetian"];
            _imagebg.image = [UIImage imageNamed:@"xuetianbg"];
        }
        if ([_model.weather  isEqualToString:@"8"]||[_model.weather isEqualToString:@"9"]) {
            if ([_model.weather isEqualToString:@"8"]) {
                _labTQ.text = @"雷暴";
            }else{
                _labTQ.text = @"地区性雷暴";
            }
            _iconTQ.image = [UIImage imageNamed:@"leidian"];
            _imagebg.image = [UIImage imageNamed:@"leidianbg"];
        }
        if ([_model.weather  isEqualToString:@"1"]||[_model.weather  isEqualToString:@"2"]) {
            if ([_model.weather isEqualToString:@"1"]) {
                _labTQ.text = @"天晴";
            }
            if ([_model.weather isEqualToString:@"2"]) {
                _labTQ.text = @"大致天晴";
            }
            _iconTQ.image = [UIImage imageNamed:@"qingtian"];
            _imagebg.image = [UIImage imageNamed:@"qingtianbg"];
        }
        if ([_model.weather  isEqualToString:@"5"]||[_model.weather  isEqualToString:@"6"]||[_model.weather  isEqualToString:@"11"]||[_model.weather  isEqualToString:@"13"]) {
            if ([_model.weather isEqualToString:@"5"]) {
                _labTQ.text = @"微雨";
            }
            if ([_model.weather isEqualToString:@"6"]) {
                _labTQ.text = @"大雨";
            }
            if ([_model.weather isEqualToString:@"11"]) {
                _labTQ.text = @"中雨";
            }
            if ([_model.weather isEqualToString:@"13"]) {
                _labTQ.text = @"雷陣雨";
            }
            _iconTQ.image = [UIImage imageNamed:@"xiayu"];
            _imagebg.image = [UIImage imageNamed:@"xiayubg"];
        }
        if ([_model.weather  isEqualToString:@"3"]||[_model.weather  isEqualToString:@"4"]||[_model.weather  isEqualToString:@"12"]) {
            if ([_model.weather isEqualToString:@"3"]) {
                _labTQ.text = @"间中有云";
            }
            if ([_model.weather isEqualToString:@"4"]) {
                _labTQ.text = @"多云";
            }
            if ([_model.weather isEqualToString:@"12"]) {
                _labTQ.text = @"阴天";
            }
            _iconTQ.image = [UIImage imageNamed:@"yintian"];
            _imagebg.image = [UIImage imageNamed:@"yintianbg"];
        }
        if ([_model.weather  isEqualToString:@"10"]) {
            _labTQ.text = @"有雾";
            _iconTQ.image = [UIImage imageNamed:@"wutian"];
            _imagebg.image = [UIImage imageNamed:@"wutianbg"];
        }
    }
}
- (void)setTeamName
{
    _labHome.text = _model.hometeam;
    _labGuest.text = _model.guestteam;
}
- (void)setTeamNamefor6
{
    NSString *home;
    if (_model.hometeam.length>6) {
        home = [NSString stringWithFormat:@"%@…",[_model.hometeam substringToIndex:6]];
    }else{
        home = _model.hometeam;
    }
    NSString *away;
    if (_model.guestteam.length>6) {
        away = [NSString stringWithFormat:@"%@…",[_model.guestteam substringToIndex:6]];
    }else{
        away = _model.guestteam;
    }
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"_currentflag"] isEqualToString:@"0"])
    {
        if (_model.neutrality) {
            _labHome.text = away;
            _labGuest.text = home;
        }else{
            _labHome.text = home;
            _labGuest.text = away;
        }
    }else{
        _labHome.text = home;
        _labGuest.text = away;
    }
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        _basicView.backgroundColor = [UIColor lightGrayColor];
        [_basicView addSubview:self.imagebg];
        [_basicView addSubview:self.imageback];
        [_basicView addSubview:self.imageRight];
        [_basicView addSubview:self.labLeague];
        [_basicView addSubview:self.labTime];
        [_basicView addSubview:self.imageAnimation];
        [_basicView addSubview:self.labHscore];
        [_basicView addSubview:self.labGscore];
        [_basicView addSubview:self.labState];
        [_basicView addSubview:self.imageHome];
        [_basicView addSubview:self.imageGuest];
        [_basicView addSubview:self.labHome];
        [_basicView addSubview:self.labGuest];
        [_basicView addSubview:self.labHomeOrder];
        [_basicView addSubview:self.labGuestOrder];
        [_basicView addSubview:self.basicBottomView];
        [self.basicBottomView addSubview:self.iconTQ];
        [self.basicBottomView addSubview:self.labTQ];
        [self.basicBottomView addSubview:self.labTQNum];
        [self.basicBottomView addSubview:self.labPlace];
        [self.basicBottomView addSubview:self.labAdress];
        [_basicView addSubview:self.liveVideoBtn];
    }
    return _basicView;
}
- (UIImageView *)imageAnimation
{
    if (!_imageAnimation) {
        _imageAnimation = [[UIImageView alloc] init];
        _imageAnimation.animationImages = [NSArray arrayWithObjects:[[UIImage imageNamed:@"clear"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],[UIImage imageNamed:@"white"], nil];
        _imageAnimation.animationDuration = 1;
        _imageAnimation.animationRepeatCount = MAXFLOAT;
    }
    return _imageAnimation;
}
- (UIImageView *)imagebg
{
    if (!_imagebg) {
        _imagebg = [[UIImageView alloc] init];
        _imagebg.image = [UIImage imageNamed:@"qiuchang"];
    }
    return _imagebg;
}
- (UIButton *)imageback
{
    if (!_imageback) {
        _imageback = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageback.tag = 1;
        [_imageback addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imageback;
}
- (UIButton *)imageRight
{
    if (!_imageRight) {
        _imageRight = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageRight.tag = 2;
        [_imageRight addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imageRight;
}
- (void)back:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(backClick:)]) {
        [self.delegate backClick:btn.tag];
    }
}
- (UILabel *)labTime
{
    if (!_labTime) {
        _labTime = [[UILabel alloc] init];
        _labTime.font = font12;
        _labTime.textColor = [UIColor whiteColor];
    }
    return _labTime;
}
- (UILabel *)labLeague
{
    if (!_labLeague) {
        _labLeague = [[UILabel alloc] init];
        _labLeague.font = BoldFont4(fontSize14);
        _labLeague.textColor =[UIColor whiteColor];
    }
    return _labLeague;
}
- (UILabel *)labState
{
    if (!_labState) {
        _labState = [[UILabel alloc] init];
        _labState.font = font12;
        _labState.textColor = [UIColor whiteColor];
    }
    return _labState;
}
- (UILabel *)labHscore
{
    if (!_labHscore) {
        _labHscore = [[UILabel alloc] init];
        _labHscore.font = font24;
        _labHscore.textColor = [UIColor whiteColor];
    }
    return _labHscore;
}
- (UILabel *)labGscore
{
    if (!_labGscore) {
        _labGscore = [[UILabel alloc] init];
        _labGscore.font = font24;
        _labGscore.textColor = [UIColor whiteColor];
    }
    return _labGscore;
}
- (UIImageView *)imageHome
{
    if (!_imageHome) {
        _imageHome = [[UIImageView alloc] init];
    }
    return _imageHome;
}
- (UIImageView *)imageGuest
{
    if (!_imageGuest) {
        _imageGuest = [[UIImageView alloc] init];
    }
    return  _imageGuest;
}
- (UILabel *)labGuest
{
    if (!_labGuest) {
        _labGuest = [[UILabel alloc] init];
        _labGuest.font = BoldFont4(fontSize12);
        _labGuest.textColor = [UIColor whiteColor];
        _labGuest.textAlignment = NSTextAlignmentCenter;
    }
    return _labGuest;
}
- (UILabel *)labHome
{
    if (!_labHome) {
        _labHome = [[UILabel alloc] init];
        _labHome.font = BoldFont4(fontSize12);
        _labHome.textColor = [UIColor whiteColor];
        _labHome.textAlignment = NSTextAlignmentCenter;
    }
    return _labHome;
}
- (UILabel *)labHomeOrder {
    if (!_labHomeOrder) {
        _labHomeOrder = [UILabel new];
        _labHomeOrder.font = font8;
        _labHomeOrder.textColor = colorD6;
    }
    return _labHomeOrder;
}
- (UILabel *)labGuestOrder {
    if (!_labGuestOrder) {
        _labGuestOrder = [UILabel new];
        _labGuestOrder.font = font8;
        _labGuestOrder.textColor = colorD6;
    }
    return _labGuestOrder;
}
- (UIImageView *)basicBottomView {
    if (!_basicBottomView) {
        _basicBottomView = [UIImageView new];
        _basicBottomView.image = [UIImage imageNamed:@"bottomView"];
    }
    return _basicBottomView;
}
- (UIImageView *)iconTQ {
    if (!_iconTQ) {
        _iconTQ = [UIImageView new];
    }
    return  _iconTQ;
}
- (UILabel *)labTQ {
    if (!_labTQ) {
        _labTQ = [UILabel new];
        _labTQ.font = font10;
        _labTQ.textColor = [UIColor whiteColor];
    }
    return _labTQ;
}
- (UILabel *)labTQNum {
    if (!_labTQNum) {
        _labTQNum = [UILabel new];
        _labTQNum.font = font10;
        _labTQNum.textColor = [UIColor whiteColor];
    }
    return _labTQNum;
}
- (UILabel *)labPlace {
    if (!_labPlace) {
        _labPlace = [UILabel new];
        _labPlace.text = @"球场: ";
        _labPlace.font = font10;
        _labPlace.textColor = [UIColor whiteColor];
    }
    return _labPlace;
}
- (UILabel *)labAdress {
    if (!_labAdress) {
        _labAdress = [UILabel new];
        _labAdress.text = @"上海体育馆";
        _labAdress.font = font10;
        _labAdress.textColor = [UIColor whiteColor];
    }
    return _labAdress;
}
- (UIButton *)liveVideoBtn {
    if (_liveVideoBtn == nil) {
        _liveVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_liveVideoBtn setBackgroundImage:[UIImage imageNamed:@"liveimage"] forState:UIControlStateNormal];
        [_liveVideoBtn addTarget:self action:@selector(liveAction) forControlEvents:UIControlEventTouchUpInside];
        _liveVideoBtn.hidden = true;
    }
    return _liveVideoBtn;
}

#pragma mark - RLSShowSignalsDelegate

- (void)didSelectItem:(NSDictionary *)data {
    NSString *url = data[@"url"];
    if ([data[@"type"] integerValue] == 2) {
        if (url.length > 0) {
            RLSshowVideoView *video = [[RLSshowVideoView alloc]init];
            video.url = url;
            [[RLSMethods getMainWindow] addSubview:video];
        }
    } else {
        if (_delegate && [_delegate respondsToSelector:@selector(tapPlayVideoAction:)]) {
            [_delegate tapPlayVideoAction:url];
        }
    }
}

#pragma mark - Live Action
- (void)liveAction {
    if (_model.matchstate == 0) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"比赛未开始"];
        return;
    } else if (_model.matchstate < 0) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"比赛已结束"];
         return;
    }

    if (self.signalLists.count > 1) {
        if (!_choiceSignalView) {
            _choiceSignalView = [[RLSShowSignals alloc]initWithFrame:CGRectMake(0, 0, Width, Height) mid:[NSString stringWithFormat:@"%zi", _model.mid]];
            _choiceSignalView.delegate = self;
            [[RLSMethods help_getCurrentVC].view addSubview:_choiceSignalView];
        }
        [_choiceSignalView showSignals:self.signalLists];
        
    } else {
        NSDictionary *data = [self.signalLists firstObject];
        NSString *url = data[@"url"];
        if ([data[@"type"] integerValue] == 2) {
            if (url.length > 0) {
                RLSshowVideoView *video = [[RLSshowVideoView alloc]init];
                video.url = url;
                [[RLSMethods getMainWindow] addSubview:video];
            }
        } else {
                if (_delegate && [_delegate respondsToSelector:@selector(tapPlayVideoAction:)]) {
                    [_delegate tapPlayVideoAction:url];
                }
        }
    }
}
- (void)addAutolayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.imagebg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.imageback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top).offset(20);
        make.left.equalTo(self.basicView.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    [self.imageRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top).offset(20);
        make.right.equalTo(self.basicView.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    [self.labLeague mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.basicView.mas_centerX);
        make.top.mas_equalTo(30);
    }];
    [self.labHscore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.basicView.mas_centerX);
        make.top.equalTo(self.labLeague.mas_bottom).offset(5);
    }];
    [self.imageAnimation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labState.mas_right).offset(2);
        make.top.equalTo(self.labState.mas_top).offset(0);
        make.size.mas_equalTo(CGSizeMake(3, 3));
    }];
    [self.labTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labHscore.mas_bottom).offset(5);
        make.centerX.equalTo(self.basicView.mas_centerX);
    }];
    [self.labState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTime.mas_bottom).offset(10);
        make.centerX.equalTo(self.basicView.mas_centerX);
    }];
    [self.labGscore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labHscore.mas_centerY);
        make.centerX.equalTo(self.basicView.mas_centerX);
    }];
    [self.imageHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top).offset(20 + 44 + 5 - 10);
        make.left.equalTo(self.basicView.mas_left).offset((Width - 110)/4- 30);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [self.imageGuest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top).offset(20 +44 + 5 - 10);
        make.right.equalTo(self.basicView.mas_right).offset(-((Width - 110)/4- 30));
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [self.labHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageHome.mas_bottom).offset(10);
        make.centerX.equalTo(self.imageHome.mas_centerX);
        make.width.mas_equalTo(115*Scale_Ratio_width);
    }];
    [self.labGuest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageGuest.mas_bottom).offset(10);
        make.centerX.equalTo(self.imageGuest.mas_centerX);
        make.width.mas_equalTo(115*Scale_Ratio_width);
    }];
    [self.labHomeOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.labHome.mas_centerX);
        make.top.equalTo(self.labHome.mas_bottom).offset(3);
    }];
    [self.labGuestOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.labGuest.mas_centerX);
        make.top.equalTo(self.labGuest.mas_bottom).offset(3);
    }];
    [self.labHome layoutIfNeeded];
    [self.basicBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labHome.mas_bottom).offset(15+10);
        make.width.mas_equalTo(Width);
        make.height.mas_equalTo(20);
    }];
    [self.iconTQ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.basicBottomView);
        make.leading.equalTo(self.basicBottomView).mas_offset(16);
        make.size.mas_equalTo(CGSizeMake(16, 17));
    }];
    [self.labTQ  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconTQ);
        make.leading.equalTo(self.iconTQ.mas_trailing).offset(8);
    }];
    [self.labTQNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labTQ);
        make.leading.equalTo(self.labTQ.mas_trailing).offset(8);
        make.height.equalTo(self.labTQ);
    }];
    [self.labAdress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.basicBottomView);
        make.trailing.equalTo(self.basicBottomView).mas_offset(-16);
        make.height.equalTo(self.iconTQ);
    }];
    [self.labPlace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labAdress);
        make.trailing.equalTo(self.labAdress.mas_leading).offset(-4);
        make.height.equalTo(self.iconTQ);
    }];
    [self.liveVideoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.basicView.mas_centerX);
        make.top.equalTo(self.labState.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
}
- (void)hideBottom
{
    [self.labState.superview layoutIfNeeded];
    [self.labHome.superview layoutIfNeeded];
    [self.labGuest.superview layoutIfNeeded];
    _hideHeader = YES;
    _imageAnimation.hidden = YES;
    [self setTeamNamefor6];
    [UIView animateWithDuration:1 animations:^{
        [self.labHscore mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.basicView.mas_centerX);
            make.centerY.equalTo(self.imageback.mas_centerY);
        }];
        [self.labHome mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.imageback.mas_centerY);
            make.right.equalTo(self.labHscore.mas_left).offset(-12);
        }];
        [self.labGuest mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.imageback.mas_centerY);
            make.left.equalTo(self.labHscore.mas_right).offset(12);
        }];
    }completion:^(BOOL finished) {
        if (finished) {
            _labHscore.font = font14;
            _labHome.font = BoldFont4(fontSize16);
            _labGuest.font = BoldFont4(fontSize16);
        }
    }];
    [self.labState.superview layoutIfNeeded];
    [self.labHome.superview layoutIfNeeded];
    [self.labGuest.superview layoutIfNeeded];
    _labTime.textColor = [UIColor clearColor];
    _labLeague.textColor = [UIColor clearColor];
    _imageHome.image = [UIImage imageNamed:@"clear"];
    _imageGuest.image = [UIImage imageNamed:@"clear"];
    _labState.textColor = [UIColor clearColor];
    _labGscore.textColor = [UIColor clearColor];
}
- (void)showBottom
{
    [self.labState.superview layoutIfNeeded];
    [self.labHome.superview layoutIfNeeded];
    [self.labGuest.superview layoutIfNeeded];
    [UIView animateWithDuration:1 animations:^{
        [self.labHscore mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.labState.mas_bottom).offset(5);
            make.centerX.equalTo(self.basicView.mas_centerX);
        }];
        [self.labHome mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageHome.mas_bottom).offset(6);
            make.centerX.equalTo(self.imageHome.mas_centerX);
        }];
        [self.labGuest mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageGuest.mas_bottom).offset(6);
            make.centerX.equalTo(self.imageGuest.mas_centerX);
        }];
    }completion:^(BOOL finished) {
        _hideHeader = NO;
        if (finished) {
            _labHscore.font = font24;
            _labHome.font = font12;
            _labGuest.font = font12;
            [self setTeamName];
        }
    }];
    [self.labState.superview layoutIfNeeded];
    [self.labHome.superview layoutIfNeeded];
    [self.labGuest.superview layoutIfNeeded];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _labTime.textColor = [UIColor whiteColor];
        _labLeague.textColor = [UIColor whiteColor];
        _labState.textColor = [UIColor whiteColor];
        _labGscore.textColor = [UIColor whiteColor];
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"_currentflag"] isEqualToString:@"0"]) {
            if (_model.neutrality) {
                [_imageHome sd_setImageWithURL:[NSURL URLWithString:url_imageTeam(_model.guestteamid)] placeholderImage:[UIImage imageNamed:@"DefaultTeam"]];
                [_imageGuest sd_setImageWithURL:[NSURL URLWithString:url_imageTeam(_model.hometeamid)] placeholderImage:[UIImage imageNamed:@"DefaultTeam"]];
            }else{
                [_imageHome sd_setImageWithURL:[NSURL URLWithString:url_imageTeam(_model.hometeamid)] placeholderImage:[UIImage imageNamed:@"DefaultTeam"]];
                [_imageGuest sd_setImageWithURL:[NSURL URLWithString:url_imageTeam(_model.guestteamid)] placeholderImage:[UIImage imageNamed:@"DefaultTeam"]];
            }
        }else{
            [_imageHome sd_setImageWithURL:[NSURL URLWithString:url_imageTeam(_model.hometeamid)] placeholderImage:[UIImage imageNamed:@"DefaultTeam"]];
            [_imageGuest sd_setImageWithURL:[NSURL URLWithString:url_imageTeam(_model.guestteamid)] placeholderImage:[UIImage imageNamed:@"DefaultTeam"]];
        }
    });
}


- (void)checkoutVideoSignal {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
        [parameter setObject:@(_model.mid) forKey:@"mid"];
        [parameter setObject:[NSString stringWithFormat:@"%zi",_model.mid ] forKey:@"mid"];
        [[RLSDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_video_list] Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
        } Success:^(id responseResult, id responseOrignal) {
            NSArray *data = responseOrignal[@"data"];
            dispatch_async(dispatch_get_main_queue(), ^{
                 self.signalLists = data;
                if (data.count > 0) {
                    _liveVideoBtn.hidden = false;
                    
                } else {
                      _liveVideoBtn.hidden = true;
                }
               
            });
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
    
        }];
    });
}


@end
