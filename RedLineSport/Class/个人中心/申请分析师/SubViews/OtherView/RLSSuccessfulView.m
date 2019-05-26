#import "RLSSuccessfulView.h"
@implementation RLSSuccessfulView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.img];
        [self addSubview:self.labSucc];
        [self addSubview:self.labContent];
        [self addSubview:self.btn];
        [self subAotoMasnary];
    }
    return self;
}
- (void)tapClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(backView)]) {
        [self.delegate backView];
    }
}
- (UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] init];
        _img.image = [UIImage imageNamed:@"successful"];
    }
    return _img;
}
- (UILabel *)labSucc{
    if (!_labSucc) {
        _labSucc = [[UILabel alloc] init];
        _labSucc.font = font16;
        _labSucc.textColor = color33;
    }
    return _labSucc;
}
- (UILabel *)labContent{
    if (!_labContent) {
        _labContent = [[UILabel alloc] init];
        _labContent.font = font14;
        _labContent.textColor = color99;
    }
    return _labContent;
}
- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitleColor:color33 forState:UIControlStateNormal];
        _btn.titleLabel.font = font14;
        [_btn addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}
- (UILabel *)labContentTwo{
    if (!_labContentTwo) {
        _labContentTwo = [[UILabel alloc] init];
        _labContentTwo.font = font12;
        _labContentTwo.textColor = color99;
    }
    return _labContentTwo;
}
- (void)subAotoMasnary{
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(30);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.labSucc.mas_top).offset(-20);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    [self.labSucc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.img.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.img.mas_centerX);
        make.bottom.mas_equalTo(self.labContent.mas_top).offset(-10);
    }];
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labSucc.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.img.mas_centerX);
    }];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labContent.mas_left).offset(95);
        make.centerY.mas_equalTo(self.labContent.mas_centerY);
    }];
}
@end
