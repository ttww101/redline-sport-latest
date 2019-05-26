#import "RLSItemControl.h"
@implementation RLSItemControl {
    NSString *_imageName;
    NSString *_title;
}
- (instancetype)initWithFrame:(CGRect)frame
                    imageName:(NSString *)imageName
                        title:(NSString *)title
                       amount:(NSString *)amount hidenLine:(BOOL)hide{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        _imageName = [imageName copy];
        _title = [title copy];
        
        
        
        UIImageView *iconImageView = [UIImageView new];
        iconImageView.image = [UIImage imageNamed:_imageName];
        [self addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
            make.size.mas_equalTo(CGSizeMake(14, 14));
            make.left.equalTo(self.mas_left).offset(26);
        }];
        
        
        UILabel *label = [[UILabel alloc]init];
        label.text = _title;
        label.font = font12;
        label.textColor = UIColorFromRGBWithOX(0x323232);
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
            make.left.equalTo(iconImageView.mas_right).offset(4);
        }];
        
        UIImageView *lineView = [[UIImageView alloc]init];
        lineView.backgroundColor = UIColorFromRGBWithOX(0xD8D8D8);
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top).offset(12);
            make.bottom.equalTo(self.mas_bottom).offset(-12);
            make.width.mas_equalTo(1);
        }];
        
        lineView.hidden = hide;
        
        UILabel *amountLabel = [[UILabel alloc]init];
        amountLabel.text = amount;
        amountLabel.font = font14;
        amountLabel.textColor = UIColorFromRGBWithOX(0x101010 );
        amountLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:amountLabel];
        [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.left.equalTo(label.mas_left);
        }];
    }
    return self;
}
@end
