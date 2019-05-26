#import "RLSDCindexBtn.h"
@interface RLSDCindexBtn()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIImageView *imgScroll;
@property (nonatomic, strong) UIView *basicView;
@end
@implementation RLSDCindexBtn
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imgScroll];
        NSLog(@"%@",self.gestureRecognizers);
    }
    return self;
}
- (void)touchTap
{
}
- (UIImageView *)imgScroll
{
    if (!_imgScroll) {
        _imgScroll = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _imgScroll.image = [UIImage imageNamed:@"bifenScroll"];
        _imgScroll.userInteractionEnabled = YES;
        UIPanGestureRecognizer *Pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        Pan.delegate = self;
        [Pan setMaximumNumberOfTouches:1];
        [_imgScroll addGestureRecognizer:Pan];
    }
    return _imgScroll;
}
- (void)updateScrollFrame:(CGFloat)frameY
{
    if (!_stopDelegateChangeBtnFrame) {
        _imgScroll.frame = CGRectMake(0, (self.height - 50)*frameY, 50, 50);
    }
}
- (void)updateScrollBySelfFrame:(CGFloat)frameY
{
    _imgScroll.frame = CGRectMake(0, frameY, 50, 50);
}
- (void)panAction:(UIPanGestureRecognizer*)pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            _stopDelegateChangeBtnFrame = YES;
            NSLog(@"UIGestureRecognizerStateBegan");
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            NSLog(@"UIGestureRecognizerStateChanged");
            _stopDelegateChangeBtnFrame = YES;
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"UIGestureRecognizerStateEnded");
            _stopDelegateChangeBtnFrame = NO;
            [self performSelector:@selector(hideSelf) withObject:nil afterDelay:2];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            NSLog(@"UIGestureRecognizerStateCancelled");
            _stopDelegateChangeBtnFrame = YES;
        }
            break;
        default:
            break;
    }
    CGPoint point = [pan locationInView:self];
    static CGFloat lastY ;
    lastY = point.y;
    NSLog(@"%f",lastY);
    if (lastY>self.height - 50 ) {
        lastY =self.height - 50;
    }
    if (lastY <0) {
        lastY = 0;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(scrollToScale:)]) {
        [_delegate scrollToScale:lastY/(self.height - 50)];
    }
    [self updateScrollBySelfFrame:lastY];
}
- (void)hideSelf
{
    self.hidden = YES;
}
@end
