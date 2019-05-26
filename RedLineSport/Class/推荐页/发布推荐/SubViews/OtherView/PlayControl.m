//
//  PlayControl.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/26.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "PlayControl.h"

@interface PlayControl()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line;
@end

@implementation PlayControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    CGFloat width = [_title widthForFont:[UIFont systemFontOfSize:14]] + 10;
    [self.line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, 1));
    }];
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (_isSelected) {
        self.titleLabel.textColor = UIColorHex(#DB2D21);
        self.line.hidden = false;
    } else {
        self.titleLabel.textColor = UIColorHex(#454545);
        self.line.hidden = true;
    }
}

#pragma mark - Config UI

- (void)configUI {
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-1);
        make.size.mas_equalTo(CGSizeZero);
    }];
}

#pragma mark - Lazy Load

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)line {
    if (_line == nil) {
        _line = [UIView new];
        _line.backgroundColor = UIColorHex(#DB2D21);
        _line.hidden = true;
    }
    return _line;
}

@end
