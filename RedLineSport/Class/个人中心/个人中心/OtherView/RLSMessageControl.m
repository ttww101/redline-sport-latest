#import "RLSMessageControl.h"
@implementation RLSMessageControl
- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                       amount:(NSString *)content {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *amountLabel = [[UILabel alloc]init];
        amountLabel.text = content;
        amountLabel.font = [UIFont boldSystemFontOfSize:13.f];
        amountLabel.textColor = UIColorFromRGBWithOX(0x333333);
        amountLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:amountLabel];
        [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(0);
            make.centerX.equalTo(self.mas_centerX);
        }];
        UILabel *label = [[UILabel alloc]init];
        label.text = title;
        label.font = font14;
        label.textColor = UIColorFromRGBWithOX(0x666666);
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-20);
            make.centerX.equalTo(self.mas_centerX);
        }];
    }
    return self;
}
@end
