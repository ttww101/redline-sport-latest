//
//  ItemCell.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/21.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ItemCell.h"

@interface ItemCell()

@property (nonatomic, strong) BaseImageView *iconIV;
@property (nonatomic , strong) UILabel *topic;
@property (nonatomic , strong) UILabel *topicCountLab;


@end

@implementation ItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

#pragma mark Setter

- (void)setModel:(ModulesInfo *)model {
    _model = model;
    [self.iconIV setImageWithUrl:[NSURL URLWithString:PARAM_IS_NIL_ERROR(model.icon)] placeholder:nil];
    self.topic.text = model.name;
    self.topicCountLab.text = [NSString stringWithFormat:@"%@帖子",model.count];
}

#pragma mark - Config UI

- (void)configUI {
    [self.contentView addSubview:self.iconIV];
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 36));
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    [self.contentView addSubview:self.topic];
    [self.topic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconIV.mas_bottom).offset(3);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    [self.contentView addSubview:self.topicCountLab];
    [self.topicCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topic.mas_bottom).offset(3);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.left.right.equalTo(self).offset(0);
    }];
}

#pragma mark - Lazy Load

- (BaseImageView *)iconIV {
    if (_iconIV == nil) {
        _iconIV = [BaseImageView new];
        _iconIV.contentMode = UIViewContentModeScaleAspectFill;
        _iconIV.image = [UIImage imageNamed:@"test"];
    }
    return _iconIV;
}

- (UILabel *)topic {
    if (_topic == nil) {
        _topic = [UILabel new];
        _topic.font = [UIFont systemFontOfSize:11.f];;
        _topic.textColor = UIColorFromRGBWithOX(0x343434);
        _topic.text = @"足彩讨论";
        _topic.textAlignment = NSTextAlignmentCenter;
    }
    return _topic;
}

- (UILabel *)topicCountLab {
    if (_topicCountLab == nil) {
        _topicCountLab = [UILabel new];
        _topicCountLab.font = [UIFont systemFontOfSize:11.f];;
        _topicCountLab.textColor = UIColorFromRGBWithOX(0x878787);
        _topicCountLab.text = @"120";
        _topicCountLab.textAlignment = NSTextAlignmentCenter;
    }
    return _topicCountLab;
}

@end
