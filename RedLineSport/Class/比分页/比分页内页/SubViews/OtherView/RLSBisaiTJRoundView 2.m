#import "RLSBisaiTJRoundView.h"
@implementation RLSBisaiTJRoundView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    [self setClearsContextBeforeDrawing:YES];
        CGFloat persent = _roundData;
        if (persent<0) {
            persent = 0;
        }else if(persent >100){
            persent = 100;
        }else if (persent<1){
            persent = 1;
        }
        CGFloat startAngle1 = persent/100*M_PI*2;
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, colorEE.CGColor);
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetLineWidth(context, 3.0);
        CGContextAddArc(context, self.width/2,self.height/2, self.width/2-2, 0, startAngle1, 0);
        CGContextDrawPath(context, kCGPathFillStroke);
        CGContextSetStrokeColorWithColor(context, redcolor.CGColor);
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetLineWidth(context, 3.0);
        CGContextAddArc(context, self.width/2,self.height/2, self.width/2-2, startAngle1, M_PI*2, 0);
        CGContextDrawPath(context, kCGPathStroke);
    self.transform = CGAffineTransformMakeRotation(-M_PI/2);
}
@end
