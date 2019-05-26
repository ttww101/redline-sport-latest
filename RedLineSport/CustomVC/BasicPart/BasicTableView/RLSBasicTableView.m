#import "RLSBasicTableView.h"
@interface RLSBasicTableView()
@property (nonatomic, strong)UITableViewCell *seleCell;
@end
@implementation RLSBasicTableView
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.defaultTitle = @"暂无数据";
    }
    return self;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
    {
        return [UIImage imageNamed:@"d1"];
    }
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
    {
        NSLog(@"imageAnimationForEmptyDataSet");
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
        animation.duration = 0.25;
        animation.cumulative = YES;
        animation.repeatCount = MAXFLOAT;
        return animation;
    }
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
    {
        NSString *text = default_noMatch;
        NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{ return [UIColor clearColor];}
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return YES;
}
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    return YES;
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView{ 
}
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView{ 
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    CGPoint point = [scrollView.panGestureRecognizer locationInView:self];
    NSIndexPath * indexPath = [self indexPathForRowAtPoint:point];
    _seleCell=[self cellForRowAtIndexPath:indexPath];
    _seleCell.backgroundColor = colorF5;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _seleCell.backgroundColor = [UIColor whiteColor];
}
@end
