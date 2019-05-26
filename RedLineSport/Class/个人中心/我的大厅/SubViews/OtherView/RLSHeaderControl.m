#import "RLSHeaderControl.h"
@interface RLSHeaderControl ()
@property (nonatomic , strong) UILabel *label;
@end
@implementation RLSHeaderControl {
    NSString *_content;
}
- (instancetype)initWithFrame:(CGRect)frame
                      content:(NSString *)content showRightLine:(BOOL)show {
    self = [super initWithFrame:frame];
    if (self) {
        _content = content;
        _label = [[UILabel alloc]init];
        _label.text = _content;
        _label.font = font13;
        _label.textColor = UIColorFromRGBWithOX(0xffffff);
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
        }];
        UIImageView *lineView = [[UIImageView alloc]init];
        lineView.backgroundColor = [UIColor whiteColor];
        lineView.hidden = show;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top).offset(8);
            make.bottom.equalTo(self.mas_bottom).offset(-8);
            make.width.mas_equalTo(1);
        }];
    }
    return self;
}
- (void)setContent:(NSString *)content {
    NSArray *strArray = [content componentsSeparatedByString:@":"];
    NSString *lastStr = [strArray lastObject];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:content];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:[content rangeOfString:content]];
    [att addAttribute:NSFontAttributeName value:font13 range:[content rangeOfString:content]];
    [att addAttribute:NSFontAttributeName value:font15 range:[content rangeOfString:lastStr]];
    _label.attributedText = att;
}
@end
