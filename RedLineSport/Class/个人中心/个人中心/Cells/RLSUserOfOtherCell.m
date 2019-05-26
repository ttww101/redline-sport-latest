#import "RLSUserOfOtherCell.h"
#import "RLSDC_JZAPhotoVC.h"
#import "RLSUserTuiianView.h"
#import "RLSUsermarkModel.h"
@interface RLSUserOfOtherCell()<UserTuiianViewDelegate>
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UIImageView *imageBasic;
@property (nonatomic, strong) UIButton *btnBack;
@property (nonatomic, strong) UIButton *btnShare;
@property (nonatomic, strong) UIView *viewCenter;
@property (nonatomic, strong) UIButton *btnUserPic;
@property (nonatomic, strong) UIButton *btnUser;
@property (nonatomic, strong) UIImageView *imageAuthorTitle;
@property (nonatomic, strong) UIImageView *imageAuthorTitle1;
@property (nonatomic, strong) UIImageView *imageAuthorTitle2;
@property (nonatomic, strong) UILabel *labUserRemark1;
@property (nonatomic, strong) UILabel *labUserRemark2;
@property (nonatomic, strong) UILabel *labUserIntro;
@property (nonatomic, strong) RLSUserTuiianView *viewTuijian;
@property (nonatomic, strong) UIButton *btnAttention;
@property (nonatomic, strong) UIButton *btnUpdown;
@property (nonatomic, assign) BOOL isAddAutoLayout;
@end
@implementation RLSUserOfOtherCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setModel:(RLSUserModel *)model
{
    _model = model;
    [self.contentView addSubview:self.basicView];
    [_btnUserPic sd_setBackgroundImageWithURL:[NSURL URLWithString:_model.pic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultPic"]];
    [_btnUser setTitle:_model.nickname forState:UIControlStateNormal];
    _btnUpdown.selected = _showMoreUserInfo;
    if (_showMoreUserInfo) {
        _labUserIntro.numberOfLines = 0;
    }else{
        _labUserIntro.numberOfLines = 2;
    }
    [_labUserIntro setAttributedText:[RLSMethods setTextStyleWithString:_model.userinfo WithLineSpace:6 WithHeaderIndent:0]];
   CGSize textSize = [_model.userinfo boundingRectWithSize:CGSizeMake(Width - 30, MAXFLOAT) font:font14 lineSpacing:0];
    _btnAttention.selected = _model.focused;
    _viewTuijian.imageName = @"userSanjiao";
    _viewTuijian.model = _model;
    _imageBasic.image = [UIImage imageNamed:@"userBg"];
    if (!_isAddAutoLayout) {
        [self addAutoLayout];
        _isAddAutoLayout = YES;
    }
    if (textSize.height>34) {
        [_btnUpdown setBackgroundImage:[UIImage imageNamed:@"userContentDown"] forState:UIControlStateNormal];
        [_btnUpdown setBackgroundImage:[UIImage imageNamed:@"userContentUp"] forState:UIControlStateSelected];
        _btnUpdown.enabled = YES;
        [_btnUpdown mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
    }else{
        [_btnUpdown setBackgroundImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
        [_btnUpdown setBackgroundImage:[UIImage imageNamed:@"clear"] forState:UIControlStateSelected];
        _btnUpdown.enabled = NO;
        [_btnUpdown mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(14, 14));
        }];
    }
    if (isNUll(_model.remarkContinuous)) {
        _labUserRemark1.text = @"";
        _labUserRemark2.text = @"";
        [self.btnUser mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btnUserPic.mas_right).offset(17);
            make.centerY.equalTo(self.btnUserPic.mas_centerY);
        }];
    }else{
        [self.btnUser mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.btnUserPic.mas_right).offset(17);
            make.top.equalTo(self.btnUserPic.mas_top).offset(-3);
        }];
        if (isNUll(_model.remarkContinuous) ) {
            _labUserRemark1.text = @"";
        }else{
            _labUserRemark1.text = [NSString stringWithFormat:@"  %@  ",_model.remarkContinuous];
        }
    }
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        _basicView.backgroundColor = redcolor;
        [_basicView addSubview:self.imageBasic];
        [_basicView addSubview:self.btnBack];
        [_basicView addSubview:self.btnShare];
        [_basicView addSubview:self.btnUserPic];
        [_basicView addSubview:self.btnUser];
        [_basicView addSubview:self.imageAuthorTitle];
        [_basicView addSubview:self.imageAuthorTitle1];
        [_basicView addSubview:self.imageAuthorTitle2];
        [_basicView addSubview:self.labUserRemark1];
        [_basicView addSubview:self.labUserRemark2];
        [_basicView addSubview:self.labUserIntro];
        [_basicView addSubview:self.viewTuijian];
        [_basicView addSubview:self.viewCenter];
        [_basicView addSubview:self.btnAttention];
        [_basicView addSubview:self.btnUpdown];
    }
    return _basicView;
}
- (UIImageView *)imageBasic
{
    if (!_imageBasic) {
        _imageBasic = [[UIImageView alloc] init];
    }
    return _imageBasic;
}
- (UIButton *)btnBack
{
    if (!_btnBack) {
        _btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnBack.tag = 1;
    }
    return _btnBack;
}
- (void)back:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(navBtnClick:)]) {
        [_delegate navBtnClick:btn.tag];
    }
}
- (UIButton *)btnShare
{
    if (!_btnShare) {
        _btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnShare addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        _btnShare.tag = 2;
    }
    return _btnShare;
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
        _btnUserPic.layer.cornerRadius = 50/2;
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
        _btnUser.titleLabel.font = BoldFont4(fontSize18);
        [_btnUser setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _btnUser;
}
- (UIImageView *)imageAuthorTitle
{
    if (!_imageAuthorTitle) {
        _imageAuthorTitle = [[UIImageView alloc] init];
    }
    return _imageAuthorTitle;
}
- (UIImageView *)imageAuthorTitle1
{
    if (!_imageAuthorTitle1) {
        _imageAuthorTitle1 = [[UIImageView alloc] init];
    }
    return _imageAuthorTitle1;
}
- (UIImageView *)imageAuthorTitle2
{
    if (!_imageAuthorTitle2) {
        _imageAuthorTitle2 = [[UIImageView alloc] init];
    }
    return _imageAuthorTitle2;
}
- (UILabel *)labUserRemark1
{
    if (!_labUserRemark1) {
        _labUserRemark1 = [[UILabel alloc] init];
        _labUserRemark1.font = font11;
        _labUserRemark1.textColor = colorFFFD4D;
        _labUserRemark1.layer.cornerRadius = 8;
        _labUserRemark1.layer.masksToBounds = YES;
        _labUserRemark1.layer.borderColor = colorFFFD4D.CGColor;
        _labUserRemark1.layer.borderWidth = 0.5;
    }
    return _labUserRemark1;
}
- (UILabel *)labUserRemark2
{
    if (!_labUserRemark2) {
        _labUserRemark2 = [[UILabel alloc] init];
        _labUserRemark2.font = font11;
        _labUserRemark2.textColor = colorFFFD4D;
        _labUserRemark2.layer.cornerRadius = 8;
        _labUserRemark2.layer.masksToBounds = YES;
        _labUserRemark2.layer.borderColor = colorFFFD4D.CGColor;
        _labUserRemark2.layer.borderWidth = 0.5;
    }
    return _labUserRemark2;
}
- (UILabel *)labUserIntro
{
    if (!_labUserIntro) {
        _labUserIntro = [[UILabel alloc] init];
        _labUserIntro.textColor = [UIColor whiteColor];
        _labUserIntro.font = font14;
        _labUserIntro.numberOfLines = 0;
    }
    return _labUserIntro;
}
- (RLSUserTuiianView *)viewTuijian
{
    if (!_viewTuijian) {
        _viewTuijian = [[RLSUserTuiianView alloc] init];
        _viewTuijian.delegate = self;
    }
    return _viewTuijian;
}
- (void)didTouchItemWithIndex:(NSInteger)index
{
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"userTuijianVCIndex"];
    if (_delegate && [_delegate respondsToSelector:@selector(tuijianBtnClick:)]) {
        [_delegate tuijianBtnClick:index];
    }
        if (index == 0) {
        }else if (index == 1){
        }else if(index == 2){
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
        [_delegate upDownBtnClick:btn.selected];
    }
}
- (void)addAutoLayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self.imageBasic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top);
        make.left.equalTo(self.basicView.mas_left);
        make.right.equalTo(self.basicView.mas_right);
        make.bottom.equalTo(self.basicView.mas_bottom);
    }];
    [self.btnBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left);
        make.top.equalTo(self.basicView.mas_top).offset(APPDELEGATE.customTabbar.height_myStateBar);
        make.size.mas_equalTo(CGSizeMake(APPDELEGATE.customTabbar.height_myNavigationBar -APPDELEGATE.customTabbar.height_myStateBar, APPDELEGATE.customTabbar.height_myNavigationBar -APPDELEGATE.customTabbar.height_myStateBar));
    }];
    [self.btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.basicView.mas_right);
        make.top.equalTo(self.basicView.mas_top).offset(APPDELEGATE.customTabbar.height_myStateBar);
        make.size.mas_equalTo(CGSizeMake(APPDELEGATE.customTabbar.height_myNavigationBar -APPDELEGATE.customTabbar.height_myStateBar, APPDELEGATE.customTabbar.height_myNavigationBar -APPDELEGATE.customTabbar.height_myStateBar));
    }];
    [self.btnUserPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top).offset(APPDELEGATE.customTabbar.height_myNavigationBar + 5);
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
    [self.viewCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnUserPic.mas_right).offset(17);
        make.centerY.equalTo(self.btnUserPic.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 1));
    }];
    [self.btnUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnUserPic.mas_right).offset(17);
        make.centerY.equalTo(self.btnUserPic.mas_centerY);
    }];
    [self.labUserIntro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnUserPic.mas_bottom).offset(10);
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.right.equalTo(self.basicView.mas_right).offset(-15);
    }];
    [self.imageAuthorTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnUser.mas_right).offset(12);
        make.centerY.equalTo(self.btnUser.mas_centerY);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(15);
    }];
    [self.imageAuthorTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageAuthorTitle.mas_right).offset(10);
        make.centerY.equalTo(self.btnUser.mas_centerY);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(15);
    }];
    [self.imageAuthorTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageAuthorTitle1.mas_right).offset(10);
        make.centerY.equalTo(self.btnUser.mas_centerY);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(15);
    }];
    [self.labUserRemark1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewCenter.mas_bottom).offset(3.5);
        make.left.equalTo(self.btnUser.mas_left);
        make.height.mas_equalTo(16);
    }];
    [self.labUserRemark2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labUserRemark1.mas_top);
        make.left.equalTo(self.labUserRemark1.mas_right).offset(5);
        make.height.mas_equalTo(16);
    }];
    [self.btnAttention mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.basicView.mas_right).offset(-15);
        make.bottom.equalTo(self.labUserRemark1.mas_bottom);
    }];
    [self.btnUpdown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.basicView.mas_centerX);
        make.top.equalTo(self.labUserIntro.mas_bottom).offset(-7);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    [self.viewTuijian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnUpdown.mas_bottom).offset(-7);
        make.left.equalTo(self.basicView.mas_left);
        make.size.mas_equalTo(CGSizeMake(Width, 60));
        make.bottom.equalTo(self.basicView.mas_bottom);
    }];
}
@end
