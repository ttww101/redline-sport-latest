#import "RLSSelectPayMentView.h"
@interface RLSSelectPayMentView () <OptionViewDelegate>
@property (nonatomic, strong) UIView *targetView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic , copy) NSArray *options;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic , copy) payType didSelectType;
@property (nonatomic , strong) UIView *intervalView;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic , strong) UIButton *confirmBtn;
@property (nonatomic , strong) UIButton *closeBtn;
@property (nonatomic , strong) RLSSelectPayMentView *isaView;
@property (nonatomic , copy) NSString *information;
@property (nonatomic , strong) UIButton *recordBtn;
@end
@implementation RLSSelectPayMentView
+ (instancetype)showPaymentInfo:(id)information
                        options:(NSArray *)option
                     animations:(BOOL)animation
                   selectOption:(payType)payType{
    UIView *windowView = [[UIApplication sharedApplication].delegate window].rootViewController.view;
    static RLSSelectPayMentView *payView = nil;
    if (!payView) {
        payView = [[RLSSelectPayMentView alloc]initWithFrame:windowView.bounds];
    }
    payView.targetView = windowView;
    payView.options = option;
    payView.information = information;
    [payView showAlertWithAnimation:animation];
    if (payType) {
        payView.didSelectType = payType;
    }
    return payView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.isaView = self;
    }
    return self;
}
#pragma mark - Config UI
- (void)configUI {
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    CGFloat bgHeight = 98 + 25 +  _options.count * 44 + 82;
    CGFloat top = (Height - bgHeight) / 2.f - 34;
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(top);
        make.right.equalTo(self.contentView.mas_right).offset(-25);
        make.left.equalTo(self.contentView.mas_left).offset(25);
        make.height.mas_equalTo(bgHeight);
    }];
    [self.bgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_top).offset(15);
        make.centerX.equalTo(self.bgView.mas_centerX);
    }];
    [self.bgView addSubview:self.amountLabel];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.bgView.mas_centerX);
    }];
    self.amountLabel.text = _information;
    [self.bgView addSubview:self.intervalView];
    [self.intervalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.amountLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self.bgView).offset(0);
        make.height.mas_equalTo(25);
    }];
    [self.intervalView addSubview:self.typeLabel];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.intervalView.mas_left).offset(15);
        make.centerY.equalTo(self.intervalView.mas_centerY);
    }];
    [self.bgView addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-20);
        make.left.equalTo(self.bgView.mas_left).offset(75);
        make.right.equalTo(self.bgView.mas_right).offset(-75);
        make.height.mas_equalTo(42 * (Width / 375));
    }];
    [self.contentView addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.bgView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    for (NSInteger i = 0; i < _options.count; i ++) {
        RLSOptionView *view = [[RLSOptionView alloc]initWithFrame:CGRectMake(0, 98 + 25 + i * 44, Width - 50, 44) configDictionary:_options[i]];
        view.deleate = self;
        [self.bgView addSubview:view];
        if (i == _options.count - 1) {
            [view hideBottormLine];
        }
    }
}
#pragma mark - OptionViewDelegate
- (void)didSelectAction:(UIButton *)sender {
    if (self.recordBtn) {
        self.recordBtn.selected = false;
    }
    sender.selected = !sender.selected;
    self.recordBtn = sender;
    [self.confirmBtn setSelected:YES];
}
#pragma mark - Private Method
- (void)showAlertWithAnimation:(BOOL)animation {
    [self.targetView addSubview:self]; 
    self.alpha = 1;
    self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6f];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.contentView.subviews.count > 0) {
        } else {
            [self configUI];
        }
        [UIView animateWithDuration:0.8 delay:0.1 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.contentView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
        }];
    });
}
- (void)hideAnimationWithDelegate:(BOOL)isDelegate {
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:0 animations:^{
        self.alpha = 0;
        self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.isaView = nil;
        if (self.contentView) {
            [self.bgView removeFromSuperview];
            self.bgView = nil;
            [self.contentView removeFromSuperview];
            self.contentView = nil;
            self.recordBtn = nil;
            self.confirmBtn = nil;
        }
    }];
}
#pragma mark - Events
- (void)closeAction {
    [self hideAnimationWithDelegate:YES];
}
- (void)preventFlicker:(UIButton *)button {
    button.highlighted = NO;
}
- (void)confirmAction:(UIButton *)sender {
    if (self.recordBtn) {
        self.didSelectType(self.recordBtn.tag);
        [self closeAction];
    } else{
        [SVProgressHUD showErrorWithStatus:@"请选择支付方式"];
    }
}
#pragma mark - Lazy Load
- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [UIView new];
    }
    return _contentView;
}
- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 5;
    }
    return _bgView;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"支付金额";
        _titleLabel.font = [UIFont systemFontOfSize:12.f];
        _titleLabel.textColor = UIColorFromRGBWithOX(0x323232);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UILabel *)amountLabel {
    if (_amountLabel == nil) {
        _amountLabel = [UILabel new];
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        _amountLabel.textColor = UIColorFromRGBWithOX(0xC83E2E);
        _amountLabel.font = [UIFont systemFontOfSize:30.f];
    }
    return _amountLabel;
}
- (UIView *)intervalView {
    if (_intervalView == nil) {
        _intervalView = [UIView new];
        _intervalView.backgroundColor = UIColorFromRGBWithOX(0xF7F7F7);
    }
    return _intervalView;
}
- (UILabel *)typeLabel {
    if (_typeLabel == nil) {
        _typeLabel = [UILabel new];
        _typeLabel.text = @"支付方式";
        _typeLabel.font = [UIFont systemFontOfSize:12.f];
        _typeLabel.textColor = UIColorFromRGBWithOX(0x646464);
    }
    return _typeLabel;
}
- (UIButton *)confirmBtn {
    if (_confirmBtn == nil) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIColorFromRGBWithOX(0x646464) forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIColorFromRGBWithOX(0xffffff) forState:UIControlStateSelected];
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"bgunselect"] forState:UIControlStateNormal];
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"bgselect"] forState:UIControlStateSelected];
        [_confirmBtn addTarget:self action:@selector(preventFlicker:) forControlEvents:UIControlEventAllTouchEvents];
        [_confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}
- (UIButton *)closeBtn {
    if (_closeBtn == nil) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}
@end
