//
//  RLSShowSignalS.m
//  GQZhiBo
//
//  Created by genglei on 2019/1/11.
//  Copyright © 2019年 GQXX. All rights reserved.
//

#import "RLSShowSignals.h"

@interface RLSShowSignals ()

@property (nonatomic , copy) NSArray *signals;
@property (nonatomic , strong) UIView *container;
@property (nonatomic , strong) UIView *lineVeiw;
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UIButton *cancleBtn;
@property (nonatomic , strong) UIButton *reloadBtn;
@property (nonatomic , copy) NSString *mid;
@property (nonatomic , strong) UIView *coverView;

@end

static CGFloat itemHeight = 40.0;
static CGFloat spaceWidth = 20.0;

@implementation RLSShowSignals

- (instancetype)initWithFrame:(CGRect)frame mid:(NSString *)mid {
    if (self = [super initWithFrame:frame]) {
        _mid = [mid copy];
        [self configUI];
    }
    return self;
}

- (void)showSignals:(NSArray<NSString *> *)signal {
    _signals = [signal copy];
    self.hidden = false;
    CGFloat containerHeight = itemHeight * _signals.count + 44 + 80;
    CGFloat containerWidth = Width - 40;
    self.container.frame = CGRectMake(spaceWidth, (Height - containerHeight) / 2, containerWidth, containerHeight);
    [self.container removeAllSubViews];
    [self.container addSubview:self.lineVeiw];
    self.lineVeiw.frame = CGRectMake(0, 43, self.container.width, ONE_PX_LINE);
    [self.container addSubview:self.titleLab];
    self.titleLab.frame = CGRectMake((_container.width - 100) / 2, 7, 100, 30);
    [_container addSubview:self.reloadBtn];
    self.reloadBtn.frame = CGRectMake(_container.width - 15 - 24, 10, 24, 24);
    ItemControl *control = nil;
    for (NSInteger i = 0; i < _signals.count; i ++) {
        BOOL hideLine = false;
        if (i == _signals.count - 1) {
            hideLine = true;
        }
        ItemControl *item = [[ItemControl alloc]initWithFrame:CGRectMake(0, _titleLab.bottom + i * 44, _container.width, 44) data:_signals[i] hideBottomLins:hideLine];
        [item addTarget:self action:@selector(didSelectItem:) forControlEvents:UIControlEventTouchUpInside];
        item.tag = i;
        [_container addSubview:item];
        control = item;
    }
    [_container addSubview:self.cancleBtn];
    self.cancleBtn.frame = CGRectMake(15, control.bottom + 20, _container.width - 30, 40);
}

#pragma mark - Config UI

- (void)configUI {
    self.backgroundColor =[UIColor clearColor];
    [self addSubview:self.coverView];
    [self addSubview:self.container];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHiden)];
    [self.coverView addGestureRecognizer:tap];
}

#pragma mark Private Method

- (void)hideAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        self.container.alpha = 0;
        self.alpha = 0;
        self.container.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        self.hidden = true;
        self.alpha = 1;
         self.container.alpha = 1;
        self.container.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

#pragma mark - Events

- (void)tapHiden {
    [self hideAnimation];
}

- (void)reload {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
        [parameter setObject:_mid forKey:@"mid"];
        [[RLSDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_video_list] Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
        } Success:^(id responseResult, id responseOrignal) {
            NSArray *data = responseOrignal[@"data"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showSignals:data];
            });
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            
        }];
    });
}

- (void)didSelectItem:(ItemControl *)sender {
    [self hideAnimation];
    NSInteger tag = sender.tag;
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectItem:)]) {
        [_delegate didSelectItem:_signals[tag]];
    }
}

#pragma mark - Lazy Load

- (UIView *)container {
    if (_container == nil) {
        _container = [[UIView alloc]init];
        _container.backgroundColor = [UIColor whiteColor];
        _container.layer.cornerRadius = 5;
        _container.layer.masksToBounds = true;
    }
    return _container;
}

- (UIView *)lineVeiw {
    if (_lineVeiw == nil) {
        _lineVeiw = [[UIView alloc]initWithFrame:CGRectZero];
        _lineVeiw.backgroundColor = UIColorHex(0xeeeeee);
    }
    return _lineVeiw;
}

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"选择直播线路";
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = UIColorHex(0x333333);
        _titleLab.font = [UIFont systemFontOfSize:16.f];
    }
    return _titleLab;
}

- (UIButton *)cancleBtn {
    if (_cancleBtn == nil) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.backgroundColor = [UIColor orangeColor];
        [_cancleBtn addTarget:self action:@selector(tapHiden) forControlEvents:UIControlEventTouchUpInside];
        [_cancleBtn setBackgroundImage:[UIImage imageNamed:@"cancle_btn"] forState:UIControlStateNormal];
    }
    return _cancleBtn;
}

- (UIButton *)reloadBtn {
    if (_reloadBtn == nil) {
        _reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reloadBtn addTarget:self action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
        [_reloadBtn setBackgroundImage:[UIImage imageNamed:@"ref_icon"] forState:UIControlStateNormal];
    }
    return _reloadBtn;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc]initWithFrame:self.bounds];
        _coverView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.3];
    }
    return _coverView;
}

@end

@interface ItemControl()

@property (nonatomic , copy) NSDictionary *dataDic;
@property (nonatomic, assign) BOOL hideLine;
@property (nonatomic , strong) UILabel *leftTitle;
@property (nonatomic, strong) BaseImageView *rightArrowImageView;
@property (nonatomic , strong) UIView *lineVeiw;


@end

@implementation ItemControl

- (instancetype)initWithFrame:(CGRect)frame data:(NSDictionary *)data hideBottomLins:(BOOL)hideLine; {
    self = [super initWithFrame:frame];
    if (self) {
        _dataDic = [data copy];
        _hideLine = hideLine;
        [self configUI];
        [self loadData];
    }
    return self;
}

#pragma mark - Config UI

- (void)configUI {
    [self addSubview:self.leftTitle];
    self.leftTitle.frame = CGRectMake(15, 0, 200, self.height);
    [self addSubview:self.rightArrowImageView];
    self.rightArrowImageView.frame = CGRectMake(self.width - 15 - 24, 10, 24, 24);
    [self addSubview:self.lineVeiw];
    self.lineVeiw.frame = CGRectMake(0, self.height - ONE_PX_LINE, Width, ONE_PX_LINE);
}

#pragma mark - Load Data

- (void)loadData {
    self.leftTitle.text = _dataDic[@"name"];
}

#pragma mark - Lazy Load

- (UILabel *)leftTitle {
    if (_leftTitle == nil) {
        _leftTitle = [[UILabel alloc]init];
        _leftTitle.text = @"直播";
        _leftTitle.textAlignment = NSTextAlignmentLeft;
        _leftTitle.textColor = UIColorHex(0x666666);
        _leftTitle.font = [UIFont systemFontOfSize:14.f];
    }
    return _leftTitle;
}

- (BaseImageView *)rightArrowImageView {
    if (_rightArrowImageView == nil) {
        _rightArrowImageView = [[BaseImageView alloc]init];
        _rightArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
        _rightArrowImageView.image = [UIImage imageNamed:@"right_icon"];
        
    }
    return _rightArrowImageView;
}

- (UIView *)lineVeiw {
    if (_lineVeiw == nil) {
        _lineVeiw = [[UIView alloc]initWithFrame:CGRectZero];
        _lineVeiw.backgroundColor = UIColorHex(0xeeeeee);
    }
    return _lineVeiw;
}


@end
