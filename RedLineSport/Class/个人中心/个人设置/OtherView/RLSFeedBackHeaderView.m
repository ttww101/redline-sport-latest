#import "RLSFeedBackHeaderView.h"
@interface RLSFeedBackHeaderView ()
@property (nonatomic, strong) UIView                        *basicView;
@property (nonatomic, strong) UITextView                    *feedTextView;
@property (nonatomic, strong) UILabel                       *textViewPlaceholder;
@property (nonatomic, strong) UIView                        *addImgBackView;
@property (nonatomic, strong) UIButton                      *addImgBtn;
@property (nonatomic, strong) UILabel                       *addImgeLab;
@property (nonatomic, strong) UILabel                       *telphoneLab;
@property (nonatomic, strong) UITextField                   *telPhoneTextField;
@end
@implementation RLSFeedBackHeaderView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.basicView];
        [self addAutolayout];
    }
    return self;
}
- (UIView *)basicView {
    if (!_basicView) {
        _basicView = [UIView new];
        _basicView.backgroundColor = colorTableViewBackgroundColor;
        [_basicView addSubview:self.feedTextView];
        [_basicView addSubview:self.textViewPlaceholder];
        [_basicView addSubview:self.addImgBackView];
        [self.addImgBackView addSubview:self.addImgBtn];
        [self.addImgBackView addSubview:self.addImgeLab];
        [_basicView addSubview:self.telphoneLab];
        [_basicView addSubview:self.telPhoneTextField];
    }
    return _basicView;
}
- (UITextView *)feedTextView {
    if (!_feedTextView) {
        _feedTextView = [UITextView new];
    }
    return _feedTextView;
}
- (UILabel *)textViewPlaceholder {
    if (!_textViewPlaceholder) {
        _textViewPlaceholder = [UILabel new];
        _textViewPlaceholder.text = @"请提出您的宝贵意见，我们第一时间回复您！！";
        _textViewPlaceholder.font = font13;
        _textViewPlaceholder.numberOfLines = 0;
    }
    return _textViewPlaceholder;
}
- (UIView *)addImgBackView {
    if (!_addImgBackView) {
        _addImgBackView = [UIView new];
    }
    return _addImgBackView;
}
- (UIButton *)addImgBtn {
    if (!_addImgBtn) {
        _addImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addImgBtn.imageView.image = [UIImage imageNamed:@"addImg"];
    }
    return _addImgBtn;
}
- (UILabel *)addImgeLab {
    if (!_addImgeLab) {
        _addImgeLab = [UILabel new];
        _addImgeLab.text = @"添加图片";
        _addImgeLab.font = font13;
    }
    return _addImgeLab;
}
-(UILabel *)telphoneLab {
    if (!_telphoneLab) {
        _telphoneLab = [UILabel new];
        _telphoneLab.text = @"手机号码";
        _telphoneLab.font = font13;
    }
    return _telphoneLab;
}
- (UITextField *)telPhoneTextField {
    if (!_telPhoneTextField) {
        _telPhoneTextField = [UITextField new];
    }
    return _telPhoneTextField;
}
- (void)addAutolayout {
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.feedTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(14);
        make.leading.equalTo(self).offset(15);
        make.trailing.equalTo(self).offset(-15);
        make.height.mas_equalTo(98);
    }];
    [self.textViewPlaceholder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.feedTextView).offset(20);
        make.leading.equalTo(self.feedTextView).offset(9);
        make.trailing.equalTo(self.feedTextView).offset(-5);
        make.height.mas_equalTo(10);
    }];
    [self.addImgBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.feedTextView.mas_bottom);
        make.leading.equalTo(self).offset(15);
        make.trailing.equalTo(self).offset(-15);
        make.height.mas_equalTo(71);
    }];
    [self.addImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addImgBackView).offset(17);
        make.leading.equalTo(self.addImgBackView).offset(9);
        make.size.mas_equalTo(CGSizeMake(37, 37));
    }];
    [self.addImgeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addImgBtn);
        make.leading.equalTo(self.addImgBtn.mas_trailing).offset(14);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(200);
    }];
    [self.telphoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addImgBackView.mas_bottom).offset(60);
        make.leading.equalTo(self).offset(25.5);
        make.height.mas_equalTo(23);
    }];
    [self.telPhoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.telphoneLab);
        make.leading.equalTo(self.telphoneLab.mas_trailing).offset(4);
        make.height.mas_equalTo(self.telphoneLab);
        make.centerY.equalTo(self.telphoneLab);
    }];
}
@end
