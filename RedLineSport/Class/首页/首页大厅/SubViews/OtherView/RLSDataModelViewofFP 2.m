#import "RLSDataModelViewofFP.h"
@implementation RLSDataModelViewofFP
- (id)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if (self) {
        NSArray *arrTitle = [NSArray arrayWithObjects:@"亚指助手",@"指数异常",@"深度大小",@"历史同赔",@"爆冷指数",@"极限拐点",@"盘王指数",@"交易冷热",@"投注异常",@"更多", nil];
        for (int i = 0; i<arrTitle.count; i++) {
            CGFloat originX = 0;
            CGFloat originY = 0;
            if (i<5) {
                originY = 0;
                originX = Width/5*i;
            }else{
                originY = 82;
                originX = Width/5*(i-5);
            }
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(originX, originY, Width/5, 82);
            btn.tag = i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            UIImageView *imageV = [[UIImageView alloc] init];
            [btn addSubview:imageV];
            [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(btn.mas_top).offset(16);
                make.centerX.equalTo(btn.mas_centerX);
            }];
            UILabel *labTitle = [[UILabel alloc] init];
            labTitle.textColor = color33;
            labTitle.font = font10;
            [btn addSubview:labTitle];
            [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(btn.mas_top).offset(53);
                make.centerX.equalTo(btn.mas_centerX);
            }];
            labTitle.text = [arrTitle objectAtIndex:i ];
            imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"dataModel%d",i]];
        }
    }
    return self;
}
- (void)btnClick:(UIButton *)btn
{
    if (_delagate && [_delagate respondsToSelector:@selector(dataModelViewofFPDidSelectedAtIndex:)]) {
        [_delagate dataModelViewofFPDidSelectedAtIndex:btn.tag];
    }
}
@end
