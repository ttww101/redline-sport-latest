//
//  InputAccessoryView.m
//  GQZhiBo
//
//  Created by genglei on 2018/12/3.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "InputAccessoryView.h"

@interface InputAccessoryView ()

@end;

@implementation InputAccessoryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, Width, 36)];
    if (self) {
        [self configUI];
    }
    return self;
}

#pragma mark - Config UI

- (void)configUI {
    self.backgroundColor = UIColorHex(#F9F9F9);
    
    UIButton *emojiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    emojiBtn.frame = CGRectMake(15, 3, 30, 30);
    [emojiBtn setBackgroundImage:[UIImage imageNamed:@"emoji"] forState:UIControlStateNormal];
    [emojiBtn addTarget:self action:@selector(emojiAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:emojiBtn];
    
    UIButton *picBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    picBtn.frame = CGRectMake(60, 6, 33, 24);
    [picBtn setBackgroundImage:[UIImage imageNamed:@"pic"] forState:UIControlStateNormal];
    [picBtn addTarget:self action:@selector(picAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:picBtn];
}

#pragma mark - Events

- (void)emojiAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(InputAccessoryViewEmojiAction:)]) {
        [_delegate InputAccessoryViewEmojiAction:sender];
    }
}

- (void)picAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(InputAccessoryViewPicAction:)]) {
        [_delegate InputAccessoryViewPicAction:sender];
    }
}

@end
