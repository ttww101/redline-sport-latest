#import "RLSUserTuijianNumView.h"
@implementation RLSUserTuijianNumView
- (void)setModel:(RLSUserTongjiModel *)model
{
    _model = model;
    [self removeAllSubViews];
    for (int i = 0; i<3; i++) {
        UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 6 + 32*i, self.width, 22)];
        labTitle.font = font12;
        labTitle.textColor = color99;
        [self addSubview:labTitle];
        NumViewUserTuijian *numV = [[NumViewUserTuijian alloc] initWithFrame:CGRectMake( 0, 28 + i*32, self.width, 4)];
        numV.backgroundColor = [UIColor whiteColor];
        switch (i) {
            case 0:
            {
                labTitle.text = [NSString stringWithFormat:@"赢%ld场",(long)_model.winNum];
                [labTitle setAttributedText:[RLSMethods withContent:labTitle.text WithColorText:[NSString stringWithFormat:@"%ld",(long)_model.winNum] textColor:redcolor strFont:font12]];
                numV.scaleColor = redcolor;
                numV.scaleNum =_model.totalNum<=0? 0: _model.winNum/(CGFloat)_model.totalNum;
            }
                break;
            case 1:
            {
                labTitle.text = [NSString stringWithFormat:@"走%ld场",(long)_model.goNum];
                [labTitle setAttributedText:[RLSMethods withContent:labTitle.text WithColorText:[NSString stringWithFormat:@"%ld",(long)_model.goNum] textColor:redcolor strFont:font12]];
                numV.scaleColor = colorFEC231;
                numV.scaleNum =_model.totalNum<=0? 0: _model.goNum/(CGFloat)_model.totalNum;
            }
                break;
            case 2:
            {
                labTitle.text = [NSString stringWithFormat:@"输%ld场",(long)_model.loseNum];
                [labTitle setAttributedText:[RLSMethods withContent:labTitle.text WithColorText:[NSString stringWithFormat:@"%ld",(long)_model.loseNum] textColor:redcolor strFont:font12]];
                numV.scaleColor = greencolor;
                numV.scaleNum =_model.totalNum<=0? 0: _model.loseNum/(CGFloat)_model.totalNum;
            }
                break;
            default:
                break;
        }
        [self addSubview:numV];
    }
}
@end
@interface NumViewUserTuijian ()
@end
@implementation NumViewUserTuijian
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.height/2];
    [colorEE set];
    [path1 fill];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, rect.size.width*_scaleNum, rect.size.height) cornerRadius:self.height/2];
    [_scaleColor set];
    [path2 fill];
}
@end
