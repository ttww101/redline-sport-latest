#import "RLSHSJFoldHeaderView.h"
@implementation RLSHSJFoldHeaderView {
    BOOL _created;
    UIView *_lineView;
    UILabel *_titleLabel;
    UILabel *_detailLabel;
    UIImageView *_imageView;
    UIButton *_btn;
    UIImageView *_roView;
    UIImageView *_line;
    BOOL _canFold;
}
- (void)setFoldSectionHeaderViewWithTitle:(NSString *)title detail:(NSString *)detail type:(HerderStyle)type section:(NSInteger)section canFold:(BOOL)canFold {
    if (!_created) {
        [self creatUI];
    }
    _titleLabel.text = title;
    if (self.titleColor) {
        _titleLabel.textColor = self.titleColor;
    }
    if (type == HerderStyleNone) {
        _detailLabel.hidden = YES;
    } else {
        _detailLabel.hidden = NO;
        _detailLabel.attributedText = [self attributeStringWith:detail];
    }
    _section = section;
    _canFold = canFold;
    if (canFold) {
        _imageView.hidden = NO;
    } else {
        _imageView.hidden = YES;
    }
}
- (NSMutableAttributedString *)attributeStringWith:(NSString *)money {
    NSString *str = [NSString stringWithFormat:@"%@", money];
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range = [str rangeOfString:money];
    [ats setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:range];
    return ats;
}
- (void)creatUI {
    _created = YES;
    _lineView = [UIView new];
    _lineView.hidden = YES;
    [self.contentView addSubview:_lineView];
    _lineView.backgroundColor = [UIColor orangeColor];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.leading.equalTo(self.contentView).offset(15);
        make.width.mas_equalTo(2);
        make.height.mas_equalTo(22);
    }];
    _titleLabel = [UILabel new];
    _titleLabel.font = font14;
        _titleLabel.textColor = self.titleColor;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(10);
        if (_YLineHided == NO) {
            make.leading.equalTo(_lineView.mas_trailing).offset(10);
        }
            make.leading.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
    }];
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _roView = [UIImageView new];
    _roView.animationImages = [NSArray arrayWithObjects:[[UIImage imageNamed:@"clear"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],[UIImage imageNamed:@"redRound"], nil];
    _roView.animationDuration = 1;
    _roView.animationRepeatCount = MAXFLOAT;
    _roView.hidden = YES;
        [self.contentView addSubview:_roView];
        [_roView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_titleLabel.mas_top);
            make.size.mas_equalTo(CGSizeMake(6, 6));
            make.centerX.equalTo(_titleLabel.mas_trailing).offset(4);
        }];
    [_roView startAnimating];
    _detailLabel = [UILabel new];
    _detailLabel.font = font14;
    [self.contentView addSubview:_detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLabel);
        make.leading.equalTo(_titleLabel.mas_trailing);
        make.width.mas_equalTo(120);
    }];
    UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClick:)];
    [self addGestureRecognizer:tapges];
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_btn];
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(_detailLabel);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    _imageView = [UIImageView new];
    _imageView.image = [UIImage imageNamed:@"tuijianRule1"];
    [self.contentView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(_btn);
        make.size.mas_equalTo(CGSizeMake(18, 10));
    }];
     _line= [[UIImageView alloc] init];
    [self.contentView addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(16);
        make.width.mas_equalTo(Width);
        make.height.mas_equalTo(1);
    }];
}
- (void)setFold:(BOOL)fold {
    _fold = fold;
    if (fold) {
        if (self.isRedRo) {
            _imageView.image = [UIImage imageNamed:@"btnarrows"];
        }else{
            _imageView.image = [UIImage imageNamed:@"tuijianRule2"];
        }
    } else {
        if (self.isRedRo) {
            _imageView.image = [UIImage imageNamed:@"btnarrows2"];
        }else{
            _imageView.image = [UIImage imageNamed:@"tuijianRule1"];
        }
    }
}
- (void)setYLineHided:(BOOL)YLineHided {
    _YLineHided = YLineHided;
    if (YLineHided == NO) {
        _lineView.hidden = NO;
    }else{
        _lineView.hidden = YES;
    }
}
- (void)setRightViewHided:(BOOL)rightViewHided {
    _rightViewHided = rightViewHided;
    if (rightViewHided == YES) {
        _imageView.hidden = YES;
    }
}
- (void)setLineHided:(BOOL)lineHided {
    _lineHided = lineHided;
    if (lineHided) {
        _line.hidden = lineHided;
    }
}
- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    if (titleColor) {
        _titleLabel.textColor = titleColor;
    }else{
        _titleLabel.textColor = color52;
    }
}
- (void)setBackGrColor:(UIColor *)backGrColor {
    _backGrColor = backGrColor;
    if (backGrColor) {
        self.backgroundColor = backGrColor;
    }else{
        self.backgroundColor = colorfbfafa;
    }
}
- (void)setRoViewHided:(BOOL)roViewHided {
    _roViewHided = roViewHided;
    if (roViewHided == NO) {
        _roView.hidden = NO;
    }
    else{
        _roView.hidden = YES;
    }
}
- (void)setClickView:(UIImage *)clickView {
    _clickView = clickView;
    if (clickView) {
        _imageView = [[UIImageView alloc] initWithImage:clickView];
    }
}
#pragma mark - 按钮点击事件 -
- (void)btnClick:(UIButton *)btn {
    if (_canFold) {
        if ([self.delegate respondsToSelector:@selector(foldHeaderInSection:)]) {
            [self.delegate foldHeaderInSection:_section];
        }
    }
}
@end
