#import "RLSDeatilHeaderView.h"
#import "RLSDC_JZAPhotoVC.h"
@interface RLSDeatilHeaderView ()
@property (nonatomic , strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic , strong) UILabel *dataLabel;
@property (nonatomic , strong) UILabel *likeCountLabel;
@property (nonatomic , strong) UIButton *likeBtn;
@property (nonatomic , strong) UILabel *contentLabel;
@end
@implementation RLSDeatilHeaderView
static CGFloat imageHeight = 45;
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}
#pragma mark - Open Method
- (void)setGroupModel:(InfoGroupModel *)groupModel {
    _groupModel = groupModel;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://mobile.gunqiu.com/avatar/%zi",_groupModel.userId]] placeholderImage:[UIImage imageNamed:@"defaultPic"]];
    self.nameLabel.text = _groupModel.nickname;
    self.dataLabel.text = [RLSMethods compareCurrentTime:_groupModel.date];
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zi",_groupModel.likeCount];
    self.contentLabel.text = PARAM_IS_NIL_ERROR(_groupModel.content);
    if (_groupModel.liked) {
        self.likeBtn.selected = YES;
    } else {
        self.likeBtn.selected = false;
    }
    CGSize size = [self sizeWithString:self.contentLabel.text font:0 maxWidth:Width - 30];
    CGFloat height = size.height + 100;
    if (height > 123) {
        self.height = height + 10;
        self.bgView.height = height;
    }
}
- (CGSize)sizeWithString:(NSString *)string font:(CGFloat)font maxWidth:(CGFloat)maxWidth {
    NSDictionary *attributesDict = @{NSFontAttributeName:[UIFont systemFontOfSize:14.f]};
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    CGRect subviewRect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDict context:nil];
    return subviewRect.size;
}
#pragma mark - Config UI
- (void)configUI {
    self.backgroundColor = UIColorFromRGBWithOX(0xE9E9E9);
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_top).offset(15);
        make.left.equalTo(self.bgView.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(imageHeight, imageHeight));
    }];
    [self.bgView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).offset(10);
        make.top.equalTo(self.avatarImageView.mas_top);
    }];
    [self.bgView addSubview:self.dataLabel];
    [self.dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.bottom.equalTo(self.avatarImageView.mas_bottom);
    }];
    [self.bgView addSubview:self.likeCountLabel];
    [self.likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right).offset(-15);
        make.top.equalTo(self.nameLabel.mas_top);
    }];
    [self.bgView addSubview:self.likeBtn];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.likeCountLabel.mas_left).offset(-3);
        make.centerY.equalTo(self.likeCountLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    [self.bgView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_left);
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(17);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
}
#pragma mark - Events
- (void)avatarClick {
    RLSDC_JZAPhotoVC *album = [[RLSDC_JZAPhotoVC alloc] init];
    album.imgArr = [NSMutableArray arrayWithObject:[NSString stringWithFormat:@"http://mobile.gunqiu.com/avatar/%zi",_groupModel.userId]];
    [APPDELEGATE.customTabbar presentToViewController:album animated:YES completion:^{
    }];
}
- (void)likeAction:(UIButton *)sender {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setValue:_groupModel.newsId forKey:@"newsid"];
    [parameter setValue:_groupModel.commentId forKey:@"parentid"];
    [[RLSDCHttpRequest shareInstance]sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,info_like_url] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([responseOrignal[@"code"] isEqualToString:@"200"]) {
            _groupModel.likeCount = _groupModel.likeCount + 1;
            _groupModel.liked = YES;
            self.likeCountLabel.text = [NSString stringWithFormat:@"%zi",_groupModel.likeCount];
            self.likeBtn.selected = YES;
        } else {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:responseOrignal[@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:responseOrignal[@"msg"]];
    }];
}
#pragma mark - Lazy Load
- (UIImageView *)avatarImageView {
    if (_avatarImageView == nil) {
        _avatarImageView = [UIImageView new];
        _avatarImageView.backgroundColor = [UIColor orangeColor];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.layer.cornerRadius = imageHeight / 2.f;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.borderWidth = 0.5;
        _avatarImageView.layer.borderColor = UIColorFromRGBWithOX(0xffffff).CGColor;
        [_avatarImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarClick)]];
        _avatarImageView.backgroundColor = [UIColor orangeColor];
        _avatarImageView.userInteractionEnabled = YES;
    }
    return _avatarImageView;
}
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:15.f];;
        _nameLabel.textColor = UIColorFromRGBWithOX(0x000000);
        _nameLabel.text = @"你的名字";
        _nameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLabel;
}
- (UILabel *)dataLabel {
    if (_dataLabel == nil) {
        _dataLabel = [UILabel new];
        _dataLabel.font = [UIFont systemFontOfSize:12.f];;
        _dataLabel.textColor = UIColorFromRGBWithOX(0x000000);
    }
    return _dataLabel;
}
- (UILabel *)likeCountLabel {
    if (_likeCountLabel == nil) {
        _likeCountLabel = [UILabel new];
        _likeCountLabel.font = [UIFont systemFontOfSize:13.f];;
        _likeCountLabel.textColor = UIColorFromRGBWithOX(0x000000);
    }
    return _likeCountLabel;
}
- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont systemFontOfSize:14.f];;
        _contentLabel.textColor = UIColorFromRGBWithOX(0x000000);
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}
- (UIButton *)likeBtn {
    if (_likeBtn == nil) {
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"zan-dq"] forState:UIControlStateSelected];
        [_likeBtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}
- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 123)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
@end
