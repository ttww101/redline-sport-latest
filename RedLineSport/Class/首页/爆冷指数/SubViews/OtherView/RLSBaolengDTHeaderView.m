#import "RLSBaolengDTHeaderView.h"
@implementation RLSBaolengDTHeaderView
- (void)setModel:(RLSBaolengDTModel *)model
{
    _model = model;
    for (int i = 0; i<3; i++) {
        UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(Width/3*i, 0, Width/3, 20)];
        labTitle.font = font23;
        labTitle.textColor = redcolor;
        labTitle.textAlignment = NSTextAlignmentCenter;
        labTitle.text = @"52.4%";
        [self addSubview:labTitle];
        UILabel *labWin = [[UILabel alloc] initWithFrame:CGRectMake(Width/3*i, 20 + 5, Width/3, 20)];
        labWin.font = font12;
        labWin.textColor = color99;
        labWin.textAlignment = NSTextAlignmentCenter;
        labWin.text = @"爆冷指数";
        [self addSubview:labWin];
        switch (i) {
            case 0:
            {
                labTitle.text = [NSString stringWithFormat:@"%ld%%",_model.sort];
                labTitle.textColor = redcolor;
                labWin.textColor = color99;
                [labTitle setAttributedText:[RLSMethods withContent:labTitle.text WithColorText:@"%" textColor:labTitle.textColor strFont:font12]];
            }
                break;
            case 1:
            {
                labTitle.textColor = color33;
                labTitle.text = [NSString stringWithFormat:@"%ld场",_model.mostresult];
                labTitle.attributedText  = [RLSMethods withContent:labTitle.text WithColorText:@"场" textColor:color33 strFont:font12];
                labWin.textColor = color99;
                labWin.text = @"距上次爆冷";
            }
                break;
            case 2:
            {
                labTitle.textColor = color33;
                labTitle.text =[NSString stringWithFormat:@"%ld场",_model.historyresult];
                labTitle.attributedText  = [RLSMethods withContent:labTitle.text WithColorText:@"场" textColor:color33 strFont:font12];
                labWin.textColor = color99;
                labWin.text = @"最长不爆";
            }
                break;
            default:
                break;
        }
    }
}
@end
