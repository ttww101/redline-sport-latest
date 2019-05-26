//
//  ToolControl.m
//  GQZhiBo
//
//  Created by genglei on 2019/1/20.
//  Copyright © 2019年 GQXX. All rights reserved.
//

#import "ToolControl.h"

@interface ToolControl ()


@end

@implementation ToolControl {
    
}

- (instancetype)initWithFrame:(CGRect)frame itemDic:(NSDictionary *)dic {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        BaseImageView *icon = [[BaseImageView alloc]initWithImage:[UIImage imageNamed:dic[@"icon"]]];
        icon.layer.masksToBounds = true;
        icon.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).offset(5);
        }];
        
        UILabel *lab = [UILabel new];
        lab.attributedText = dic[@"title"];
        [self addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
        
        UILabel *cycleLab = [UILabel new];
        cycleLab.backgroundColor = UIColorHex(#F5312E);
        cycleLab.layer.cornerRadius = 5;
        cycleLab.layer.masksToBounds = true;
        cycleLab.hidden = ![dic[@"newValue"] integerValue];
        [self addSubview:cycleLab];
        [cycleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(2);
            make.right.equalTo(self.mas_right).offset(-27);
            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
    }
    return  self;
}

@end
