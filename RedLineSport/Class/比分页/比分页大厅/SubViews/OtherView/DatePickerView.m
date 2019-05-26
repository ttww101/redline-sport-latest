//
//  DatePickerView.m
//  GQZhiBo
//
//  Created by genglei on 2018/12/6.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "DatePickerView.h"
#import "RLSQiciModel.h"

@interface DatePickerView ()

@property (nonatomic, copy) NSArray *titles;
@property (nonatomic , strong) UIView *coverView;
@property (nonatomic , strong) UIView *container;
@property (nonatomic , strong) CALayer *line;
@property (nonatomic , strong) UIButton *closeBtn;
@property (nonatomic , strong) UIButton *recodBtn;
@property (nonatomic , strong) NSMutableArray *btns;
@property (nonatomic , strong) DatePickerView *variableView;
@property (nonatomic , copy) NSString *title;

@end

static CGFloat space = 15;

@implementation DatePickerView

+ (DatePickerView *)showDatePicker:(NSArray *)dates title:(NSString *)title;{
    UIWindow *window = [RLSMethods getMainWindow];
    DatePickerView *pickerView = [[DatePickerView alloc]initWithFrame:window.bounds titlesModel:dates title:title];
    [window addSubview:pickerView];
    return pickerView;
}

- (instancetype)initWithFrame:(CGRect)frame titlesModel:(NSArray *)titlesModel title:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
         self.variableView = self;
        self.titles = titlesModel;
        self.title = title;
        [self configUI];
        [self addTitleBtn:titlesModel];
        [self showAnimation];
    }
    return self;
}

#pragma mark - Config UI

- (void)configUI {
    self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.6];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHiden)];
    [self addGestureRecognizer:tap];
    
    [self addSubview:self.container];
    self.container.frame = CGRectMake(space, Height, Width - space * 2, 360);
    [self.container.layer addSublayer:self.line];
    self.line.frame = CGRectMake(0, 46, self.container.width, ONE_PX_LINE);
    
    [self.container addSubview:self.recentLab];
    [self.recentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.container.mas_top).offset(13);
    }];
    self.recentLab.text = self.title;
    
    [self.container addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.recentLab.mas_centerY);
        make.right.equalTo(self.container.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}

#pragma mark - Setter

- (void)addTitleBtn:(NSArray *)titles {
    CGFloat width = self.container.width - 40;
    for (NSInteger i = 0; i < titles.count; i ++) {
        RLSQiciModel *model = titles[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:model.item forState:UIControlStateNormal];
        [btn setTitleColor:UIColorHex(323232) forState:UIControlStateNormal];
        [btn setTitleColor:UIColorHex(DB2D21) forState:UIControlStateSelected];
        btn.titleLabel.font = font14;
        btn.contentMode = UIViewContentModeCenter;
        btn.frame = CGRectMake(20, 50 + 40 * i, width, 30);
        btn.tag = i;
        [btn addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
        if (model.selected) {
            btn.selected = true;
        }
        [self.container addSubview:btn];
    }
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
         self.container.top = self.height - self.container.height;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Events

- (void)close {
    [self hideAnimation];
}

- (void)selectDate:(UIButton *)sender {
    if (self.recodBtn != nil) {
        self.recodBtn.selected = false;
    }
    [self close];
    sender.selected = !sender.selected;
    self.recodBtn = sender;
    RLSQiciModel *model = self.titles[sender.tag];
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedDate:)]) {
        [_delegate didSelectedDate:model.val];
    }
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
        _recentLab.textColor = UIColorFromRGBWithOX(0x323232);
        _recentLab.text = @"近7天未开赛事";
        _recentLab.adjustsFontSizeToFitWidth = YES;
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
        [_closeBtn setImage:[UIImage imageNamed:@"bifen_close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

@end
