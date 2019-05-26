#import "RLSFirstQBView.h"
#import "RLSFenxiPageVC.h"
@interface RLSFirstQBView()
@property (nonatomic, strong)UILabel *labLeague;
@property (nonatomic, strong)UILabel *labTime;
@property (nonatomic, strong)UILabel *labMiao;
@property (nonatomic, strong)UIImageView *imgHome;
@property (nonatomic, strong)UIImageView *imgGues;
@property (nonatomic, strong)UILabel *labHome;
@property (nonatomic, strong)UILabel *labGues;
@property (nonatomic, strong)UILabel *labScore;
@property (nonatomic, strong)UILabel *labPanOne;
@property (nonatomic, strong)UILabel *labPanTwo;
@property (nonatomic, strong)UILabel *labPanThree;
@property (nonatomic, strong)UILabel *labTypeOne;
@property (nonatomic, strong)UILabel *labTypeTwo;
@property (nonatomic, strong)UILabel *labContent;
@property (nonatomic, strong)UIButton *btn;
@property (nonatomic, strong) UIImageView *imageAnimation;
@property (nonatomic, assign)BOOL isToFenxi;
@end
@implementation RLSFirstQBView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self addSubview:self.btn];
        [self addSubview:self.labLeague];
        [self addSubview:self.labTime];
        [self addSubview:self.labMiao];
        [self addSubview:self.labHome];
        [self addSubview:self.labGues];
        [self addSubview:self.imgHome];
        [self addSubview:self.imgGues];
        [self addSubview:self.labScore];
        [self addSubview:self.labPanOne];
        [self addSubview:self.labPanTwo];
        [self addSubview:self.labPanThree];
        [self addSubview:self.labTypeOne];
        [self addSubview:self.labTypeTwo];
        [self addSubview:self.labContent];
        [self addSubview:self.imageAnimation];
    }
    return self;
}
- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setBackgroundImage:[UIImage imageNamed:@"f5f5f5"] forState:UIControlStateHighlighted];
        [_btn setBackgroundImage:nil forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(tapFPinfo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}
- (void)tapFPinfo{
    if (!_isToFenxi == YES) {
        _isToFenxi = YES;
    }else{
        return;
    }
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@"3" forKey:@"flag"];
    [parameter setObject:@(self.model.mid) forKey:@"sid"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveScores] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            RLSLiveScoreModel *model = [RLSLiveScoreModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            model.neutrality = NO;
            RLSFenxiPageVC *fenxiVC = [[RLSFenxiPageVC alloc] init];
            fenxiVC.model = model;
            fenxiVC.currentIndex = 2;
            fenxiVC.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:fenxiVC animated:YES];
        }
        _isToFenxi = NO;
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        _isToFenxi = NO;
    }];
}
- (UILabel *)labLeague{
    if (!_labLeague) {
        _labLeague = [[UILabel alloc] init];
        _labLeague.font = font12;
        _labLeague.textColor = color66;
        _labLeague.text = @"国王杯";
    }
    return _labLeague;
}
- (UILabel *)labTime{
    if (!_labTime) {
        _labTime = [[UILabel alloc] init];
        _labTime.font = font12;
        _labTime.textColor = color66;
        _labTime.text = @"04-01 23:50";
    }
    return _labTime;
}
- (UILabel *)labMiao{
    if (!_labMiao) {
        _labMiao = [[UILabel alloc] init];
        _labMiao.font = font12;
        _labMiao.textColor = greencolor;
        _labMiao.text = @"";
    }
    return _labMiao;
}
- (UIImageView *)imgHome{
    if (!_imgHome) {
        _imgHome = [[UIImageView alloc] init];
        _imgHome.image = [UIImage imageNamed:@"DefaultTeam"];
    }
    return _imgHome;
}
- (UIImageView *)imgGues{
    if (!_imgGues) {
        _imgGues = [[UIImageView alloc] init];
        _imgGues.image = [UIImage imageNamed:@"DefaultTeam"];
    }
    return _imgGues;
}
- (UILabel *)labHome{
    if (!_labHome) {
        _labHome = [[UILabel alloc] init];
        _labHome.textColor = color33;
        _labHome.font = font14;
        _labHome.text = @"德累斯顿";
    }
    return _labHome;
}
- (UILabel *)labGues{
    if (!_labGues) {
        _labGues = [[UILabel alloc] init];
        _labGues.font = font14;
        _labGues.textColor = color33;
        _labGues.text = @"杜塞尔多夫";
    }
    return _labGues;
}
- (UILabel *)labScore{
    if (!_labScore) {
        _labScore = [[UILabel alloc] init];
        _labScore.font = font16;
        _labScore.textColor = greencolor;
        _labScore.text = @"2:2";
    }
    return _labScore;
}
- (UILabel *)labPanOne{
    if (!_labPanOne) {
        _labPanOne = [[UILabel alloc] init];
        _labPanOne.textColor = color33;
        _labPanOne.font = font10;
        _labPanOne.text = @"0.80";
    }
    return _labPanOne;
}
- (UILabel *)labPanTwo{
    if (!_labPanTwo) {
        _labPanTwo = [[UILabel alloc] init];
        _labPanTwo.font = font10;
        _labPanTwo.textColor = color66;
        _labPanTwo.text = @"球半／两球半";
    }
    return _labPanTwo;
}
- (UILabel *)labPanThree{
    if (!_labPanThree) {
        _labPanThree = [[UILabel alloc] init];
        _labPanThree.font = font10;
        _labPanThree.textColor = color33;
        _labPanThree.text = @"1.03";
    }
    return _labPanThree;
}
- (UILabel *)labTypeOne{
    if (!_labTypeOne) {
        _labTypeOne = [[UILabel alloc] init];
        _labTypeOne.font = font10;
        _labTypeOne.textColor = bluecolor;
        _labTypeOne.layer.cornerRadius = 3;
        _labTypeOne.layer.borderWidth = 1;
        _labTypeOne.layer.borderColor = bluecolor.CGColor;
        _labTypeOne.textAlignment = NSTextAlignmentCenter;
        _labTypeOne.text = @"情报";
    }
    return _labTypeOne;
}
- (UILabel *)labTypeTwo{
    if (!_labTypeTwo) {
        _labTypeTwo = [[UILabel alloc] init];
        _labTypeTwo.font = font10;
        _labTypeTwo.textColor = redcolor;
        _labTypeTwo.layer.cornerRadius = 3;
        _labTypeTwo.layer.borderWidth = 1;
        _labTypeTwo.layer.borderColor = redcolor.CGColor;
        _labTypeTwo.textAlignment = NSTextAlignmentCenter;
        _labTypeTwo.text = @"推荐";
    }
    return _labTypeTwo;
}
- (UILabel *)labContent{
    if (!_labContent ) {
        _labContent = [[UILabel alloc] init];
        _labContent.textColor = color66;
        _labContent.font = font12;
        _labContent.text = @"曼联一周三赛赛杯主场强势程苦，欧洲杯主场强势；罗斯托夫防守稳固，做客老特拉福德能否爆冷";
        _labContent.numberOfLines = 2;
    }
    return _labContent;
}
- (UIImageView *)imageAnimation
{
    if (!_imageAnimation) {
        _imageAnimation = [[UIImageView alloc] init];
        _imageAnimation.animationImages = [NSArray arrayWithObjects:[[UIImage imageNamed:@"clear"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],[UIImage imageNamed:@"redRound"], nil];
        _imageAnimation.animationDuration = 1;
        _imageAnimation.animationRepeatCount = MAXFLOAT;
    }
    return _imageAnimation;
}
- (void)setModel:(RLSFirstPInfoListModel *)model{
    _model = model;
    self.labLeague.text = model.league;
    self.labTime.text = [RLSMethods getDateByStyle:dateStyleFormatterMdHm withDate:[NSDate dateWithTimeIntervalSince1970:model.matchtime/1000]];
    self.labHome.text = model.hometeam;
    self.labGues.text = model.guestteam;
    if (model.hometeam.length > 6 && (isOniphone6 || isOniphone7)) {
        self.labHome.text = [NSString stringWithFormat:@"%@...",[model.hometeam substringToIndex:6]];
    }else if (model.hometeam.length > 4 && (isOniPhone4 || isOniPhone5)){
        self.labHome.text = [NSString stringWithFormat:@"%@...",[model.hometeam substringToIndex:4]];
    }
    if (model.guestteam.length > 6 && (isOniphone6 || isOniphone7)) {
        self.labGues.text = [NSString stringWithFormat:@"%@...",[model.guestteam substringToIndex:6]];
    }else if (model.guestteam.length > 4 && (isOniPhone4 || isOniPhone5)){
        self.labGues.text = [NSString stringWithFormat:@"%@...",[model.guestteam substringToIndex:4]];
    }
    [self.imgHome sd_setImageWithURL:[NSURL URLWithString:url_imageTeam((long)model.hometeamid)] placeholderImage:[UIImage imageNamed:@"DefaultTeam"]];
    [self.imgGues sd_setImageWithURL:[NSURL URLWithString:url_imageTeam((long)model.guestteamid)] placeholderImage:[UIImage imageNamed:@"DefaultTeam"]];
    if (_model.ya) {
        self.labPanTwo.text = _model.ya.Goal;
        self.labPanOne.text = _model.ya.UpOdds;
        self.labPanThree.text = _model.ya.DownOdds;
    }else{
        self.labPanTwo.text = @"";
        self.labPanOne.text = @"";
        self.labPanThree.text = @"";
    }
    [self.labContent setAttributedText:[RLSMethods setTextStyleWithString:model.matchintro WithLineSpace:6 WithHeaderIndent:0]];
    if (model.info > 0) {
        self.labTypeOne.hidden = NO;
    }else{
        self.labTypeOne.hidden = YES;
    }
    if (model.recommand > 0) {
        self.labTypeTwo.hidden = NO;
    }else{
        self.labTypeTwo.hidden = YES;
    }
    NSString *time = [RLSMethods getDateByStyle:dateStyleFormatter withDate:[NSDate date]];
    if (_model.matchstate == 1 || _model.matchstate == 3) {
        [_imageAnimation startAnimating];
    }else{
        if ([_imageAnimation isAnimating]) {
            [_imageAnimation stopAnimating];
        }
    }
    if (_model.matchstate == -1) {
        self.labMiao.text = @"完";
        self.labScore.text = [NSString stringWithFormat:@"%ld:%ld", _model.homescore,_model.guestscore];
        self.labScore.textColor = redcolor;
        self.labMiao.textColor = redcolor;
    }else if (_model.matchstate == 1 ){
        NSString *timeCha =[RLSMethods intervalFromLastDate:_model.matchtime2 toTheDate:time];
        if ([timeCha isEqualToString:@"0"]) {
            self.labMiao.text = @"1";
        }else{
            if ([timeCha intValue]>45) {
                self.labMiao.text =@"45+";
            }else{
                self.labMiao.text =timeCha;
            }
        }
        self.labScore.text = [NSString stringWithFormat:@"%ld:%ld", _model.homescore,_model.guestscore];
        self.labScore.textColor = greencolor;
        self.labMiao.textColor = redcolor;
    }else if(_model.matchstate == 2){
        self.labMiao.text = @"中场";
        self.labScore.text = [NSString stringWithFormat:@"%ld:%ld", _model.homescore,_model.guestscore];
        self.labScore.textColor = greencolor;
        self.labMiao.textColor = bluecolor;
    }else if(_model.matchstate == 3){
        NSString *timeCha =[RLSMethods intervalFromLastDateAnd45:_model.matchtime2 toTheDate:time];
        if ([timeCha isEqualToString:@"45"]) {
            self.labMiao.text = @"46";
        }else{
            if ([timeCha intValue]>90) {
                self.labMiao.text =@"90+";
            }else{
                self.labMiao.text =timeCha;
            }
        }
        self.labScore.text = [NSString stringWithFormat:@"%ld:%ld", _model.homescore,_model.guestscore];
        self.labScore.textColor = greencolor;
        self.labMiao.textColor = redcolor;
    }else if(_model.matchstate == 4){
        self.labMiao.text = @"加时";
        self.labScore.text = [NSString stringWithFormat:@"%ld:%ld", _model.homescore,_model.guestscore];
        self.labScore.textColor = greencolor;
        self.labMiao.textColor = redcolor;
    }else if(_model.matchstate == 0){
        self.labMiao.text = @"";
        self.labScore.text = @"VS";
        self.labScore.textColor = color33;
        self.labMiao.textColor = redcolor;
    }else{
        self.labMiao.text = [RLSMethods getTextByMatchState:_model.matchstate];
        self.labScore.text = @"VS";
        self.labScore.textColor = color33;
        self.labMiao.textColor = redcolor;
    }
    [self setMas];
    if (model.info > 0 && model.recommand == 0) {
    }else if (model.info == 0 && model.recommand > 0){
    }else if (model.info == 0 && model.recommand == 0){
        [self.labPanTwo mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self.labTypeOne.mas_top).offset(10);
        }];
        [self.labPanOne mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.labPanTwo.mas_left).offset(-5);
            make.bottom.mas_equalTo(self.labPanTwo.mas_bottom);
        }];
        [self.labPanThree mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.labPanTwo.mas_right).offset(5);
            make.bottom.mas_equalTo(self.labPanTwo.mas_bottom);
        }];
        [self.labScore mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.labPanTwo.mas_top).offset(-8);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
    }
}
- (void)setMas{
    [self.labLeague mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.top.mas_equalTo(self.mas_top).offset(15);
    }];
    [self.labTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labLeague.mas_right).offset(3);
        make.top.mas_equalTo(self.labLeague.mas_top);
    }];
    [self.labMiao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labTime.mas_right).offset(5);
        make.top.mas_equalTo(self.labTime.mas_top);
    }];
    [self.imageAnimation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labMiao.mas_right).offset(2);
        make.top.equalTo(self.labMiao.mas_top).offset(0);
        make.size.mas_equalTo(CGSizeMake(3, 3));
    }];
    [self.imgHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(55);
        make.top.mas_equalTo(self.labLeague.mas_bottom).offset(15);
        make.width.mas_offset(32);
        make.height.mas_offset(32);
    }];
    [self.labHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.imgHome.mas_centerX);
        make.top.mas_equalTo(self.imgHome.mas_bottom).offset(8);
    }];
    [self.imgGues mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-55);
        make.top.mas_equalTo(self.labLeague.mas_bottom).offset(15);
        make.width.mas_offset(32);
        make.height.mas_offset(32);
    }];
    [self.labGues mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.imgGues.mas_centerX);
        make.top.mas_equalTo(self.imgGues.mas_bottom).offset(8);
    }];
    if (self.model.info > 0 && self.model.recommand == 0) {
        [self.labTypeOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self.labHome.mas_bottom);
            make.width.mas_offset(30);
            make.height.mas_offset(15);
        }];
    }else if (self.model.info == 0 && self.model.recommand > 0){
        [self.labTypeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self.labTypeOne.mas_bottom);
            make.width.mas_offset(30);
            make.height.mas_offset(15);
        }];
    }else{
        [self.labTypeOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_centerX).offset(-2.5);
            make.bottom.mas_equalTo(self.labHome.mas_bottom);
            make.width.mas_offset(30);
            make.height.mas_offset(15);
        }];
        [self.labTypeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_centerX).offset(2.5);
            make.bottom.mas_equalTo(self.labTypeOne.mas_bottom);
            make.width.mas_offset(30);
            make.height.mas_offset(15);
        }];
    }
    [self.labPanTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.labTypeOne.mas_top).offset(-6);
    }];
    [self.labPanOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.labPanTwo.mas_left).offset(-5);
        make.bottom.mas_equalTo(self.labPanTwo.mas_bottom);
    }];
    [self.labPanThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labPanTwo.mas_right).offset(5);
        make.bottom.mas_equalTo(self.labPanTwo.mas_bottom);
    }];
    [self.labScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.labPanTwo.mas_top).offset(-8);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.top.mas_equalTo(self.labHome.mas_bottom).offset(15);
    }];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}
@end
