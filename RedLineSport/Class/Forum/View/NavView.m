//
//  NavView.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/22.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "NavView.h"

@interface NavView()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic , strong) UILabel *title;

@end

@implementation NavView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, Width, 64)];
    if (self) {
        [self configUI];
    }
    return self;
}

#pragma mark -

- (void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    self.title.text = _navTitle;
}

#pragma mark - Config UI

- (void)configUI {
    [self addSubview:self.lineView];
    self.backgroundColor = redcolor;
    [self addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(30);
        make.left.equalTo(self.mas_left).offset(30);
        make.right.equalTo(self.mas_right).offset(-30);
    }];
}

#pragma mark - Lazy Load

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - ONE_PX_LINE, self.width, ONE_PX_LINE)];
        _lineView.backgroundColor = UIColorHex(#eeeeee);
    }
    return _lineView;
}

- (UILabel *)title {
    if (_title  == nil) {
        _title = [UILabel new];
        _title.textColor = [UIColor whiteColor];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont systemFontOfSize:17.0];
        _title.adjustsFontSizeToFitWidth = true;
    }
    return _title;
}

@end
