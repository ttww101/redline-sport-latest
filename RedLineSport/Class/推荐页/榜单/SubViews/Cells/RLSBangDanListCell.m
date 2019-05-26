#import "RLSBangDanListCell.h"
@interface RLSBangDanListCell()
@property (nonatomic, strong)UILabel *labNum;
@property (nonatomic, strong)UIImageView *imgCrown;
@property (nonatomic, strong)UIButton *imgPhoto;
@property (nonatomic, strong)UILabel *labName;
@property (nonatomic, strong)UILabel *labSession;
@property (nonatomic, strong)UILabel *labWinRate;
@property (nonatomic, strong)UILabel *labWinRateTwo;
@property (nonatomic, strong)UIButton *btnFocus;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UIView *bkView;
@end
@implementation RLSBangDanListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.bkView];
        [self.bkView addSubview:self.labNum];
        [self.bkView addSubview:self.imgCrown];
        [self.bkView addSubview:self.imgPhoto];
        [self.bkView addSubview:self.btnFocus];
        [self.bkView addSubview:self.labSession];
        [self.bkView addSubview:self.labName];
        [self.bkView addSubview:self.labWinRate];
        [self.bkView addSubview:self.labWinRateTwo];
        [self.bkView addSubview:self.lineView];
    }
    return self;
}
- (void)setModel:(RLSRecommandListModel *)model{
    _model = model;
    self.imgCrown.hidden = YES;
    if ([model.rank isEqualToString:@"1"]) {
        self.imgCrown.image = [UIImage imageNamed:@"guanjun"];
        self.labNum.hidden = NO;
        _labNum.textColor = redcolor;
    }else if ([model.rank isEqualToString:@"2"]){
        self.imgCrown.image = [UIImage imageNamed:@"yajun"];
        self.labNum.hidden = NO;
        _labNum.textColor = color4E37DB;
    }else if([model.rank isEqualToString:@"3"]){
        self.imgCrown.image = [UIImage imageNamed:@"jijun"];
        self.labNum.hidden = NO;
        _labNum.textColor = color33A1FF;
    }else{
        self.labNum.text = model.rank;
        self.labNum.hidden = NO;
        _labNum.textColor = color33;
    }
    self.labNum.text = model.rank;
      self.labName.text = model.nickname;
    [self.imgPhoto sd_setBackgroundImageWithURL:[NSURL URLWithString:_model.extension2] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultPic"]];
    if (self.type == 1 || self.type == 5) {
        self.labWinRate.text = model.casua;
        self.labWinRateTwo.text = model.casuatwo;
        if (self.type == 5) {
            self.labWinRate.text = model.casuatwo;
            self.labWinRateTwo.text = model.casua;
        }
        self.labSession.text = [NSString stringWithFormat:@"推荐%@场",model.realnums];
        self.labSession.attributedText = [RLSMethods withContent:self.labSession.text contentColor:color33 WithColorText:model.realnums textColor:color66];
    }else{
        self.labSession.text = @"";
        self.labWinRate.font = font14;
        if (self.type == 4 || self.type == 3) {
            self.labWinRate.text = model.casua;
            self.labWinRateTwo.text = model.casuatwo;
        }else{
            self.labWinRate.text = model.casua;
            self.labWinRateTwo.text = @"";
            self.labWinRate.attributedText = [RLSMethods withContent:self.labWinRate.text WithColorText:@"%" textColor:color33 strFont:font14];
        }
    }
    RLSUserModel *user = [RLSMethods getUserModel];
    if (user.idId == _model.userid) {
        _btnFocus.hidden = YES;
    }else{
        _btnFocus.hidden = NO;
        if (_model.extension1 == 0) {
            self.btnFocus.selected = NO;
        }else{
            self.btnFocus.selected = YES;
        }
    }
    [self setAotorelayout:self.type];
}
- (UIView *)bkView{
    if (!_bkView) {
        _bkView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBasicView)];
        [_bkView addGestureRecognizer:tap];
    }
    return _bkView;
}
- (void)tapBasicView
{
    if (_model.userid == 1) {
        return;
    }
    RLSUserViewController *user = [[RLSUserViewController alloc] init];
    user.userId = _model.userid;
    user.userName = _model.nickname;
    user.userPic = _model.extension2;
    user.Number=1;
    user.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:user animated:YES];
}
- (UILabel *)labNum{
    if (!_labNum) {
        _labNum = [[UILabel alloc] init];
        _labNum.font = font16;
        _labNum.textColor = color33;
        _labNum.textAlignment = NSTextAlignmentCenter;
    }
    return _labNum;
}
- (UIImageView *)imgCrown{
    if (!_imgCrown) {
        _imgCrown = [[UIImageView alloc] init];
    }
    return _imgCrown;
}
- (UIButton *)imgPhoto{
    if (!_imgPhoto) {
        _imgPhoto = [[UIButton alloc] init];
        _imgPhoto.layer.cornerRadius = 20;
        _imgPhoto.layer.masksToBounds = YES;
        _imgPhoto.userInteractionEnabled = NO;
    }
    return _imgPhoto;
}
- (UILabel *)labName{
    if (!_labName) {
        _labName = [[UILabel alloc] init];
        _labName.font = font14;
        _labName.textColor = color33;
        _labName.userInteractionEnabled = NO;
    }
    return _labName;
}
- (UILabel *)labSession{
    if (!_labSession) {
        _labSession = [[UILabel alloc] init];
        _labSession.font = font12;
        _labSession.textColor = color99;
    }
    return _labSession;
}
- (UILabel *)labWinRateTwo{
    if (!_labWinRateTwo) {
        _labWinRateTwo = [[UILabel alloc] init];
        _labWinRateTwo.font = font14;
        _labWinRateTwo.textColor = color33;
        _labWinRateTwo.textAlignment = NSTextAlignmentCenter;
    }
    return _labWinRateTwo;
}
- (UILabel *)labWinRate{
    if (!_labWinRate) {
        _labWinRate = [[UILabel alloc] init];
        _labWinRate.font = font14;
        _labWinRate.textColor = color33;
        _labWinRate.textAlignment = NSTextAlignmentCenter;
    }
    return _labWinRate;
}
- (UIButton *)btnFocus{
    if (!_btnFocus) {
        _btnFocus = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnFocus setImage:[UIImage imageNamed:@"focusonUserUserV"] forState:UIControlStateNormal];
        [_btnFocus setImage:[UIImage imageNamed:@"focusGrayUserV"] forState:UIControlStateSelected];
        [_btnFocus addTarget:self action:@selector(AddAttention:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnFocus;
}
- (void)AddAttention:(UIButton *)btn
{
    if (![RLSMethods login]) {
        [RLSMethods toLogin];
        return;
    }
    NSMutableDictionary *paremeter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    RLSUserModel *user = [RLSMethods getUserModel];
    NSString *url;
    if (btn.selected) {
        url = url_focusRemove;
    }else{
        url = url_focusAdd;
    }
    [paremeter setObject:[NSString stringWithFormat:@"%ld",(long)user.idId] forKey:@"followerId"];
    [paremeter setObject:[NSString stringWithFormat:@"%ld",(long)_model.userid] forKey:@"leaderId"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:paremeter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            if ((NSInteger)[[responseOrignal objectForKey:@"data"] integerValue] >0) {
                if (btn.selected) {
                    user.focusCount = user.focusCount
                    -1;
                    _model.extension1 = 0;
                }else{
                    user.focusCount = user.focusCount +1;
                    _model.extension1 = 1;
                }
                btn.selected = !btn.selected;
                [RLSMethods getUserModel];
                [RLSMethods updateUsetModel:user];
                if (btn.selected) {
                    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"关注成功"];
                }else{
                    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"取消关注成功"];
                }
            }else{
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
            }
        }else
        {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = colorCellLine;
    }
    return _lineView;
}
- (void)setAotorelayout:(NSInteger)type{
    [self.bkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
    }];
    [self.labNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bkView.mas_centerY);
        make.left.mas_equalTo(self.bkView.mas_left);
        make.width.mas_offset(48);
    }];
    [self.imgCrown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bkView.mas_left);
        make.centerY.mas_equalTo(self.bkView.mas_centerY);
        make.width.mas_offset(48);
        make.height.mas_offset(48);
    }];
    [self.imgPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labNum.mas_centerY);
        make.left.mas_equalTo(self.labNum.mas_right);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
    }];
    if (type == 1 || type == 5) {
        [self.btnFocus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bkView.mas_right).offset(-10);
            make.centerY.mas_equalTo(self.bkView.mas_centerY);
        }];
        [self.labSession mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imgPhoto.mas_right).offset(10);
            make.bottom.mas_equalTo(self.btnFocus.mas_bottom).offset(3);
        }];
        [self.labName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.labSession.mas_left);
            make.bottom.mas_equalTo(self.labSession.mas_top).offset(-6);
            make.width.mas_offset(85);
        }];
        [self.labWinRate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.bkView.mas_centerY);
            make.right.mas_equalTo(self.btnFocus.mas_left);
            make.width.mas_offset(50);
        }];
        [self.labWinRateTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.bkView.mas_centerY);
            make.right.mas_equalTo(self.labWinRate.mas_left).offset(-5);
            make.width.mas_offset(50);
        }];
    }else{
        [self.btnFocus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bkView.mas_right).offset(-10);
            make.centerY.mas_equalTo(self.bkView.mas_centerY);
        }];
        [self.labSession mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(0);
            make.width.mas_offset(0);
        }];
        [self.labName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imgPhoto.mas_right).offset(10);
            make.centerY.mas_equalTo(self.bkView.mas_centerY);
            make.width.mas_offset(100);
        }];
        if (type == 2) {
            [self.labWinRate mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.bkView.mas_centerY);
                make.right.mas_equalTo(self.btnFocus.mas_left).offset(-20);
                make.width.mas_offset(50);
            }];
        }else{
            [self.labWinRate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.bkView.mas_centerY);
            make.right.mas_equalTo(self.btnFocus.mas_left);
            make.width.mas_offset(50);
            }];
        }
        [self.labWinRateTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.bkView.mas_centerY);
            make.right.mas_equalTo(self.labWinRate.mas_left).offset(-5);
            make.width.mas_offset(50);
        }];
    }
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bkView.mas_left);
        make.right.mas_equalTo(self.bkView.mas_right);
        make.bottom.mas_equalTo(self.bkView.mas_bottom);
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
