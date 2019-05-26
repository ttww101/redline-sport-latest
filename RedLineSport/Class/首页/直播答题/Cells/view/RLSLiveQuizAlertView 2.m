#import "RLSLiveQuizAlertView.h"
@interface RLSLiveQuizAlertView ()
@property (nonatomic, strong) UIView *targetView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic , copy) NSDictionary *information;
@property (nonatomic , copy) didSelectAction action;
@property (nonatomic , strong) RLSLiveQuizAlertView *isaView;
@property (nonatomic , strong) UIButton *statedHereBtn;
@property (nonatomic , strong) UIButton *leaveBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) dispatch_source_t timer;
@end
@implementation RLSLiveQuizAlertView
+ (instancetype)showPaymentInfo:(id)information
                     animations:(BOOL)animation
                   selectOption:(didSelectAction)selectAction {
    UIView *windowView = [[UIApplication sharedApplication].delegate window].rootViewController.view;
    static RLSLiveQuizAlertView *payView = nil;
    if (!payView) {
        payView = [[RLSLiveQuizAlertView alloc]initWithFrame:windowView.bounds];
    }
    payView.targetView = windowView;
    payView.information = information;
    [payView showAlertWithAnimation:animation];
    if (selectAction) {
        payView.action = selectAction;
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
    CGFloat bgHeight = 251 * ScreenRatio;
    CGFloat top = 244 * ScreenRatio;
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(top);
        make.right.equalTo(self.contentView.mas_right).offset(-15 * ScreenRatio);
        make.left.equalTo(self.contentView.mas_left).offset(15 * ScreenRatio);
        make.height.mas_equalTo(bgHeight);
    }];
    self.titleLabel.text = PARAM_IS_NIL_ERROR(_information[@"text"]);
    [self.bgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_top).offset(30 * ScreenRatio);
        make.left.equalTo(self.bgView.mas_left).offset(30 * ScreenRatio);
        make.right.equalTo(self.bgView.mas_right).offset(-30 * ScreenRatio);
    }];
    [self.bgView addSubview:self.statedHereBtn];
    [self.statedHereBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_top).offset(115 * ScreenRatio);
        make.centerX.equalTo(self.bgView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(240 * ScreenRatio, 48 * ScreenRatio));
    }];
    [self.statedHereBtn setTitle:PARAM_IS_NIL_ERROR(_information[@"button1"] ) forState:UIControlStateNormal];
    [self.bgView addSubview:self.leaveBtn];
    [self.leaveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statedHereBtn.mas_bottom).offset(20 * ScreenRatio);
        make.centerX.equalTo(self.bgView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(240 * ScreenRatio, 48 * ScreenRatio));
    }];
    [self.leaveBtn setTitle:PARAM_IS_NIL_ERROR(_information[@"button2"]) forState:UIControlStateNormal];
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
        [self cancleGCDTimer];
        if (self.contentView) {
            [self.bgView removeFromSuperview];
            self.bgView = nil;
            [self.contentView removeFromSuperview];
            self.contentView = nil;
        }
    }];
}
- (void)scheduledGCDTimer {
    [self cancleGCDTimer];
    __block int timeLeave = 3; 
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); 
    __typeof (self) __weak weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        if(timeLeave <= 0){ 
            dispatch_source_cancel(weakSelf.timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideAnimationWithDelegate:YES];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
            });
            --timeLeave;
        }
    });
    dispatch_resume(_timer);
}
- (void)cancleGCDTimer {
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}
#pragma mark - Events
- (void)closeAction:(UIButton *)sender  {
    self.action(@"close");
    [self hideAnimationWithDelegate:YES];
}
- (void)statedHereAction:(UIButton *)sender {
    [self hideAnimationWithDelegate:YES];
}
- (void)preventFlicker:(UIButton *)button {
    button.highlighted = NO;
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
        _bgView.layer.cornerRadius = 10 * ScreenRatio;
    }
    return _bgView;
}
- (UIButton *)statedHereBtn {
    if (_statedHereBtn == nil) {
        _statedHereBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_statedHereBtn setTitle:@"留下继续" forState:UIControlStateNormal];
        [_statedHereBtn setTitleColor:UIColorFromRGBWithOX(0xffffff) forState:UIControlStateNormal];
        [_statedHereBtn setBackgroundImage:[UIImage imageNamed:@"statedhere"] forState:UIControlStateNormal];
        [_statedHereBtn addTarget:self action:@selector(preventFlicker:) forControlEvents:UIControlEventAllTouchEvents];
        [_statedHereBtn addTarget:self action:@selector(statedHereAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _statedHereBtn;
}
- (UIButton *)leaveBtn {
    if (_leaveBtn == nil) {
        _leaveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leaveBtn setTitle:@"残忍离开" forState:UIControlStateNormal];
        [_leaveBtn setTitleColor:UIColorFromRGBWithOX(0x666666) forState:UIControlStateNormal];
        [_leaveBtn setBackgroundImage:[UIImage imageNamed:@"leaveimage"] forState:UIControlStateNormal];
        [_leaveBtn addTarget:self action:@selector(preventFlicker:) forControlEvents:UIControlEventAllTouchEvents];
        [_leaveBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leaveBtn;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"现在退出将不能参与免费领取预测模型优惠券活动";
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.textColor = UIColorFromRGBWithOX(0x333333);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}
@end
