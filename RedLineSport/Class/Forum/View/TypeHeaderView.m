//
//  TypeHeaderView.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/22.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "TypeHeaderView.h"

@interface TypeHeaderView ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) BaseImageView *topIV;
@property (nonatomic, strong) UIView *spaceView;

@end

@implementation TypeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)layoutSubviews {
    self.lineView.frame = CGRectMake(0, self.height - ONE_PX_LINE, self.width, ONE_PX_LINE);
}

#pragma mark - Setter


- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    if (_dataSource.count > 0) {
        for (NSInteger i =0; i < _dataSource.count; i++) {
            ItemView *item = [[ItemView alloc]initWithFrame:CGRectMake(0, self.topIV.bottom + i * 60, self.width, 60)];
            item.model = dataSource[i];
            [self addSubview:item];
        }
        self.topIV.hidden = false;
    } else {
        self.topIV.hidden = true;
    }
   
    
}

- (void)setModelInfo:(ModulesInfo *)modelInfo {
    _modelInfo = modelInfo;
}

#pragma mark - Config UI

- (void)configUI {
//    self.backgroundColor = UIColorHex(#EBEBEB);
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.lineView];
    [self addSubview:self.spaceView];
    [self addSubview:self.topIV];
}

#pragma mark - Lazy Load

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectZero];
        _lineView.backgroundColor = UIColorHex(#eeeeee);
    }
    return _lineView;
}

- (UIView *)spaceView {
    if (_spaceView == nil) {
        _spaceView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topIV.top, self.width, self.topIV.height)];
        _spaceView.backgroundColor = [UIColor whiteColor];
    }
    return _spaceView;
}


- (BaseImageView *)topIV {
    if (_topIV == nil) {
        _topIV = [[BaseImageView alloc]initWithFrame:CGRectMake(0, Scale_Value(135), 71, 26)];
        _topIV.contentMode = UIViewContentModeScaleAspectFit;
        _topIV.clipsToBounds = true;
        _topIV.image = [UIImage imageNamed:@"Top"];
    }
    return _topIV;
}

@end
