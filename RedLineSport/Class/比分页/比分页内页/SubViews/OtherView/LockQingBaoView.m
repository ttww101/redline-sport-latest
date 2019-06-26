//
//  LockQingBaoView.m
//  GQZhiBo
//
//  Created by genglei on 2019/1/21.
//  Copyright © 2019年 GQXX. All rights reserved.
//

#import "LockQingBaoView.h"

@implementation LockQingBaoView {
    BaseImageView *_bgIV;
    UILabel *_messageLab;
    UIButton *_diamond;
    UIControl *_actionControl;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return  self;
}

- (void)layoutSubviews {
    _bgIV.frame = self.bounds;
    _diamond.frame = CGRectMake((self.width - 80) / 2, self.height * 0.4, 80, 26);
    _messageLab.frame = CGRectMake(0, _diamond.bottom + 10, self.width, 20);
    _actionControl.frame = self.bounds;
}

#pragma mark - Config UI

- (void)configUI {
    _bgIV = [[BaseImageView alloc]initWithFrame:self.bounds];
    _bgIV.image = [UIImage imageNamed:@"FuzzyImage"];
    [self addSubview:_bgIV];
    
    _messageLab = [[UILabel alloc]initWithFrame:CGRectZero];
    _messageLab.numberOfLines = 1;
    _messageLab.textColor = UIColorHex(#FF8E00);
    _messageLab.font = [UIFont systemFontOfSize:13];
    _messageLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_messageLab];
    
    _diamond = [UIButton buttonWithType:UIButtonTypeCustom];
    _diamond.titleLabel.font = [UIFont systemFontOfSize:12];
    [_diamond setBackgroundColor:UIColorHex(#FF8E00)];
    [_diamond setImage:[UIImage imageNamed:@"lock"] forState:UIControlStateNormal];
    _diamond.layer.cornerRadius = 13;
    _diamond.layer.masksToBounds = true;
    [self addSubview:_diamond];
    
    _actionControl = [[UIControl alloc]init];
    [_actionControl addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_actionControl];
}

- (void)setInfoMap:(NSDictionary *)infoMap {
    _infoMap = infoMap;
    NSInteger count = [_infoMap[@"diamond"] integerValue] / 100;
    [_diamond setTitle:[NSString stringWithFormat:@" %ld 连红币", count] forState:UIControlStateNormal];
    _messageLab.text = [NSString stringWithFormat:@"%zi钻石解锁该场赛事%zi条情报", count, [ _infoMap[@"count"] integerValue]];
}

#pragma mark - Events

- (void)tapAction {
    if (_delegate && [_delegate respondsToSelector:@selector(LockQingBaoViewTapAction)]) {
        [_delegate LockQingBaoViewTapAction];
    }
}


@end
