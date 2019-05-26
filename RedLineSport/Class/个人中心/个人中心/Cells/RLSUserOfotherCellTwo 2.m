#import "RLSDC_JZAPhotoVC.h"
#import "RLSUserOfotherCellTwo.h"
@interface RLSUserOfotherCellTwo ()
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UIImageView *imageBasic;
@property (nonatomic, strong) UIView *viewCenter;
@property (nonatomic, strong) UIButton *btnUserPic;
@property (nonatomic, strong) UIButton *btnUser;
@property (nonatomic, strong) UILabel *labfocusNum;
@property (nonatomic, strong) UILabel *labfocusTitle;
@property (nonatomic, strong) UILabel *labfollowerNum;
@property (nonatomic, strong) UILabel *labfollowerTitle;
@property (nonatomic, strong) UILabel *labUserRemark1;
@property (nonatomic, strong) UILabel *labUserRemark2;
@property (nonatomic, strong) UILabel *labUserIntro;
@property (nonatomic, strong) UIButton *btnAttention;
@property (nonatomic, strong) UIButton *btnUpdown;
@property (nonatomic, strong) UIView *viewLineBottom;
@property (nonatomic, assign) BOOL isAddAutoLayout;
@end
@implementation RLSUserOfotherCellTwo
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setModel:(RLSUserModel *)model
{
    _model = model;
    [self.contentView addSubview:self.basicView];
    if (!_isAddAutoLayout) {
        _isAddAutoLayout = YES;
        [self addlayout];
    }
    [_btnUserPic sd_setBackgroundImageWithURL:[NSURL URLWithString:_model.pic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultPic"]];
    [_btnUser setTitle:_model.nickname forState:UIControlStateNormal];
    _labfocusNum.text = [NSString stringWithFormat:@"%ld",_model.focusCount];
    _labfocusTitle.text = @"关注";
    _labfollowerNum.text = [NSString stringWithFormat:@"%ld",_model.followerCount];
    _labfollowerTitle.text = @"粉丝";
    _btnUpdown.selected = _showMoreUserInfo;
    if (_showMoreUserInfo) {
        _labUserIntro.numberOfLines = 0;
    }else{
        _labUserIntro.numberOfLines = 1;
    }
    if (isNUll(_model.userinfo) || [_model.userinfo isEqualToString:@" "]) {
        _labUserIntro.text = @"";
    }else{
    [_labUserIntro setAttributedText:[RLSMethods setTextStyleWithString:_model.userinfo WithLineSpace:6 WithHeaderIndent:0]];
    }
    CGSize textSize = [_model.userinfo boundingRectWithSize:CGSizeMake(Width - 30, MAXFLOAT) font:font14 lineSpacing:0];
    RLSUserModel *user = [RLSMethods getUserModel];
    if (user.idId == _model.idId) {
        _btnAttention.hidden = YES;
    }else{
        _btnAttention.selected = _model.focused;
        _btnAttention.hidden = NO;
    }
    _imageBasic.image = [UIImage imageNamed:@"white"];
    if (textSize.height>17) {
        [_btnUpdown setBackgroundImage:[UIImage imageNamed:@"userContentDown"] forState:UIControlStateNormal];
        [_btnUpdown setBackgroundImage:[UIImage imageNamed:@"userContentUp"] forState:UIControlStateSelected];
        _btnUpdown.enabled = YES;
        [_btnUpdown mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(13, 13));
        }];
    }else{
        [_btnUpdown setBackgroundImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
        [_btnUpdown setBackgroundImage:[UIImage imageNamed:@"clear"] forState:UIControlStateSelected];
        _btnUpdown.enabled = NO;
        [_btnUpdown mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    if (isNUll(_model.remarkContinuous) && isNUll(_model.remarkWinNum)) {
        _labUserRemark1.hidden = YES;
        _labUserRemark2.hidden = YES;
        [self.btnUser mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btnUserPic.mas_right).offset(5);
            make.centerY.equalTo(self.btnUserPic.mas_centerY);
            make.height.mas_equalTo(14);
        }];
    }else{
        _labUserRemark1.hidden = NO;
        _labUserRemark2.hidden = NO;
        [self.btnUser mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btnUserPic.mas_right).offset(5);
            make.bottom.equalTo(self.viewCenter.mas_top).offset(-3);
            make.height.mas_equalTo(14);
        }];
        if (isNUll(_model.remarkContinuous) ) {
            _labUserRemark1.text = [NSString stringWithFormat:@"  %@  ",_model.remarkWinNum];
            _labUserRemark1.textColor = redcolor;
            _labUserRemark1.backgroundColor = colorFEE3E1;
            _labUserRemark2.hidden = YES;
        }else{
            _labUserRemark1.text = [NSString stringWithFormat:@"  %@  ",_model.remarkContinuous];
            _labUserRemark1.textColor = [UIColor whiteColor];
            _labUserRemark1.backgroundColor = redcolor;
            if (isNUll(_model.remarkWinNum)) {
                _labUserRemark2.hidden = YES;
            }else{
                _labUserRemark2.text = [NSString stringWithFormat:@"  %@  ",_model.remarkWinNum];
                _labUserRemark2.textColor = redcolor;
                _labUserRemark2.backgroundColor = colorFEE3E1;
            }
        }
    }
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.imageBasic];
        [_basicView addSubview:self.btnUserPic];
        [_basicView addSubview:self.btnUser];
        [_basicView addSubview:self.labfocusNum];
        [_basicView addSubview:self.labfocusTitle];
        [_basicView addSubview:self.labfollowerNum];
        [_basicView addSubview:self.labfollowerTitle];
        [_basicView addSubview:self.labUserRemark1];
        [_basicView addSubview:self.labUserRemark2];
        [_basicView addSubview:self.labUserIntro];
        [_basicView addSubview:self.viewCenter];
        [_basicView addSubview:self.btnAttention];
        [_basicView addSubview:self.btnUpdown];
        [_basicView addSubview:self.viewLineBottom];
    }
    return _basicView;
}
- (UIView *)viewLineBottom
{
    if (!_viewLineBottom) {
        _viewLineBottom = [[UIView alloc] init];
        _viewLineBottom.backgroundColor = colorCellLine;
    }
    return _viewLineBottom;
}
- (UIImageView *)imageBasic
{
    if (!_imageBasic) {
        _imageBasic = [[UIImageView alloc] init];
    }
    return _imageBasic;
}
- (UIView *)viewCenter
{
    if (!_viewCenter) {
        _viewCenter = [[UIView alloc] init];
    }
    return _viewCenter;
}
- (UIButton *)btnUserPic
{
    if (!_btnUserPic) {
        _btnUserPic = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnUserPic.layer.cornerRadius = 34/2;
        _btnUserPic.layer.masksToBounds = YES;
        [_btnUserPic addTarget:self action:@selector(showUserPic) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnUserPic;
}
- (void)showUserPic{
    RLSDC_JZAPhotoVC *album = [[RLSDC_JZAPhotoVC alloc] init];
    album.imgArr = [NSMutableArray arrayWithObject:_model.pic];
    [APPDELEGATE.customTabbar presentToViewController:album animated:YES completion:^{
    }];
}
- (UIButton *)btnUser
{
    if (!_btnUser) {
        _btnUser = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnUser.titleLabel.font = BoldFont4(fontSize14);
        [_btnUser setTitleColor:color33 forState:UIControlStateNormal];
        [_btnUser setTitleColor:color33 forState:UIControlStateHighlighted];
    }
    return _btnUser;
}
- (UILabel *)labUserRemark1
{
    if (!_labUserRemark1) {
        _labUserRemark1 = [[UILabel alloc] init];
        _labUserRemark1.font = font10;
        _labUserRemark1.textColor = [UIColor whiteColor];
        _labUserRemark1.layer.cornerRadius = 3;
        _labUserRemark1.layer.masksToBounds = YES;
        _labUserRemark1.backgroundColor = redcolor;
    }
    return _labUserRemark1;
}
- (UILabel *)labUserRemark2
{
    if (!_labUserRemark2) {
        _labUserRemark2 = [[UILabel alloc] init];
        _labUserRemark2.font = font10;
        _labUserRemark2.textColor = redcolor;
        _labUserRemark2.layer.cornerRadius = 3;
        _labUserRemark2.layer.masksToBounds = YES;
        _labUserRemark2.backgroundColor = colorFEE3E1;
    }
    return _labUserRemark2;
}
- (UILabel *)labfocusNum
{
    if (!_labfocusNum) {
        _labfocusNum = [[UILabel alloc] init];
        _labfocusNum.textColor = color33;
        _labfocusNum.font = font10;
        _labfocusNum.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapFocus = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toFocus)];
        [_labfocusNum addGestureRecognizer:tapFocus];
    }
    return _labfocusNum;
}
- (UILabel *)labfocusTitle
{
    if (!_labfocusTitle) {
        _labfocusTitle = [[UILabel alloc] init];
        _labfocusTitle.textColor = color33;
        _labfocusTitle.font = font10;
        _labfocusTitle.userInteractionEnabled = YES;
        _labfocusTitle.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tapFocus = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toFocus)];
        [_labfocusTitle addGestureRecognizer:tapFocus];
    }
    return _labfocusTitle;
}
- (UILabel *)labfollowerNum
{
    if (!_labfollowerNum) {
        _labfollowerNum = [[UILabel alloc] init];
        _labfollowerNum.textColor = color33;
        _labfollowerNum.font = font10;
        _labfollowerNum.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapFollower = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toFollower)];
        [_labfollowerNum addGestureRecognizer:tapFollower];
    }
    return _labfollowerNum;
}
- (UILabel *)labfollowerTitle
{
    if (!_labfollowerTitle) {
        _labfollowerTitle = [[UILabel alloc] init];
        _labfollowerTitle.textColor = color33;
        _labfollowerTitle.font = font10;
        _labfollowerTitle.userInteractionEnabled = YES;
        _labfollowerTitle.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tapFollower = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toFollower)];
        [_labfollowerTitle addGestureRecognizer:tapFollower];
    }
    return _labfollowerTitle;
}
- (UILabel *)labUserIntro
{
    if (!_labUserIntro) {
        _labUserIntro = [[UILabel alloc] init];
        _labUserIntro.textColor = color33;
        _labUserIntro.font = font12;
        _labUserIntro.numberOfLines = 0;
        _labUserIntro.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMoreInfo)];
        [_labUserIntro addGestureRecognizer:tap];
    }
    return _labUserIntro;
}
- (void)showMoreInfo
{
    if (_delegate && [_delegate respondsToSelector:@selector(upDownBtnClick:)]) {
        [_delegate upDownBtnClick:!_showMoreUserInfo];
    }
}
- (UIButton *)btnAttention
{
    if (!_btnAttention) {
        _btnAttention = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAttention addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnAttention setBackgroundImage:[UIImage imageNamed:@"focusonUserUserV"] forState:UIControlStateNormal];
        [_btnAttention setBackgroundImage:[UIImage imageNamed:@"focusGrayUserV"] forState:UIControlStateSelected];
    }
    return _btnAttention;
}
- (void)btnClick:(UIButton *)btn
{
    if (![RLSMethods login]) {
        [RLSMethods toLogin];
        return;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(attentionBtnClick:)]) {
        [_delegate attentionBtnClick:btn];
        btn.selected = !btn.selected;
    }
}
- (UIButton *)btnUpdown
{
    if (!_btnUpdown) {
        _btnUpdown = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnUpdown setBackgroundImage:[UIImage imageNamed:@"userContentDown"] forState:UIControlStateNormal];
        [_btnUpdown setBackgroundImage:[UIImage imageNamed:@"userContentUp"] forState:UIControlStateSelected];
        [_btnUpdown addTarget:self action:@selector(btnUpdownClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnUpdown;
}
- (void)btnUpdownClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(upDownBtnClick:)]) {
        [_delegate upDownBtnClick:!_showMoreUserInfo];
    }
}
- (void)addlayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self.btnUserPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top).offset(18);
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(34, 34));
    }];
    [self.btnUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnUserPic.mas_top);
        make.left.equalTo(self.btnUserPic.mas_right).offset(5);
        make.height.mas_equalTo(14);
    }];
    [self.viewCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnUserPic.mas_right).offset(5);
        make.centerY.equalTo(self.btnUserPic.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 0.5));
    }];
    [self.labUserRemark1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnUserPic.mas_right).offset(5);
        make.top.equalTo(self.viewCenter.mas_bottom).offset(3);
        make.height.mas_equalTo(14);
    }];
    [self.labUserRemark2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labUserRemark1.mas_right).offset(5);
        make.centerY.equalTo(self.labUserRemark1.mas_centerY);
        make.height.mas_equalTo(14);
    }];
   [self.btnAttention mas_makeConstraints:^(MASConstraintMaker *make) {
       make.right.equalTo(self.basicView.mas_right).offset(-15);
       make.top.equalTo(self.basicView.mas_top).offset(28);
       make.size.mas_equalTo(CGSizeMake(51, 24));
   }];
    [self.labfollowerNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top).offset(26);
        make.right.equalTo(self.btnAttention.mas_left).offset(-33);
    }];
    [self.labfollowerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labfollowerNum.mas_bottom).offset(0);
        make.centerX.equalTo(self.labfollowerNum.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(35, 20));
    }];
    [self.labfocusNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labfollowerNum.mas_top);
        make.right.equalTo(self.labfollowerNum.mas_left).offset(-24);
    }];
    [self.labfocusTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labfocusNum.mas_bottom).offset(0);
        make.centerX.equalTo(self.labfocusNum.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(35, 20));
    }];
    [self.labUserIntro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.top.equalTo(self.btnUserPic.mas_bottom).offset(11);
        make.right.equalTo(self.basicView.mas_right).offset(-15);
    }];
    [self.btnUpdown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labUserIntro.mas_bottom).offset(5);
        make.centerX.equalTo(self.basicView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    [self.viewLineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left);
        make.size.mas_equalTo(CGSizeMake(Width, 0.5));
        make.top.equalTo(self.btnUpdown.mas_bottom).offset(5);
        make.bottom.equalTo(self.basicView.mas_bottom);
    }];
}
- (void)toFollower
{
    RLSFriendsVC *friend = [[RLSFriendsVC alloc] init];
    friend.userId = _model.idId;
    friend.selectedIndex = 1;
    friend.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:friend animated:YES];
}
- (void)toFocus
{
    RLSFriendsVC *friend = [[RLSFriendsVC alloc] init];
    friend.userId = _model.idId;
    friend.selectedIndex = 0;
    friend.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:friend animated:YES];
}
@end
