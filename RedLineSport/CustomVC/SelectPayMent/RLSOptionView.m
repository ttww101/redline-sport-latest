#import "RLSOptionView.h"
NSString *const PayMentLeftIcon = @"PayMentLeftIcon";
NSString *const PayMentTitle = @"PayMentTitle";
NSString *const PayMentType = @"PayMentType";
NSString *const CouponCount = @"CouponCount";
@interface RLSOptionView ()
@property (nonatomic , copy) NSDictionary *dic;
@property (nonatomic , copy) UIImageView *leftIcon;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *couponCountLabel;
@property (nonatomic , strong) UIButton *selectBtn;
@end
@implementation RLSOptionView
- (instancetype)initWithFrame:(CGRect)frame  configDictionary:(NSDictionary *)dic {
    self = [super initWithFrame:frame];
    if (self) {
        _dic = [dic copy];
        [self configUI];
        [self setData];
    }
    return self;
}
#pragma mark - Open Method
- (void)hideBottormLine {
    self.lineView.hidden = YES;
}
#pragma mark - Config UI
- (void)configUI {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.leftIcon];
    [self.leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftIcon.mas_right).offset(15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-0.5);
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    [self addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(19, 19));
    }];
    [self addSubview:self.couponCountLabel];
    [self.couponCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
- (void)setData {
    self.leftIcon.image = [UIImage imageNamed:_dic[PayMentLeftIcon]];
    self.titleLabel.text = _dic[PayMentTitle];
    NSString *text = _dic[CouponCount];
    if (text) {
        self.couponCountLabel.hidden = false;
        NSString *attText = [NSString stringWithFormat:@"(剩%@张)",text];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:attText];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.f] range:[attText rangeOfString:attText]];
        [attStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBWithOX(0x323232) range:[attText rangeOfString:@"(剩"]];
        [attStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBWithOX(0xDB2D21) range:[attText rangeOfString:[NSString stringWithFormat:@"%@",text]]];
        [attStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBWithOX(0x323232) range:[attText rangeOfString:@"张)"]];
        self.couponCountLabel.attributedText = attStr;
    }
}
#pragma mark - Events
- (void)selectAction:(UIButton *)sender {
    sender.tag = [_dic[PayMentType] integerValue];
    if (_deleate && [_deleate respondsToSelector:@selector(didSelectAction:)]) {
        [_deleate didSelectAction:sender];
    }
}
#pragma mark - Lazy Load
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [UIView new];
        _lineView.backgroundColor = UIColorFromRGBWithOX(0xe2e2e2);
    }
    return _lineView;
}
- (UIImageView *)leftIcon {
    if (_leftIcon == nil) {
        _leftIcon = [UIImageView new];
        _leftIcon.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _leftIcon;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.textColor = UIColorFromRGBWithOX(0x323232);
    }
    return _titleLabel;
}
- (UILabel *)couponCountLabel {
    if (_couponCountLabel == nil) {
        _couponCountLabel = [UILabel new];
        _couponCountLabel.hidden = YES;
    }
    return _couponCountLabel;
}
- (UIButton *)selectBtn {
    if (_selectBtn == nil) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"selectType"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}
@end
