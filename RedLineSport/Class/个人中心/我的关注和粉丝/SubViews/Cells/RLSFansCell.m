#import "RLSFansCell.h"
@interface RLSFansCell()
@property (nonatomic, assign) BOOL addAuto;
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UIImageView *imagePic;
@property (nonatomic, strong) UILabel *labName;
@property (nonatomic, strong) UIView *viewCenter;
@property (nonatomic, strong) UILabel *labfollower;
@property (nonatomic, strong) UILabel *labFocus;
@property (nonatomic, strong) UIView *viewLine;
@property (nonatomic, strong) UIButton *btnAttention;
@property (nonatomic, strong) UIView *viewLineBottom;
@end
@implementation RLSFansCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setModel:(RLSFansModel *)model
{
    _model = model;
    [self.contentView addSubview:self.basicView];
    [_imagePic sd_setImageWithURL:[NSURL URLWithString:_model.pic] placeholderImage:[UIImage imageNamed:@"defaultPic"]];
    _labName.text = _model.nickname;
    _labFocus.attributedText = [RLSMethods withContent:[NSString stringWithFormat:@"关注%ld",_model.focus_count] contentColor:color33 WithColorText:@"关注" textColor:color99];
    _labfollower.attributedText = [RLSMethods withContent:[NSString stringWithFormat:@"粉丝%ld",_model.follower_count] contentColor:color33 WithColorText:@"粉丝" textColor:color99];
    _btnAttention.selected = _model.focused;
    RLSUserModel *user = [RLSMethods getUserModel];
    if (user.idId == model.idId) {
        _btnAttention.hidden = YES;
    }else{
        _btnAttention.hidden = NO;
    }
    if (!_addAuto) {
        _addAuto = YES;
        [self addAutoLayout];
    }
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBasicView)];
        [_basicView addGestureRecognizer:tap];
        _basicView.backgroundColor = [UIColor whiteColor];
        [_basicView addSubview:self.imagePic];
        [_basicView addSubview:self.labName];
        [_basicView addSubview:self.viewCenter];
        [_basicView addSubview:self.labFocus];
        [_basicView addSubview:self.viewLine];
        [_basicView addSubview:self.labfollower];
        [_basicView addSubview:self.btnAttention];
        [_basicView addSubview:self.viewLineBottom];
    }
    return _basicView;
}
- (void)tapBasicView
{
    if (_model.idId == 1) {
        return;
    }
    RLSUserViewController *user = [[RLSUserViewController alloc] init];
    user.userId = _model.idId;
    user.userName = _model.nickname;
    user.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:user animated:YES];
}
- (UIImageView *)imagePic
{
    if (!_imagePic) {
        _imagePic = [[UIImageView alloc] init];
        _imagePic.layer.cornerRadius = 30;
        _imagePic.layer.masksToBounds = YES;
    }
    return _imagePic;
}
- (UILabel *)labName
{
    if (!_labName) {
        _labName = [[UILabel alloc] init];
        _labName.textColor = color33;
        _labName.font = font14;
    }
    return _labName;
}
- (UIView *)viewCenter
{
    if (!_viewCenter) {
        _viewCenter = [[UIView alloc] init];
        _viewCenter.backgroundColor = [UIColor whiteColor];
    }
    return _viewCenter;
}
- (UILabel *)labfollower
{
    if (!_labfollower) {
        _labfollower = [[UILabel alloc] init];
        _labfollower.textColor = color33;
        _labfollower.font = font12;
    }
    return _labfollower;
}
- (UIView *)viewLine
{
    if (!_viewLine) {
        _viewLine = [[UIView alloc] init];
        _viewLine.backgroundColor = colorCC;
    }
    return _viewLine;
}
- (UILabel *)labFocus
{
    if (!_labFocus) {
        _labFocus = [[UILabel alloc] init];
        _labFocus.textColor = color33;
        _labFocus.font = font12;
    }
    return _labFocus;
}
- (UIButton *)btnAttention
{
    if (!_btnAttention) {
        _btnAttention = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAttention setBackgroundImage:[UIImage imageNamed:@"focusonUserUserV"] forState:UIControlStateNormal];
        [_btnAttention setBackgroundImage:[UIImage imageNamed:@"focusGrayUserV"] forState:UIControlStateSelected];
        [_btnAttention addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAttention;
}
- (void)btnClick:(UIButton *)btn
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
    [paremeter setObject:[NSString stringWithFormat:@"%ld",(long)_model.idId] forKey:@"leaderId"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:paremeter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            if ((NSInteger)[[responseOrignal objectForKey:@"data"] integerValue] >0) {
                if (btn.selected) {
                    _model.follower_count = _model.follower_count -1;
                    user.focusCount = user.focusCount -1;
                }else{
                    _model.follower_count = _model.follower_count +1;
                    user.focusCount = user.focusCount +1;
                }
                _model.focused = !_model.focused;
                _labFocus.attributedText = [RLSMethods withContent:[NSString stringWithFormat:@"关注%ld",_model.focus_count] contentColor:color33 WithColorText:@"关注" textColor:color99];
                _labfollower.attributedText = [RLSMethods withContent:[NSString stringWithFormat:@"粉丝%ld",_model.follower_count] contentColor:color33 WithColorText:@"粉丝" textColor:color99];
                _btnAttention.selected = _model.focused;
                [RLSMethods updateUsetModel:user];
            }else{
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:btn.selected? @"取消关注失败":@"关注失败"];
            }
        }else
        {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:btn.selected? @"取消关注失败":@"关注失败"];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:btn.selected? @"取消关注失败":@"关注失败"];
    }];
}
- (UIView *)viewLineBottom
{
    if (!_viewLineBottom) {
        _viewLineBottom = [[UIView alloc] init];
        _viewLineBottom.backgroundColor = colorCellLine;
    }
    return _viewLineBottom;
}
- (void)addAutoLayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self.imagePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.centerY.equalTo(self.basicView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [self.viewCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imagePic.mas_right).offset(15);
        make.centerY.equalTo(self.basicView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 1));
    }];
    [self.labName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.viewCenter.mas_top).offset(-3.5);
        make.left.equalTo(self.imagePic.mas_right).offset(15);
    }];
    [self.labFocus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewCenter.mas_bottom).offset(3.5);
        make.left.equalTo(self.imagePic.mas_right).offset(15);
    }];
    [self.viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labFocus.mas_right).offset(9);
        make.centerY.equalTo(self.labFocus.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(1, 12));
    }];
    [self.labfollower mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewLine.mas_right).offset(9);
        make.centerY.equalTo(self.labFocus.mas_centerY);
    }];
    [self.btnAttention mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.basicView.mas_right).offset(-15);
        make.bottom.equalTo(self.labFocus.mas_bottom);
    }];
    [self.viewLineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.basicView.mas_bottom);
        make.left.equalTo(self.basicView.mas_left);
        make.size.mas_equalTo(CGSizeMake(Width, 0.5));
    }];
}
@end
