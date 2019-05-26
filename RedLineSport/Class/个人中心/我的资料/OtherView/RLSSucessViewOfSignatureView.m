#import "RLSSucessViewOfSignatureView.h"
@interface RLSSucessViewOfSignatureView()
@property (nonatomic, strong)UIImageView *img;
@property (nonatomic, strong)UILabel *labSucc;
@property (nonatomic, strong)UILabel *labContent;
@end
@implementation RLSSucessViewOfSignatureView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.img];
        [self addSubview:self.labSucc];
        [self addSubview:self.labContent];
        [self subAotoMasnary];
        NSString *seconds = [NSString stringWithFormat:@"%d秒",3];
        _labContent.text = [NSString stringWithFormat:@"%@后返回",seconds];
        _labContent.attributedText = [RLSMethods withContent:_labContent.text WithColorText:seconds textColor:redcolor strFont:font14];
    }
    return self;
}
- (void)sucessBack:(void(^)(BOOL sucessed))block
{
    __block int  i = 0;
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (i==3) {
            block(YES);
            [timer invalidate];
        }
        NSString *seconds = [NSString stringWithFormat:@"%d秒",2-i];
        _labContent.text = [NSString stringWithFormat:@"%@后返回",seconds];
        _labContent.attributedText = [RLSMethods withContent:_labContent.text WithColorText:seconds textColor:redcolor strFont:font14];
        i++;
    }];
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
        _labSucc.text = @"个性签名提交成功";
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
- (void)subAotoMasnary{
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(30);
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.labSucc.mas_top).offset(-20);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    [self.labSucc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img.mas_bottom).offset(20);
        make.centerX.equalTo(self.img.mas_centerX);
        make.bottom.equalTo(self.labContent.mas_top).offset(-10);
    }];
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labSucc.mas_bottom).offset(10);
        make.centerX.equalTo(self.img.mas_centerX);
    }];
}
@end
