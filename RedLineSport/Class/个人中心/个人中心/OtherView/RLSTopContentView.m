#import "RLSTopContentView.h"
#import "RLSMessageControl.h"
#import "RLSDC_JZAPhotoVC.h"
#import "RLSUserTuijianVC.h"
@interface RLSTopContentView ()
@property (nonatomic , strong) CALayer *redLayer;
@property (nonatomic , strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIImageView *levealImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic , strong) UIButton *followBtn;
@property (nonatomic, strong) NSMutableArray *recordArray;
@end
static CGFloat imageHeight = 50;
@implementation RLSTopContentView
#pragma mark - View Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 64, Width, 130)];
    if (self) {
        [self configUI];
    }
    return self;
}
#pragma mark - Open Method
- (void)setModel:(RLSUserModel *)model {
    _model = model;
    if (_model == nil) {
        return;
    }
     [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.pic] placeholderImage:[UIImage imageNamed:@"defaultPic"]];
    NSString *imageName = [RLSMethods getPersonLeavelImageName:_model.analysttype];
    self.levealImageView.image = [UIImage imageNamed:imageName];
    NSDictionary *dic = _model.userDetail;
    NSString *text = [NSString stringWithFormat:@"%@| %@", _model.nickname ,dic[@"levelName"]];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:text];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.f] range:[text rangeOfString:_model.nickname]];
    [att addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBWithOX(0x666666) range:[text rangeOfString:_model.nickname]];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.f] range:[text rangeOfString:dic[@"levelName"]]];
    [att addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBWithOX(0x999999) range:[text rangeOfString:@"|"]];
    [att addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBWithOX(0x999999) range:[text rangeOfString:dic[@"levelName"]]];
    self.nameLabel.attributedText = att;
    self.desLabel.text = _model.userinfo;
    if (self.recordArray.count > 0) {
        [self.recordArray enumerateObjectsUsingBlock:^(RLSMessageControl *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
            obj = nil;
        }];
    }
    NSArray *titleArray = @[@"拥有粉丝", @"关注", @"发表推荐"];
    NSArray *contentArray = @[@(_model.followerCount), @(_model.focusCount), @(_model.recommendCount)];
    CGFloat width = (self.contentView.width - 90)/ 3;
    for (NSInteger i = 0; i < titleArray.count; i ++) {
        RLSMessageControl *control = [[RLSMessageControl alloc]initWithFrame:CGRectMake(60 + i * width, self.height - 60, width, 60) title:titleArray[i] amount:[contentArray[i] stringValue]];
        [control addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        control.tag = i;
        [self.contentView addSubview:control];
        [self.recordArray addObject:control];
    }
    if (_model.focused) {
        [self.followBtn setSelected:YES];
    } else {
        [self.followBtn setSelected:false];
    }
    RLSUserModel *userModel = [RLSMethods getUserModel];
    if (userModel.idId == model.idId) {
        self.followBtn.hidden = YES;
    } else {
        self.followBtn.hidden = false;
    }
}
#pragma mark - Config UI
- (void)configUI {
    self.backgroundColor = UIColorFromRGBWithOX(0xeeeeee);
    [self.layer addSublayer:self.redLayer];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.size.mas_equalTo(CGSizeMake(imageHeight, imageHeight));
    }];
    [self.contentView addSubview:self.levealImageView];
    [self.levealImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(40);
        make.left.equalTo(self.contentView.mas_left).offset(40);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(8);
        make.left.equalTo(self.avatarImageView.mas_right).offset(15);
    }];
    [self.contentView addSubview:self.desLabel];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(8);
        make.left.equalTo(self.nameLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(0);
    }];
    [self.contentView addSubview:self.followBtn];
    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}
#pragma mark - Events
- (void)focusAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(addAtention:)]) {
        [_delegate addAtention:sender.selected];
    }
}
- (void)avatarClick {
    RLSDC_JZAPhotoVC *album = [[RLSDC_JZAPhotoVC alloc] init];
    album.imgArr = [NSMutableArray arrayWithObject:_model.pic];
    [APPDELEGATE.customTabbar presentToViewController:album animated:YES completion:^{
    }];
}
- (void)controlAction:(RLSMessageControl *)sender {
    if (sender.tag == 0) {
        RLSFriendsVC *friend = [[RLSFriendsVC alloc] init];
        friend.userId = _model.idId;
        friend.selectedIndex = 1;
        friend.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:friend animated:YES];
    } else if (sender.tag == 1) {
        RLSFriendsVC *friend = [[RLSFriendsVC alloc] init];
        friend.userId = _model.idId;
        friend.selectedIndex = 0;
        friend.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:friend animated:YES];
    } else if (sender.tag == 2) {
        RLSUserTuijianVC *tuijian = [[RLSUserTuijianVC alloc] init];
        tuijian.userName = _model.nickname;
        tuijian.userId = _model.idId;
        tuijian.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:tuijian animated:YES];
    }
}
#pragma mark - Lazy Load
- (CALayer *)redLayer {
    if (_redLayer == nil) {
        _redLayer = [CALayer layer];
        _redLayer.backgroundColor = redcolor.CGColor;
        _redLayer.frame = CGRectMake(0, 0, self.width, self.height / 2);
    }
    return _redLayer;
}
- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, self.width - 20, self.height - 10)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 5;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}
- (UIImageView *)avatarImageView {
    if (_avatarImageView == nil) {
        _avatarImageView = [UIImageView new];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.layer.cornerRadius = imageHeight / 2.f;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.borderWidth = 0.5;
        _avatarImageView.layer.borderColor = UIColorFromRGBWithOX(0xffffff).CGColor;
        [_avatarImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarClick)]];
        _avatarImageView.userInteractionEnabled = YES;
    }
    return _avatarImageView;
}
- (UIImageView *)levealImageView {
    if (_levealImageView == nil) {
        _levealImageView = [UIImageView new];
    }
    return _levealImageView;
}
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:18.f];;
    }
    return _nameLabel;
}
- (UILabel *)desLabel {
    if (_desLabel == nil) {
        _desLabel = [UILabel new];
        _desLabel.font = [UIFont systemFontOfSize:13.f];;
        _desLabel.textColor = UIColorFromRGBWithOX(0x999999);
        _desLabel.text = @"马上登录，获取更多的信息和福利";
        _desLabel.numberOfLines = 2;
    }
    return _desLabel;
}
- (UIButton *)followBtn {
    if (_followBtn == nil) {
        _followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_followBtn setBackgroundImage:[UIImage imageNamed:@"focus1"] forState:UIControlStateNormal];
        [_followBtn setBackgroundImage:[UIImage imageNamed:@"focus2"] forState:UIControlStateSelected];
        [_followBtn addTarget:self action:@selector(focusAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followBtn;
}
- (NSMutableArray *)recordArray {
    if (_recordArray == nil) {
        _recordArray = [NSMutableArray new];
    }
    return _recordArray;
}
@end
