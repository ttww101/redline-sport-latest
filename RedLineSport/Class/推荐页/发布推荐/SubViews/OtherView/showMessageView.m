//
//  showMessageView.m
//  GQZhiBo
//
//  Created by genglei on 2018/12/19.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "showMessageView.h"

@interface showMessageView ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic , strong) UIView *coverView;
@property (nonatomic , strong) UIView *container;
@property (nonatomic , strong) CALayer *line;
@property (nonatomic , strong) UIButton *closeBtn;
@property (nonatomic , strong) UIButton *recodBtn;
@property (nonatomic , strong) NSMutableArray *btns;
@property (nonatomic , strong) showMessageView *variableView;
@property (nonatomic , strong) UILabel *recentLab;

@end

@implementation showMessageView

static CGFloat space = 52;

+ (showMessageView *)showMessage:(NSString *)message  {
    UIWindow *window = [RLSMethods getMainWindow];
    showMessageView *view = [[showMessageView alloc]initWithFrame:window.bounds message:message];
    [window addSubview:view];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame message:(NSString *)message {
    self = [super initWithFrame:frame];
    if (self) {
        self.variableView = self;
        self.title = message;
        [self configUI];
        [self showAnimation];
    }
    return self;
}

- (void)configUI {
    self.container.alpha = 0;
    self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.6];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHiden)];
    [self addGestureRecognizer:tap];
    
    [self addSubview:self.container];
    self.container.frame = CGRectMake(space, (Height - Scale_Value(124)) / 2, Width - space * 2, Scale_Value(124));
    self.recentLab.text = self.title;
    [self.container addSubview:self.recentLab];
    [self.recentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.container.mas_top).offset(Scale_Value(31));
    }];
    
    [self.container addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.container.mas_bottom).offset(Scale_Value(-13));
        make.right.equalTo(self.container.mas_right).offset(-15);
        make.left.equalTo(self.container.mas_left).offset(15);
        make.height.mas_equalTo(Scale_Value(28));
    }];
}


- (void)hideAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        self.container.alpha = 0;
        self.container.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.variableView = nil;
    }];
}

- (void)showAnimation {
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
         self.container.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Events

- (void)close {
    [self hideAnimation];
}


- (void)tapHiden {
    [self hideAnimation];
}

#pragma mark - Lazy Load

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc]initWithFrame:self.bounds];
        _coverView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.3];
    }
    return _coverView;
}

- (UIView *)container {
    if (_container == nil) {
        _container = [[UIView alloc]init];
        _container.backgroundColor = [UIColor whiteColor];
        _container.layer.cornerRadius = 5;
        _container.layer.masksToBounds = true;
    }
    return _container;
}

- (UILabel *)recentLab {
    if (_recentLab == nil) {
        _recentLab = [UILabel new];
        _recentLab.font = [UIFont systemFontOfSize:16.f];;
        _recentLab.textColor = UIColorFromRGBWithOX(0x5F5F5F);
        _recentLab.adjustsFontSizeToFitWidth = YES;
        _recentLab.textAlignment = NSTextAlignmentCenter;
    }
    return _recentLab;
}

- (CALayer *)line {
    if (_line == nil) {
        _line = [[CALayer alloc]init];
        _line.backgroundColor = UIColorHex(eeeeee).CGColor;
    }
    return _line;
}

- (UIButton *)closeBtn {
    if (_closeBtn == nil) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"alert_confirm"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}


@end
