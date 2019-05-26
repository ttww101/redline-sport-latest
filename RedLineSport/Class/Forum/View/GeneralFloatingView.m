
//
//  GeneralFloatingView.m
//  GQZhiBo
//
//  Created by genglei on 2018/12/3.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "GeneralFloatingView.h"

@interface GeneralFloatingView ()

@property (nonatomic, copy) NSArray *imagesPath;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) BOOL ignoreTab;


@end

@implementation GeneralFloatingView

- (instancetype)initWithImages:(NSArray *)images
                         scale:(CGFloat)scale
                  ignoreTabBar:(BOOL)isIgnoreTabBar {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _imagesPath = [images copy];
        _scale = scale;
        _ignoreTab = isIgnoreTabBar;
        [self configUI];
    }
    return self;
}

#pragma mark - Config UI

- (void)configUI {
    CGPoint origin  = self.origin;
    CGSize size = self.size;
    origin.x = Width * _scale;
    origin.y = (_ignoreTab ? (Height - 41 * _imagesPath.count - 49) : Height) * _scale;
    size.width = 41;
    size.height = _imagesPath.count * 41;
    self.origin = origin;
    self.size = size;
    self.backgroundColor = [UIColor clearColor];
    [self removeAllSubViews];
    for (NSInteger i = 0; i < _imagesPath.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:_imagesPath[i]] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, i * (41 + 5), 41, 41);
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == _imagesPath.count - 1) {
            self.height = btn.bottom;
        }
        btn.tag = i;
        [self addSubview:btn];
    }
}

#pragma mark - Events

- (void)btnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(floatingViewDidSelected:)]) {
        [_delegate floatingViewDidSelected:sender.tag];
    }
}


@end
