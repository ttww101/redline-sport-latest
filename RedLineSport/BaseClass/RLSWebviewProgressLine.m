#import "RLSWebviewProgressLine.h"
@implementation RLSWebviewProgressLine
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = UIColorFromRGBWithOX(0x37B1DA);
    }
    return self;
}
-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    self.backgroundColor = lineColor;
}
-(void)startLoadingAnimation{
    self.hidden = NO;
    self.width = 0.0;
    __weak UIView *weakSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.width = Width * 0.6;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.width = Width * 0.8;
        }];
    }];
}
-(void)endLoadingAnimation{
    __weak UIView *weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.width = Width;
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
        weakSelf.width = 0;
    }];
}
@end
