//
//  VideoLoading.m
//  GQZhiBo
//
//  Created by genglei on 2019/1/29.
//  Copyright © 2019年 GQXX. All rights reserved.
//

#import "VideoLoading.h"

@implementation VideoLoading {
    BaseImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

#pragma mark - Config UI

- (void)configUI {
    self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6];
    _imageView = [[BaseImageView alloc] init];
    _imageView.animationImages = [self getImages];
    _imageView.animationRepeatCount = MAXFLOAT;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(210, 120));
    }];
}

- (NSArray *)getImages {
    NSMutableArray *images = [NSMutableArray array];
    for (NSInteger i = 0; i < 48; i++) {
        NSString *imageName = [NSString stringWithFormat:@"banner_0000%zi.png",i];
        [images addObject:[UIImage imageNamed:imageName]];
    }
    return [images copy];
}

- (void)startAnimation {
    [_imageView startAnimating];
}

- (void)dismiss {
    [_imageView stopAnimating];
    [self removeFromSuperview];
}


@end
