#import "RLSTongpeiDTResultView.h"
@interface RLSTongpeiDTResultView()
@end
@implementation RLSTongpeiDTResultView
- (void)setModel:(RLSTongpeiDetailModel *)model
{
    _model = model;
    for (int i = 0; i<3; i++) {
        UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(Width/3*i, 0, Width/3, 16)];
        labTitle.font = font16;
        labTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labTitle];
        UILabel *labWin = [[UILabel alloc] initWithFrame:CGRectMake(Width/3*i, 17 + 7, Width/3, 12)];
        labWin.font = font12;
        labWin.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labWin];
        switch (i) {
            case 3:
            {
                if (_type == 0) {
                    labTitle.text = @"全赛事";
                    labWin.text = [NSString stringWithFormat:@"近%ld场",(long)_model.matchNum];
                }else{
                    labTitle.text = @"同赛事";
                    labWin.text = [NSString stringWithFormat:@"近%ld场",(long)_model.matchNum];
                }
                labTitle.textColor = color33;
                labWin.textColor = color99;
            }
                break;
            case 0:
            {
                labTitle.textColor = redcolor;
                labTitle.text =isNUll(_model.winRate)? @"0%": [NSString stringWithFormat:@"%@%%",_model.winRate];
                labWin.textColor = color99;
                labWin.text = isNUll(_model.winRateDesc)? @"赢0场": _model.winRateDesc;
            }
                break;
            case 1:
            {
                labTitle.textColor = bluecolor;
                labTitle.text =isNUll(_model.drawRate)? @"0%": [NSString stringWithFormat:@"%@%%",_model.drawRate];
                labWin.textColor = color99;
                labWin.text = isNUll(_model.drawRateDesc)?@"走0场": _model.drawRateDesc;
            }
                break;
            case 2:
            {
                labTitle.textColor = greencolor;
                labTitle.text = isNUll(_model.loseRate)?@"0%":[NSString stringWithFormat:@"%@%%",_model.loseRate];
                labWin.textColor = color99;
                labWin.text = isNUll(_model.loseRateDesc)?@"输0场":_model.loseRateDesc;
            }
                break;
            default:
                break;
        }
    }
}
@end
