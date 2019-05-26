#import "RLSBisaiTHeaderFenxiView.h"
@implementation RLSBisaiTHeaderFenxiView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (void)setModel:(RLSTechtwoModel *)model
{
    _model = model;
    for (int i = 0; i<4; i++) {
        if (_ishome == 0) {
            UIView *basicV = [[UIView alloc] initWithFrame:CGRectMake(self.width/4*i, 0, self.width/4, self.height)];
            [self addSubview:basicV];
            if (i == 3) {
                UILabel *labT = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, basicV.width, basicV.height/2)];
                labT.textAlignment = NSTextAlignmentCenter;
                labT.font = font12;
                labT.textColor = color33;
                labT.text = _model.shotsOn;
                [basicV addSubview:labT];
            }else{
                UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
                imageV.center = CGPointMake(basicV.width/2, basicV.height/4);
                imageV.image = [UIImage imageNamed:@"bisaiJiaoqiu"];
                [basicV addSubview:imageV];
                switch (i) {
                    case 0:
                    {
                        imageV.image = [UIImage imageNamed:@"bisaiJiaoqiu"];
                    }
                        break;
                    case 1:
                    {
                        imageV.image = [UIImage imageNamed:@"bisairedCard"];
                    }
                        break;
                    case 2:
                    {
                        imageV.image = [UIImage imageNamed:@"bisaiyellowCard"];
                    }
                        break;
                    default:
                        break;
                }
            }
            UILabel *labText = [[UILabel alloc] initWithFrame:CGRectMake(0, basicV.height/2, basicV.width, basicV.height/2)];
            labText.textAlignment = NSTextAlignmentCenter;
            labText.font = font12;
            labText.textColor = color33;
            labText.text = @"7";
            [basicV addSubview:labText];
            switch (i) {
                case 0:
                    labText.text = _model.cornerkick;
                    break;
                case 1:
                    labText.text = _model.redCard;
                    break;
                case 2:
                    labText.text = _model.yellowCard;
                    break;
                case 3:
                    labText.text = _model.shotsNotOn;
                    break;
                default:
                    break;
            }
        }else{
            UIView *basicV = [[UIView alloc] initWithFrame:CGRectMake(self.width/4*i, 0, self.width/4, self.height)];
            [self addSubview:basicV];
            if (i == 0) {
                UILabel *labT = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, basicV.width, basicV.height/2)];
                labT.textAlignment = NSTextAlignmentCenter;
                labT.font = font12;
                labT.textColor = color33;
                labT.text = _model.shotsOn;
                [basicV addSubview:labT];
            }else{
                UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
                imageV.center = CGPointMake(basicV.width/2, basicV.height/4);
                imageV.image = [UIImage imageNamed:@"bisaiJiaoqiu"];
                [basicV addSubview:imageV];
                switch (i) {
                    case 3:
                    {
                        imageV.image = [UIImage imageNamed:@"bisaiJiaoqiu"];
                    }
                        break;
                    case 2:
                    {
                        imageV.image = [UIImage imageNamed:@"bisairedCard"];
                    }
                        break;
                    case 1:
                    {
                        imageV.image = [UIImage imageNamed:@"bisaiyellowCard"];
                    }
                        break;
                    default:
                        break;
                }
            }
            UILabel *labText = [[UILabel alloc] initWithFrame:CGRectMake(0, basicV.height/2, basicV.width, basicV.height/2)];
            labText.textAlignment = NSTextAlignmentCenter;
            labText.font = font12;
            labText.textColor = color33;
            labText.text = @"7";
            [basicV addSubview:labText];
            switch (i) {
                case 3:
                    labText.text = _model.cornerkick;
                    break;
                case 2:
                    labText.text = _model.redCard;
                    break;
                case 1:
                    labText.text = _model.yellowCard;
                    break;
                case 0:
                    labText.text = _model.shotsNotOn;
                    break;
                default:
                    break;
            }
        }
    }
}
@end
