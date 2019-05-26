#import "RLSInfoTableViewCell.h"
#import "RLSDC_JZAPhotoVC.h"
@interface RLSInfoTableViewCell ()
@property (nonatomic , strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic , strong) UILabel *dataLabel;
@property (nonatomic , strong) UILabel *likeCountLabel;
@property (nonatomic , strong) UIButton *likeBtn;
@property (nonatomic , strong) UIButton *moreRepliesBtn;
@property (nonatomic , strong) UILabel *contentLabel;
@end
@implementation RLSInfoTableViewCell
static CGFloat cell_Height = 123;
static NSString *identifier = @"infoCell";
static CGFloat imageHeight = 45;
+ (RLSInfoTableViewCell *)cellForTableView:(UITableView *)tableView {
    RLSInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[RLSInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}
#pragma mark - Open Method
+ (CGFloat)heightForCell {
    return cell_Height;
}
- (void)hideMoreReply {
     [self.moreRepliesBtn setTitle:@"" forState:UIControlStateNormal];
    [self.moreRepliesBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(5);
    }];
}
- (void)setModel:(InfoGroupModel *)model {
    _model = model;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://mobile.gunqiu.com/avatar/%zi",_model.userId]] placeholderImage:[UIImage imageNamed:@"defaultPic"]];
    self.nameLabel.text = _model.nickname;
    self.dataLabel.text = [RLSMethods compareCurrentTime:_model.date];
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zi",_model.likeCount];
    [self.moreRepliesBtn setTitle:[NSString stringWithFormat:@"共有%zi条回复>",_model.commentCount] forState:UIControlStateNormal];
    self.contentLabel.text = PARAM_IS_NIL_ERROR(_model.content);
    if (model.liked) {
        self.likeBtn.selected = YES;
    } else {
        self.likeBtn.selected = false;
    }
}
#pragma mark - Config UI
- (void)configUI {
    [self.contentView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(imageHeight, imageHeight));
    }];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    [self.contentView addSubview:self.dataLabel];
    [self.dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.avatarImageView.mas_bottom);
    }];
    [self.contentView addSubview:self.likeCountLabel];
    [self.likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.nameLabel.mas_top);
    }];
    [self.contentView addSubview:self.likeBtn];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.likeCountLabel.mas_left).offset(-3);
        make.centerY.equalTo(self.likeCountLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_left);
        make.top.equalTo(self.dataLabel.mas_bottom).offset(17);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    [self.contentView addSubview:self.moreRepliesBtn];
    [self.moreRepliesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_left);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(4);
    }];
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moreRepliesBtn.mas_bottom).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(13);
        make.right.equalTo(self.contentView.mas_right).offset(-13);
        make.height.mas_equalTo(ONE_PX_LINE);
    }];
}
#pragma mark - Events
- (void)avatarClick {
    RLSDC_JZAPhotoVC *album = [[RLSDC_JZAPhotoVC alloc] init];
    album.imgArr = [NSMutableArray arrayWithObject:[NSString stringWithFormat:@"http://mobile.gunqiu.com/avatar/%zi",_model.userId]];
    [APPDELEGATE.customTabbar presentToViewController:album animated:YES completion:^{
    }];
}
- (void)likeAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(tableViewCell:likeComment:)]) {
        [_delegate tableViewCell:self likeComment:sender];
    }
}
- (void)moreAction {
    if (_delegate && [_delegate respondsToSelector:@selector(tableViewCell:moreComments:)]) {
        [_delegate tableViewCell:self moreComments:nil];
    }
}
#pragma mark - Lazy Load
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [UIView new];
        _lineView.backgroundColor = UIColorFromRGBWithOX(0xD7D7D7);
    }
    return _lineView;
}
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
- (UIButton *)moreRepliesBtn {
    if (_moreRepliesBtn == nil) {
        _moreRepliesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreRepliesBtn setTitleColor:UIColorFromRGBWithOX(0xFB0F0F) forState:UIControlStateNormal];
        _moreRepliesBtn.titleLabel.font = font11;
        [_moreRepliesBtn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreRepliesBtn;
}
@end
